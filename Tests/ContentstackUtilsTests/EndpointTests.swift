import XCTest
@testable import ContentstackUtils

// Regions data is loaded once per test run via the real loading path:
//   1. bundled regions.json  (present after `bash Scripts/download-regions.sh && swift build`)
//   2. live HTTP download    (fallback when bundle resource is absent)
// Individual tests share the in-memory cache — no fake seeding, no per-test network calls.

final class EndpointTests: XCTestCase {

    override class func setUp() {
        super.setUp()
        Endpoint.resetCache()
    }

    // MARK: - Basic resolution

    func testNAContentDeliveryFullURL() throws {
        let url = try Endpoint.getContentstackEndpoint("na", "contentDelivery") as! String
        XCTAssertEqual(url, "https://cdn.contentstack.io")
    }

    func testNAContentDeliveryOmitHttps() throws {
        let host = try Endpoint.getContentstackEndpoint("na", "contentDelivery", true) as! String
        XCTAssertEqual(host, "cdn.contentstack.io")
    }

    func testEUContentDelivery() throws {
        let url = try Endpoint.getContentstackEndpoint("eu", "contentDelivery") as! String
        XCTAssertEqual(url, "https://eu-cdn.contentstack.com")
    }

    func testAUContentManagement() throws {
        let url = try Endpoint.getContentstackEndpoint("au", "contentManagement") as! String
        XCTAssertEqual(url, "https://au-api.contentstack.com")
    }

    func testAzureNAContentDelivery() throws {
        let url = try Endpoint.getContentstackEndpoint("azure-na", "contentDelivery") as! String
        XCTAssertEqual(url, "https://azure-na-cdn.contentstack.com")
    }

    func testAzureEUGraphQL() throws {
        let url = try Endpoint.getContentstackEndpoint("azure-eu", "graphqlDelivery") as! String
        XCTAssertEqual(url, "https://azure-eu-graphql.contentstack.com")
    }

    func testGCPNAContentDelivery() throws {
        let url = try Endpoint.getContentstackEndpoint("gcp-na", "contentDelivery") as! String
        XCTAssertEqual(url, "https://gcp-na-cdn.contentstack.com")
    }

    func testGCPEUAuth() throws {
        let url = try Endpoint.getContentstackEndpoint("gcp-eu", "auth") as! String
        XCTAssertEqual(url, "https://gcp-eu-auth-api.contentstack.com")
    }

    // MARK: - Region aliases

    func testAliasUS() throws {
        let url = try Endpoint.getContentstackEndpoint("us", "contentDelivery") as! String
        XCTAssertEqual(url, "https://cdn.contentstack.io")
    }

    func testAliasAWSNA() throws {
        let url = try Endpoint.getContentstackEndpoint("aws-na", "contentDelivery") as! String
        XCTAssertEqual(url, "https://cdn.contentstack.io")
    }

    func testAliasAWSNAUnderscore() throws {
        let url = try Endpoint.getContentstackEndpoint("aws_na", "contentDelivery") as! String
        XCTAssertEqual(url, "https://cdn.contentstack.io")
    }

    func testAliasUppercaseUS() throws {
        let url = try Endpoint.getContentstackEndpoint("US", "contentDelivery") as! String
        XCTAssertEqual(url, "https://cdn.contentstack.io")
    }

    func testAliasUppercaseAWSNA() throws {
        let url = try Endpoint.getContentstackEndpoint("AWS-NA", "contentDelivery") as! String
        XCTAssertEqual(url, "https://cdn.contentstack.io")
    }

    func testAliasUppercaseAWSNAUnderscore() throws {
        let url = try Endpoint.getContentstackEndpoint("AWS_NA", "contentDelivery") as! String
        XCTAssertEqual(url, "https://cdn.contentstack.io")
    }

    func testAliasEU() throws {
        let url = try Endpoint.getContentstackEndpoint("EU", "contentDelivery") as! String
        XCTAssertEqual(url, "https://eu-cdn.contentstack.com")
    }

    func testAliasAWSEUUnderscore() throws {
        let url = try Endpoint.getContentstackEndpoint("aws_eu", "contentDelivery") as! String
        XCTAssertEqual(url, "https://eu-cdn.contentstack.com")
    }

    func testAliasAzureNAUnderscore() throws {
        let url = try Endpoint.getContentstackEndpoint("azure_na", "contentDelivery") as! String
        XCTAssertEqual(url, "https://azure-na-cdn.contentstack.com")
    }

    func testAliasAzureEUUppercase() throws {
        let url = try Endpoint.getContentstackEndpoint("AZURE-EU", "contentDelivery") as! String
        XCTAssertEqual(url, "https://azure-eu-cdn.contentstack.com")
    }

    func testAliasGCPNAUnderscore() throws {
        let url = try Endpoint.getContentstackEndpoint("gcp_na", "contentDelivery") as! String
        XCTAssertEqual(url, "https://gcp-na-cdn.contentstack.com")
    }

    func testAliasGCPEUUppercase() throws {
        let url = try Endpoint.getContentstackEndpoint("GCP-EU", "contentDelivery") as! String
        XCTAssertEqual(url, "https://gcp-eu-cdn.contentstack.com")
    }

    // MARK: - omitHttps

