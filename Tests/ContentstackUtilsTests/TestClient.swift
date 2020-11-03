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
}
