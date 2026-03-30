//
//  TestClient.swift
//  ContentstackUtilsTests
//
//  Created by Uttam Ukkoji on 01/10/20.
//

import Foundation
@testable import ContentstackUtils
class TestDecodable {

    static func decode<T: Decodable>(_ fileName: String) -> T? {
        do {
            if let path = Bundle(for: TestDecodable.self).path(forResource: fileName,
                                                               ofType: "json"),
                let data = try? Data(contentsOf: URL(fileURLWithPath: path),
                                     options: Data.ReadingOptions.mappedIfSafe) {
                return try JSONDecoder().decode(T.self, from: data)
            }
        } catch let error {
            print("parse ErrorOccue \(error.localizedDescription)")
        }
        return nil
    }

    static func getMultilevelEmbed() -> ContentBlock? {
        return decode("EntryEmbedded")
    }

    /// Loads a JSON object from a file (e.g. `variantsEntries` → `variantsEntries.json`).
    /// Tries the test bundle first (Xcode), then the directory containing this source file (SwiftPM `swift test`).
    static func loadJSONObject(named fileName: String) throws -> [String: Any] {
        let url: URL
        if let path = Bundle(for: TestDecodable.self).path(forResource: fileName, ofType: "json") {
            url = URL(fileURLWithPath: path)
        } else {
            let testsDir = URL(fileURLWithPath: #filePath).deletingLastPathComponent()
            let fallback = testsDir.appendingPathComponent("\(fileName).json")
            guard FileManager.default.fileExists(atPath: fallback.path) else {
                throw NSError(domain: "TestDecodable", code: 1, userInfo: [NSLocalizedDescriptionKey: "Missing json: \(fileName).json"])
            }
            url = fallback
        }
        let data = try Data(contentsOf: url, options: .mappedIfSafe)
        guard let root = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw NSError(domain: "TestDecodable", code: 2, userInfo: [NSLocalizedDescriptionKey: "Root is not a JSON object"])
        }
        return root
    }
}
