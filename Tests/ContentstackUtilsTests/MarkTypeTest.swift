//
//  MarkTypeTest.swift
//  ContentstackUtilsTests
//
//  Created by Uttam Ukkoji on 04/06/21.
//

import XCTest
@testable import ContentstackUtils
class MarkTypeTest: XCTestCase {

    func testMarkType_RawValue() {
        XCTAssertEqual(MarkType.bold.rawValue, "bold")
        XCTAssertEqual(MarkType.italic.rawValue, "italic")
        XCTAssertEqual(MarkType.underline.rawValue, "underline")
        XCTAssertEqual(MarkType.strickthrough.rawValue, "strickthrough")
        XCTAssertEqual(MarkType.inlineCode.rawValue, "inlineCode")
        XCTAssertEqual(MarkType.subscript.rawValue, "subscript")
        XCTAssertEqual(MarkType.superscript.rawValue, "superscript")
    }
    static var allTests = [
        ("testMarkType_RawValue", testMarkType_RawValue),

    ]
}