    func testOmitHttpsEUContentManagement() throws {
        let host = try Endpoint.getContentstackEndpoint("eu", "contentManagement", true) as! String
        XCTAssertEqual(host, "eu-api.contentstack.com")
    }

    func testOmitHttpsGCPNAContentManagement() throws {
        let host = try Endpoint.getContentstackEndpoint("gcp-na", "contentManagement", true) as! String
        XCTAssertEqual(host, "gcp-na-api.contentstack.com")
    }

    // MARK: - All endpoints (no service)

    func testAllEndpointsForNA() throws {
        let all = try Endpoint.getContentstackEndpoint("na") as! [String: String]
        XCTAssertEqual(all["contentDelivery"], "https://cdn.contentstack.io")
        XCTAssertEqual(all["contentManagement"], "https://api.contentstack.io")
        XCTAssertEqual(all["auth"], "https://auth-api.contentstack.com")
        XCTAssertEqual(all["assetManagement"], "https://am-api.contentstack.com")
    }

    func testAllEndpointsForEU() throws {
        let all = try Endpoint.getContentstackEndpoint("eu") as! [String: String]
        XCTAssertEqual(all["contentDelivery"], "https://eu-cdn.contentstack.com")
        XCTAssertFalse(all.keys.contains("assetManagement"), "EU should not have assetManagement")
    }

    func testAllEndpointsOmitHttps() throws {
        let all = try Endpoint.getContentstackEndpoint("eu", "", true) as! [String: String]
        XCTAssertEqual(all["contentDelivery"], "eu-cdn.contentstack.com")
        XCTAssertEqual(all["contentManagement"], "eu-api.contentstack.com")
        for value in all.values {
            XCTAssertFalse(value.hasPrefix("https://"), "omitHttps should strip scheme from all values")
        }
    }

    // MARK: - ContentstackUtils proxy

    func testProxyMatchesEndpoint() throws {
        let direct = try Endpoint.getContentstackEndpoint("na", "contentDelivery") as! String
        let proxy  = try ContentstackUtils.getContentstackEndpoint("na", "contentDelivery") as! String
        XCTAssertEqual(direct, proxy)
    }

    // MARK: - Error cases

    func testEmptyRegionThrows() {
        XCTAssertThrowsError(try Endpoint.getContentstackEndpoint("", "contentDelivery")) { error in
            guard let e = error as? Endpoint.EndpointError,
                  case .emptyRegion = e else {
                return XCTFail("Expected EndpointError.emptyRegion, got \(error)")
            }
        }
    }

    func testWhitespaceOnlyRegionThrows() {
        XCTAssertThrowsError(try Endpoint.getContentstackEndpoint("   ", "contentDelivery")) { error in
            guard let e = error as? Endpoint.EndpointError,
                  case .emptyRegion = e else {
                return XCTFail("Expected EndpointError.emptyRegion, got \(error)")
            }
        }
    }

    func testInvalidRegionThrows() {
        XCTAssertThrowsError(try Endpoint.getContentstackEndpoint("asia-pacific", "contentDelivery")) { error in
            guard let e = error as? Endpoint.EndpointError,
                  case .invalidRegion(let r) = e else {
                return XCTFail("Expected EndpointError.invalidRegion, got \(error)")
            }
            XCTAssertEqual(r, "asia-pacific")
        }
    }

    func testUnknownServiceThrows() {
        XCTAssertThrowsError(try Endpoint.getContentstackEndpoint("na", "cms")) { error in
            guard let e = error as? Endpoint.EndpointError,
                  case .serviceNotFound(let s, let r) = e else {
                return XCTFail("Expected EndpointError.serviceNotFound, got \(error)")
            }
            XCTAssertEqual(s, "cms")
            XCTAssertEqual(r, "na")
        }
    }

    func testServiceNotAvailableInRegion() {
        // assetManagement is NA-only; requesting it for EU should throw
        XCTAssertThrowsError(try Endpoint.getContentstackEndpoint("eu", "assetManagement")) { error in
            guard let e = error as? Endpoint.EndpointError,
                  case .serviceNotFound = e else {
                return XCTFail("Expected EndpointError.serviceNotFound, got \(error)")
            }
        }
    }

    // MARK: - Whitespace trimming

    func testRegionWithLeadingTrailingSpaces() throws {
        let url = try Endpoint.getContentstackEndpoint("  na  ", "contentDelivery") as! String
        XCTAssertEqual(url, "https://cdn.contentstack.io")
    }

    // MARK: - Cache behaviour

    func testCacheIsUsedOnSecondCall() throws {
        _ = try Endpoint.getContentstackEndpoint("na", "contentDelivery")
        let url = try Endpoint.getContentstackEndpoint("na", "contentDelivery") as! String
        XCTAssertEqual(url, "https://cdn.contentstack.io")
    }

    func testResetCacheAndReload() throws {
        _ = try Endpoint.getContentstackEndpoint("na", "contentDelivery")
        Endpoint.resetCache()
        // After reset the next call reloads from bundle or HTTP — result must still be correct
        let url = try Endpoint.getContentstackEndpoint("na", "contentDelivery") as! String
        XCTAssertEqual(url, "https://cdn.contentstack.io")
    }
}
