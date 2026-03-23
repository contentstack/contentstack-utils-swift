import XCTest
@testable import ContentstackUtils

final class VariantUtilityTests: XCTestCase {

    private let contentTypeUid = "movie"

    private func stringSet(from variants: Any?) -> Set<String> {
        guard let arr = variants as? [String] else { return [] }
        return Set(arr)
    }

    private func parseDataCsvariantsArray(_ wrapper: [String: Any]) throws -> [[String: Any]] {
        let jsonStr = try XCTUnwrap(wrapper["data-csvariants"] as? String)
        let data = try XCTUnwrap(jsonStr.data(using: .utf8))
        let any = try JSONSerialization.jsonObject(with: data)
        guard let arr = any as? [Any] else {
            XCTFail("data-csvariants is not a JSON array")
            return []
        }
        return arr.compactMap { $0 as? [String: Any] }
    }

    func testGetVariantAliasesSingleEntry() throws {
        let root = try TestDecodable.loadJSONObject(named: "variantsSingleEntry")
        let entry = try XCTUnwrap(root["entry"] as? [String: Any])
        let result = try ContentstackUtils.getVariantAliases(entry: entry, contentTypeUid: contentTypeUid)

        XCTAssertEqual(result["entry_uid"] as? String, "entry_uid_single")
        XCTAssertEqual(result["contenttype_uid"] as? String, contentTypeUid)
        XCTAssertEqual(stringSet(from: result["variants"]), ["cs_personalize_0_0", "cs_personalize_0_3"])
    }

    func testGetDataCsvariantsAttributeSingleEntry() throws {
        let root = try TestDecodable.loadJSONObject(named: "variantsSingleEntry")
        let entry = try XCTUnwrap(root["entry"] as? [String: Any])
        let wrapper = try ContentstackUtils.getDataCsvariantsAttribute(entry: entry, contentTypeUid: contentTypeUid)

        let parsed = try parseDataCsvariantsArray(wrapper)
        XCTAssertEqual(parsed.count, 1)
        let first = try XCTUnwrap(parsed.first)
        XCTAssertEqual(first["entry_uid"] as? String, "entry_uid_single")
        XCTAssertEqual(first["contenttype_uid"] as? String, contentTypeUid)
        XCTAssertEqual(stringSet(from: first["variants"]), ["cs_personalize_0_0", "cs_personalize_0_3"])
    }

    func testGetVariantAliasesMultipleEntries() throws {
        let root = try TestDecodable.loadJSONObject(named: "variantsEntries")
        let entries = try XCTUnwrap(root["entries"] as? [[String: Any]])
        let result = try ContentstackUtils.getVariantAliases(entries: entries, contentTypeUid: contentTypeUid)

        XCTAssertEqual(result.count, 3)

        let first = try XCTUnwrap(result.first)
        XCTAssertEqual(first["entry_uid"] as? String, "entry_uid_1")
        XCTAssertEqual(first["contenttype_uid"] as? String, contentTypeUid)
        XCTAssertEqual(stringSet(from: first["variants"]), ["cs_personalize_0_0", "cs_personalize_0_3"])

        let second = result[1]
        XCTAssertEqual(second["entry_uid"] as? String, "entry_uid_2")
        XCTAssertEqual((second["variants"] as? [String])?.count, 1)
        XCTAssertEqual((second["variants"] as? [String])?.first, "cs_personalize_0_0")

        let third = result[2]
        XCTAssertEqual(third["entry_uid"] as? String, "entry_uid_3")
        XCTAssertEqual((third["variants"] as? [String])?.count, 0)
    }

