//
//  NodeTypeTest.swift
//  ContentstackUtilsTests
//
//  Created by Uttam Ukkoji on 04/06/21.
//

import XCTest
@testable import ContentstackUtils
class NodeTypeTest: XCTestCase {

    func testNodeType_RawValue() {
        XCTAssertEqual(NodeType.document.rawValue, "doc")
        XCTAssertEqual(NodeType.paragraph.rawValue, "p")
        XCTAssertEqual(NodeType.link.rawValue, "a")
        XCTAssertEqual(NodeType.image.rawValue, "img")
        XCTAssertEqual(NodeType.embed.rawValue, "embed")
        XCTAssertEqual(NodeType.heading_1.rawValue, "h1")
        XCTAssertEqual(NodeType.heading_2.rawValue, "h2")
        XCTAssertEqual(NodeType.heading_3.rawValue, "h3")
        XCTAssertEqual(NodeType.heading_4.rawValue, "h4")
        XCTAssertEqual(NodeType.heading_5.rawValue, "h5")
        XCTAssertEqual(NodeType.heading_6.rawValue, "h6")
        XCTAssertEqual(NodeType.orderList.rawValue, "ol")
        XCTAssertEqual(NodeType.unOrderList.rawValue, "ul")
        XCTAssertEqual(NodeType.listItem.rawValue, "li")
        XCTAssertEqual(NodeType.hr.rawValue, "hr")
        XCTAssertEqual(NodeType.table.rawValue, "table")
        XCTAssertEqual(NodeType.tableHeader.rawValue, "thead")
        XCTAssertEqual(NodeType.tableFooter.rawValue, "tfoot")
        XCTAssertEqual(NodeType.tableBody.rawValue, "tbody")
        XCTAssertEqual(NodeType.tableRow.rawValue, "tr")
        XCTAssertEqual(NodeType.tableHead.rawValue, "th")
        XCTAssertEqual(NodeType.tableData.rawValue, "td")
        XCTAssertEqual(NodeType.blockQuote.rawValue, "blockquote")
        XCTAssertEqual(NodeType.code.rawValue, "code")
        XCTAssertEqual(NodeType.text.rawValue, "text")
        XCTAssertEqual(NodeType.reference.rawValue, "reference")
        XCTAssertEqual(NodeType.unknown.rawValue, "unknown")
    }
    static var allTests = [
        ("testNodeType_RawValue", testNodeType_RawValue),

    ]
}
