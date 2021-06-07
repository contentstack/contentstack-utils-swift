//
//  MetadataTest.swift
//  ContentstackUtilsTests
//
//  Created by Uttam Ukkoji on 02/11/20.
//

import XCTest
@testable import ContentstackUtils
class MetadataTests: XCTestCase {

    func testBlankAttributes() {
        let html = "<h1>TEST</h1>"
        if let doc = try? HTML(html: html, encoding: .utf8) {
            let element = doc.xpath("//h1")
            let metadata = Metadata(node: element.first!)
            XCTAssertEqual(metadata.itemType, .entry)
            XCTAssertEqual(metadata.styleType, .block)
            XCTAssertEqual(metadata.itemUid, "")
            XCTAssertEqual(metadata.contentTypeUid, "")
            XCTAssertEqual(metadata.text, "TEST")
            XCTAssertEqual(metadata.outerHTML, html)
        }
    }

    func testWrongAttributes() {
        let html = "<h1 type=\"\" sys-style-type=\"\" data-sys-entry-uid=\"\" data-sys-content-type-uid=\"\">TEST</h1>"
        if let doc = try? HTML(html: html, encoding: .utf8) {
            let element = doc.xpath("//h1")
            let metadata = Metadata(node: element.first!)
            XCTAssertEqual(metadata.itemType, .entry)
            XCTAssertEqual(metadata.styleType, .block)
            XCTAssertEqual(metadata.itemUid, "")
            XCTAssertEqual(metadata.contentTypeUid, "")
            XCTAssertEqual(metadata.outerHTML, html)
            XCTAssertEqual(metadata.text, "TEST")
        }
    }

    func testAttributes() {
        let html = """
<h1 type=\"asset\" sys-style-type=\"inline\" data-sys-entry-uid=\"uid\" data-sys-content-type-uid=\"contentType\">
TEST</h1>
"""
        if let doc = try? HTML(html: html, encoding: .utf8) {
            let element = doc.xpath("//h1")
            let metadata = Metadata(node: element.first!)
            XCTAssertEqual(metadata.itemType, .asset)
            XCTAssertEqual(metadata.styleType, .inline)
            XCTAssertEqual(metadata.itemUid, "uid")
            XCTAssertEqual(metadata.contentTypeUid, "contentType")
            XCTAssertEqual(metadata.outerHTML, html)
            XCTAssertEqual(metadata.text, "\nTEST")
        }
    }

    func testAssetUidAttributes() {
        let html = "<h1 type=\"asset\" sys-style-type=\"inline\" data-sys-asset-uid=\"assetuid\">TEST</h1>"
        if let doc = try? HTML(html: html, encoding: .utf8) {
            let element = doc.xpath("//h1")
            let metadata = Metadata(node: element.first!)
            XCTAssertEqual(metadata.itemType, .asset)
            XCTAssertEqual(metadata.styleType, .inline)
            XCTAssertEqual(metadata.itemUid, "assetuid")
            XCTAssertEqual(metadata.contentTypeUid, "")
            XCTAssertEqual(metadata.outerHTML, html)
            XCTAssertEqual(metadata.text, "TEST")
        }
    }

    func testNodeAttributes() {
        let node = NodeParser.parse(from: kBlankDocument)
        let metadata = Metadata(nodeAttribute: node.attrs, text: nil)
        XCTAssertEqual(metadata.itemType, .entry)
        XCTAssertEqual(metadata.styleType, .block)
        XCTAssertEqual(metadata.itemUid, "")
        XCTAssertEqual(metadata.contentTypeUid, "")
        XCTAssertEqual(metadata.text, nil)
    }
}