    func testGetDataCsvariantsAttributeMultipleEntries() throws {
        let root = try TestDecodable.loadJSONObject(named: "variantsEntries")
        let entries = try XCTUnwrap(root["entries"] as? [[String: Any]])
        let wrapper = try ContentstackUtils.getDataCsvariantsAttribute(entries: entries, contentTypeUid: contentTypeUid)

        let parsed = try parseDataCsvariantsArray(wrapper)
        XCTAssertEqual(parsed.count, 3)

        XCTAssertEqual(parsed[0]["entry_uid"] as? String, "entry_uid_1")
        XCTAssertEqual((parsed[0]["variants"] as? [String])?.count, 2)

        XCTAssertEqual(parsed[1]["entry_uid"] as? String, "entry_uid_2")
        XCTAssertEqual((parsed[1]["variants"] as? [String])?.count, 1)

        XCTAssertEqual(parsed[2]["entry_uid"] as? String, "entry_uid_3")
        XCTAssertEqual((parsed[2]["variants"] as? [String])?.count, 0)
    }

    func testGetVariantAliasesThrowsWhenEntryMissingUid() {
        XCTAssertThrowsError(try ContentstackUtils.getVariantAliases(entry: [:], contentTypeUid: contentTypeUid)) { error in
            XCTAssertTrue(error is ContentstackUtils.VariantUtilityError)
        }
    }

    func testGetVariantAliasesThrowsWhenContentTypeUidEmpty() throws {
        let root = try TestDecodable.loadJSONObject(named: "variantsSingleEntry")
        let entry = try XCTUnwrap(root["entry"] as? [String: Any])

        XCTAssertThrowsError(try ContentstackUtils.getVariantAliases(entry: entry, contentTypeUid: "")) { error in
            XCTAssertTrue(error is ContentstackUtils.VariantUtilityError)
        }
        XCTAssertThrowsError(try ContentstackUtils.getVariantAliases(entry: entry, contentTypeUid: "   ")) { error in
            XCTAssertTrue(error is ContentstackUtils.VariantUtilityError)
        }
    }

    func testGetDataCsvariantsAttributeWhenEntryNil() throws {
        let result = try ContentstackUtils.getDataCsvariantsAttribute(entry: nil, contentTypeUid: "landing_page")
        XCTAssertEqual(result["data-csvariants"] as? String, "[]")
    }

    // MARK: - Edge cases

    func testGetVariantAliasesEmptyEntriesArray() throws {
        let result = try ContentstackUtils.getVariantAliases(entries: [], contentTypeUid: contentTypeUid)
        XCTAssertTrue(result.isEmpty)
    }

    func testGetVariantAliasesEmptyEntriesThrowsWhenContentTypeUidEmpty() {
        XCTAssertThrowsError(try ContentstackUtils.getVariantAliases(entries: [], contentTypeUid: "")) { error in
            XCTAssertTrue(error is ContentstackUtils.VariantUtilityError)
        }
    }

    func testGetDataCsvariantsAttributeEmptyEntriesArray() throws {
        let wrapper = try ContentstackUtils.getDataCsvariantsAttribute(entries: [], contentTypeUid: contentTypeUid)
        XCTAssertEqual(wrapper["data-csvariants"] as? String, "[]")
    }

    func testGetVariantAliasesEntryWithoutPublishDetails() throws {
        let entry: [String: Any] = [
            "uid": "no_publish",
            "title": "No publish_details key",
        ]
        let result = try ContentstackUtils.getVariantAliases(entry: entry, contentTypeUid: contentTypeUid)
        XCTAssertEqual(result["entry_uid"] as? String, "no_publish")
        XCTAssertEqual(result["contenttype_uid"] as? String, contentTypeUid)
        XCTAssertEqual(result["variants"] as? [String], [])
    }

    func testGetVariantAliasesEntryWithEmptyVariantsMap() throws {
        let entry: [String: Any] = [
            "uid": "empty_variants",
            "publish_details": [
                "locale": "en-us",
                "variants": [String: Any](),
            ] as [String: Any],
        ]
        let result = try ContentstackUtils.getVariantAliases(entry: entry, contentTypeUid: contentTypeUid)
        XCTAssertEqual(result["entry_uid"] as? String, "empty_variants")
        XCTAssertEqual(result["variants"] as? [String], [])
    }

