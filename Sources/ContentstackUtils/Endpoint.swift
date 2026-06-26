import Foundation

/// Resolves Contentstack API endpoints for any region and service.
///
/// ## Data loading — three layers
///
/// 1. **In-memory cache** — zero I/O; lives for the process lifetime.
/// 2. **Bundled `regions.json`** — present when `Scripts/download-regions.sh` was run before
///    building. After serving from this layer, a background network refresh fires so the cache
///    stays current without blocking the caller.
/// 3. **Live HTTP download** — fallback when the bundle resource is absent (e.g. fresh
///    dependency install without running the script).
///
/// The background refresh means: once the first call returns, subsequent calls within the same
/// process will automatically use the latest Contentstack region data, even if the bundled file
/// was built from an older snapshot.
///
/// ```swift
/// // Full URL
/// let url = try Endpoint.getContentstackEndpoint("eu", "contentDelivery")
/// // "https://eu-cdn.contentstack.com"
///
/// // Host only (for SDK setHost)
/// let host = try Endpoint.getContentstackEndpoint("eu", "contentDelivery", true)
/// // "eu-cdn.contentstack.com"
///
/// // All endpoints for a region
/// let all = try Endpoint.getContentstackEndpoint("eu") as! [String: String]
/// ```
public struct Endpoint {

    // Search all loaded bundles for regions.json. Works in SPM (swift test/build),
    // Xcode Package scheme, and Xcode framework builds without relying on Bundle.module,
    // which is only synthesised when the SPM command-line build system processes Package.swift.
    private static func bundledRegionsURL() -> URL? {
        (Bundle.allBundles + Bundle.allFrameworks)
            .lazy
            .compactMap { $0.url(forResource: "regions", withExtension: "json") }
            .first
    }

    // MARK: - Error type

    public enum EndpointError: LocalizedError {
        case emptyRegion
        case invalidRegion(String)
        case serviceNotFound(String, String)
        case regionsDataUnavailable
        case invalidRegionsData

        public var errorDescription: String? {
            switch self {
            case .emptyRegion:
                return "Empty region provided. Please put valid region."
            case .invalidRegion(let r):
                return "Invalid region: \(r)"
            case .serviceNotFound(let s, let r):
                return "Service \"\(s)\" not found for region \"\(r)\""
            case .regionsDataUnavailable:
                return "contentstack/utils: regions.json is unavailable and could not be downloaded. " +
                       "Run Scripts/download-regions.sh or ensure network access."
            case .invalidRegionsData:
                return "contentstack/utils: regions.json is corrupt or invalid. " +
                       "Run Scripts/download-regions.sh to re-download it."
            }
        }
    }

    // MARK: - Thread-safe cache

    private static let lock = NSLock()
    private static var _cachedRegions: [[String: Any]]? = nil
    private static var _refreshTask: URLSessionDataTask? = nil

    private static var cachedRegions: [[String: Any]]? {
        get { lock.lock(); defer { lock.unlock() }; return _cachedRegions }
        set { lock.lock(); defer { lock.unlock() }; _cachedRegions = newValue }
    }

    private static let regionsURL = "https://artifacts.contentstack.com/regions.json"

    // MARK: - Public API