    func testGetVariantAliasesSkipsInvalidVariantValues() throws {
        let entry: [String: Any] = [
            "uid": "mixed_variants",
            "publish_details": [
                "variants": [
                    "cs_variant_0_0": [
                        "alias": "cs_personalize_0_0",
                    ],
                    "not_a_dict": "ignored",
                    "missing_alias": [
                        "version": 1,
                    ],
                ] as [String: Any],
            ] as [String: Any],
        ]
        let result = try ContentstackUtils.getVariantAliases(entry: entry, contentTypeUid: contentTypeUid)
        XCTAssertEqual(result["variants"] as? [String], ["cs_personalize_0_0"])
    }

    func testGetVariantAliasesThrowsWhenUidIsEmptyString() {
        let entry: [String: Any] = ["uid": "", "title": "x"]
        XCTAssertThrowsError(try ContentstackUtils.getVariantAliases(entry: entry, contentTypeUid: contentTypeUid)) { error in
            XCTAssertTrue(error is ContentstackUtils.VariantUtilityError)
        }
    }

    func testGetDataCsvariantsAttributeThrowsWhenContentTypeUidEmptyWithEntry() throws {
        let root = try TestDecodable.loadJSONObject(named: "variantsSingleEntry")
        let entry = try XCTUnwrap(root["entry"] as? [String: Any])
        XCTAssertThrowsError(try ContentstackUtils.getDataCsvariantsAttribute(entry: entry, contentTypeUid: "")) { error in
            XCTAssertTrue(error is ContentstackUtils.VariantUtilityError)
        }
    }

    func testGetDataCsvariantsAttributeEntriesThrowsWhenContentTypeUidWhitespaceOnly() {
        XCTAssertThrowsError(try ContentstackUtils.getDataCsvariantsAttribute(entries: [], contentTypeUid: "\t\n")) { error in
            XCTAssertTrue(error is ContentstackUtils.VariantUtilityError)
        }
    }

    #if !canImport(ObjectiveC)
    static var allTests = [
        ("testGetVariantAliasesSingleEntry", testGetVariantAliasesSingleEntry),
        ("testGetDataCsvariantsAttributeSingleEntry", testGetDataCsvariantsAttributeSingleEntry),
        ("testGetVariantAliasesMultipleEntries", testGetVariantAliasesMultipleEntries),
        ("testGetDataCsvariantsAttributeMultipleEntries", testGetDataCsvariantsAttributeMultipleEntries),
        ("testGetVariantAliasesThrowsWhenEntryMissingUid", testGetVariantAliasesThrowsWhenEntryMissingUid),
        ("testGetVariantAliasesThrowsWhenContentTypeUidEmpty", testGetVariantAliasesThrowsWhenContentTypeUidEmpty),
        ("testGetDataCsvariantsAttributeWhenEntryNil", testGetDataCsvariantsAttributeWhenEntryNil),
        ("testGetVariantAliasesEmptyEntriesArray", testGetVariantAliasesEmptyEntriesArray),
        ("testGetVariantAliasesEmptyEntriesThrowsWhenContentTypeUidEmpty", testGetVariantAliasesEmptyEntriesThrowsWhenContentTypeUidEmpty),
        ("testGetDataCsvariantsAttributeEmptyEntriesArray", testGetDataCsvariantsAttributeEmptyEntriesArray),
        ("testGetVariantAliasesEntryWithoutPublishDetails", testGetVariantAliasesEntryWithoutPublishDetails),
        ("testGetVariantAliasesEntryWithEmptyVariantsMap", testGetVariantAliasesEntryWithEmptyVariantsMap),
        ("testGetVariantAliasesSkipsInvalidVariantValues", testGetVariantAliasesSkipsInvalidVariantValues),
        ("testGetVariantAliasesThrowsWhenUidIsEmptyString", testGetVariantAliasesThrowsWhenUidIsEmptyString),
        ("testGetDataCsvariantsAttributeThrowsWhenContentTypeUidEmptyWithEntry", testGetDataCsvariantsAttributeThrowsWhenContentTypeUidEmptyWithEntry),
        ("testGetDataCsvariantsAttributeEntriesThrowsWhenContentTypeUidWhitespaceOnly", testGetDataCsvariantsAttributeEntriesThrowsWhenContentTypeUidWhitespaceOnly),
    ]
    #endif
}