    /// Returns the Contentstack endpoint for the given region and service.
    ///
    /// - Parameters:
    ///   - region: Region ID or alias (e.g. `"na"`, `"us"`, `"eu"`, `"azure-na"`). Case-insensitive.
    ///   - service: Service key (e.g. `"contentDelivery"`, `"contentManagement"`).
    ///              Pass an empty string (the default) to receive all endpoints as `[String: String]`.
    ///   - omitHttps: When `true`, strips `"https://"` from every returned URL.
    /// - Returns: `String` for a specific service; `[String: String]` when `service` is empty.
    /// - Throws: `Endpoint.EndpointError` for invalid input, unavailable data, or corrupt data.
    @discardableResult
    public static func getContentstackEndpoint(
        _ region: String = "us",
        _ service: String = "",
        _ omitHttps: Bool = false
    ) throws -> Any {
        let trimmed = region.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { throw EndpointError.emptyRegion }

        let regions = try loadRegions()
        let normalized = trimmed.lowercased()

        guard let row = findRegion(in: regions, normalized: normalized) else {
            throw EndpointError.invalidRegion(trimmed)
        }

        guard let endpoints = row["endpoints"] as? [String: String] else {
            throw EndpointError.invalidRegionsData
        }

        if service.isEmpty {
            return omitHttps
                ? endpoints.mapValues { stripScheme($0) }
                : endpoints
        }

        guard let url = endpoints[service] else {
            throw EndpointError.serviceNotFound(service, trimmed)
        }

        return omitHttps ? stripScheme(url) : url
    }

    // MARK: - Internal (test support)

    static func resetCache() {
        lock.lock()
        defer { lock.unlock() }
        _cachedRegions = nil
        _refreshTask?.cancel()
        _refreshTask = nil
    }

    /// Parses a JSON string and seeds the in-memory cache. Used by tests to avoid network calls.
    static func seedCache(fromJSON jsonString: String) throws {
        guard let data = jsonString.data(using: .utf8),
              let regions = parseRegions(from: data) else {
            throw EndpointError.invalidRegionsData
        }
        cachedRegions = regions
    }

    // MARK: - Private loading

    private static func loadRegions() throws -> [[String: Any]] {
        // Layer 1 — in-memory cache (zero I/O)
        if let cached = cachedRegions { return cached }

        // Layer 2 — bundled file (present when Scripts/download-regions.sh was run before build)
        if let bundleURL = bundledRegionsURL(),
           let regions = parseRegions(from: try Data(contentsOf: bundleURL)) {
            cachedRegions = regions
            // After serving bundled data, refresh in the background so the cache
            // picks up any new regions or URLs added since the last build.
            scheduleBackgroundRefresh()
            return regions
        }

        // Layer 3 — live HTTP download (blocking; used when bundle resource is absent)
        guard let remoteURL = URL(string: regionsURL),
              let data = try? Data(contentsOf: remoteURL) else {
            throw EndpointError.regionsDataUnavailable
        }
        guard let regions = parseRegions(from: data) else {
            throw EndpointError.invalidRegionsData
        }
        cachedRegions = regions
        return regions
    }

    /// Fires a one-shot background URLSession task that updates the in-memory cache.
    /// Subsequent calls to `getContentstackEndpoint` within the same process will use the
    /// refreshed data once the task completes — without ever blocking the caller.
    private static func scheduleBackgroundRefresh() {
        lock.lock()
        guard _refreshTask == nil else { lock.unlock(); return }
        lock.unlock()

        guard let url = URL(string: regionsURL) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            lock.lock()
            _refreshTask = nil
            lock.unlock()
            guard let data = data, let regions = parseRegions(from: data) else { return }
            cachedRegions = regions
        }

        lock.lock()
        _refreshTask = task
        lock.unlock()

        task.resume()
    }

    // MARK: - Private helpers

    private static func parseRegions(from data: Data) -> [[String: Any]]? {
        guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              let regions = json["regions"] as? [[String: Any]] else {
            return nil
        }
        return regions
    }

    private static func findRegion(in regions: [[String: Any]], normalized: String) -> [String: Any]? {
        // Pass 1: canonical id
        for region in regions {
            if let id = region["id"] as? String, id.lowercased() == normalized {
                return region
            }
        }
        // Pass 2: aliases
        for region in regions {
            if let aliases = region["alias"] as? [String] {
                for alias in aliases where alias.lowercased() == normalized {
                    return region
                }
            }
        }
        return nil
    }

    private static func stripScheme(_ url: String) -> String {
        if url.hasPrefix("https://") { return String(url.dropFirst(8)) }
        if url.hasPrefix("http://") { return String(url.dropFirst(7)) }
        return url
    }
}
