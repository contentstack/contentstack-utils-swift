//
//  GQLJsonToHtml.swift
//  ContentstackUtilsTests
//
//  Created by Uttam Ukkoji on 19/07/21.
//

import XCTest
@testable import ContentstackUtils
class GQLJsonToHtml: XCTestCase {

    
    func testEmpty_Node_Returns_Empty_String()  {
        guard let json = GQLJsonRTE(node: kBlankDocument) else { return }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["single_rte"] as! [String : Any?]) as? String {
            XCTAssertEqual(result, "")
        }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["multiple_rte"] as! [String : Any?]) as? [String] {
            XCTAssertEqual(result, [""])
            
        }
    }
    
    func testPlainText_Document_Return_HtmlString_Result()  {
        guard let json = GQLJsonRTE(node: kPlainTextJson) else { return }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["single_rte"] as! [String : Any?]) as? String {
            XCTAssertEqual(result, kPlainTextHtml)
        }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["multiple_rte"] as! [String : Any?]) as? [String] {
            XCTAssertEqual(result, [kPlainTextHtml])
        }
    }
    
    func testAsset_Reference_Document() {
        guard let json = GQLJsonRTE(node: kAssetReferenceJson, items:  kGQLAssetEmbed) else { return }
        let expected = "<img src=\"svg-logo-text.png\" alt=\"svg-logo-text.png\" />"
        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["single_rte"] as! [String : Any?]) as? String {
            XCTAssertEqual(result, expected)
        }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["multiple_rte"] as! [String : Any?]) as? [String] {
            XCTAssertEqual(result, [expected])
        }
    }
    
    func testEntryBlock_Reference_Document() {
        guard let json = GQLJsonRTE(node: kEntryReferenceBlockJson, items:  kGQLEntryblock) else { return }
        let expected = "<div><p>Update this title</p><p>Content type: <span>GQL</span></p></div>"
        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["single_rte"] as! [String : Any?]) as? String {
            XCTAssertEqual(result, expected)
        }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["multiple_rte"] as! [String : Any?]) as? [String] {
            XCTAssertEqual(result, [expected])
        }
    }
    
    func testEntryLink_Reference_Document() {
        guard let json = GQLJsonRTE(node: kEntryReferenceLinkJson, items:  kGQLEntryLink) else { return }
        let expected = "<a href=\"bltemmbedEntryuid\">/copy-of-entry-final-02</a>"
        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["single_rte"] as! [String : Any?]) as? String {
            XCTAssertEqual(result, expected)
        }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["multiple_rte"] as! [String : Any?]) as? [String] {
            XCTAssertEqual(result, [expected])
        }
    }

    func testEntryInline_Reference_Document() {
        guard let json = GQLJsonRTE(node: kEntryReferenceInlineJson, items:  kGQLEntryInline) else { return }
        let expected = "<span>updated title</span>"
        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["single_rte"] as! [String : Any?]) as? String {
            XCTAssertEqual(result, expected)
        }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["multiple_rte"] as! [String : Any?]) as? [String] {
            XCTAssertEqual(result, [expected])
        }
    }
    
    func testParagraph_Document()  {
        guard let json = GQLJsonRTE(node: kParagraphJson) else { return }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["single_rte"] as! [String : Any?]) as? String {
            XCTAssertEqual(result, kParagraphHtml)
        }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["multiple_rte"] as! [String : Any?]) as? [String] {
            XCTAssertEqual(result, [kParagraphHtml])
            
        }
    }
    
    func testLink_Document()  {
        guard let json = GQLJsonRTE(node: kLinkInPJson) else { return }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["single_rte"] as! [String : Any?]) as? String {
            XCTAssertEqual(result, kLinkInPHtml)
        }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["multiple_rte"] as! [String : Any?]) as? [String] {
            XCTAssertEqual(result, [kLinkInPHtml])
        }
    }
    
    func testImage_Document()  {
        guard let json = GQLJsonRTE(node: kImgJson) else { return }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["single_rte"] as! [String : Any?]) as? String {
            XCTAssertEqual(result, kImgHtml)
        }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["multiple_rte"] as! [String : Any?]) as? [String] {
            XCTAssertEqual(result, [kImgHtml])
        }
    }
    
    func testEmbed_Document()  {
        guard let json = GQLJsonRTE(node: kEmbedJson) else { return }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["single_rte"] as! [String : Any?]) as? String {
            XCTAssertEqual(result, kEmbedHtml)
        }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["multiple_rte"] as! [String : Any?]) as? [String] {
            XCTAssertEqual(result, [kEmbedHtml])
        }
    }
    
    func testH1_Document()  {
        guard let json = GQLJsonRTE(node: kH1Json) else { return }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["single_rte"] as! [String : Any?]) as? String {
            XCTAssertEqual(result, kH1Html)
        }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["multiple_rte"] as! [String : Any?]) as? [String] {
            XCTAssertEqual(result, [kH1Html])
        }
    }

    func testH2_Document()  {
        guard let json = GQLJsonRTE(node: kH2Json) else { return }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["single_rte"] as! [String : Any?]) as? String {
            XCTAssertEqual(result, kH2Html)
        }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["multiple_rte"] as! [String : Any?]) as? [String] {
            XCTAssertEqual(result, [kH2Html])
        }
    }
    
    func testH3_Document()  {
        guard let json = GQLJsonRTE(node: kH3Json) else { return }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["single_rte"] as! [String : Any?]) as? String {
            XCTAssertEqual(result, kH3Html)
        }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["multiple_rte"] as! [String : Any?]) as? [String] {
            XCTAssertEqual(result, [kH3Html])
        }
    }
    
    func testH4_Document()  {
        guard let json = GQLJsonRTE(node: kH4Json) else { return }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["single_rte"] as! [String : Any?]) as? String {
            XCTAssertEqual(result, kH4Html)
        }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["multiple_rte"] as! [String : Any?]) as? [String] {
            XCTAssertEqual(result, [kH4Html])
        }
    }
    
    func testH5_Document()  {
        guard let json = GQLJsonRTE(node: kH5Json) else { return }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["single_rte"] as! [String : Any?]) as? String {
            XCTAssertEqual(result, kH5Html)
        }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["multiple_rte"] as! [String : Any?]) as? [String] {
            XCTAssertEqual(result, [kH5Html])
        }
    }
    
    func testH6_Document()  {
        guard let json = GQLJsonRTE(node: kH6Json) else { return }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["single_rte"] as! [String : Any?]) as? String {
            XCTAssertEqual(result, kH6Html)
        }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["multiple_rte"] as! [String : Any?]) as? [String] {
            XCTAssertEqual(result, [kH6Html])
        }
    }
    
    func testOrderList_Document()  {
        guard let json = GQLJsonRTE(node: kOrderListJson) else { return }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["single_rte"] as! [String : Any?]) as? String {
            XCTAssertEqual(result, kOrderListHtml)
        }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["multiple_rte"] as! [String : Any?]) as? [String] {
            XCTAssertEqual(result, [kOrderListHtml])
        }
    }
    
    func testUnorderList_Document()  {
        guard let json = GQLJsonRTE(node: kUnorderListJson) else { return }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["single_rte"] as! [String : Any?]) as? String {
            XCTAssertEqual(result, kIUnorderListHtml)
        }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["multiple_rte"] as! [String : Any?]) as? [String] {
            XCTAssertEqual(result, [kIUnorderListHtml])
        }
    }
    
    func testTable_Document()  {
        guard let json = GQLJsonRTE(node: kTableJson) else { return }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["single_rte"] as! [String : Any?]) as? String {
            XCTAssertEqual(result, kTableHtml)
        }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["multiple_rte"] as! [String : Any?]) as? [String] {
            XCTAssertEqual(result, [kTableHtml])
        }
    }
    
    func testBlockquote_Document()  {
        guard let json = GQLJsonRTE(node: kBlockquoteJson) else { return }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["single_rte"] as! [String : Any?]) as? String {
            XCTAssertEqual(result, kBlockquoteHtml)
        }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["multiple_rte"] as! [String : Any?]) as? [String] {
            XCTAssertEqual(result, [kBlockquoteHtml])
        }
    }
    
    func testCode_Document()  {
        guard let json = GQLJsonRTE(node: kCodeJson) else { return }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["single_rte"] as! [String : Any?]) as? String {
            XCTAssertEqual(result, kCodeHtml)
        }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["multiple_rte"] as! [String : Any?]) as? [String] {
            XCTAssertEqual(result, [kCodeHtml])
        }
    }
    
    func testHR_Document()  {
        guard let json = GQLJsonRTE(node: kHRJson) else { return }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["single_rte"] as! [String : Any?]) as? String {
            XCTAssertEqual(result, "<hr>")
        }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["multiple_rte"] as! [String : Any?]) as? [String] {
            XCTAssertEqual(result, ["<hr>"])
        }
    }
    
    func testFragment_Document()  {
        guard let json = GQLJsonRTE(node: kFragmentJson) else { return }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["single_rte"] as! [String : Any?]) as? String {
            XCTAssertEqual(result, kFragmentHtml)
        }

        if let result = try? ContentstackUtils.GQL.jsonToHtml(rte: json["multiple_rte"] as! [String : Any?]) as? [String] {
            XCTAssertEqual(result, [kFragmentHtml])
        }
    }
    
    static var allTests = [
        ("testEmpty_Node_Returns_Empty_String", testEmpty_Node_Returns_Empty_String),
        ("testPlainText_Document_Return_HtmlString_Result", testPlainText_Document_Return_HtmlString_Result),
        ("testAsset_Reference_Document", testAsset_Reference_Document),
        ("testEntryBlock_Reference_Document", testEntryBlock_Reference_Document),
        ("testEntryLink_Reference_Document", testEntryLink_Reference_Document),
        ("testEntryInline_Reference_Document", testEntryInline_Reference_Document),
        ("testParagraph_Document", testParagraph_Document),
        ("testLink_Document", testLink_Document),
        ("testImage_Document", testImage_Document),
        ("testEmbed_Document", testEmbed_Document),
        ("testH1_Document", testH1_Document),
        ("testH2_Document", testH2_Document),
        ("testH3_Document", testH3_Document),
        ("testH4_Document", testH4_Document),
        ("testH5_Document", testH5_Document),
        ("testH6_Document", testH6_Document),
        ("testOrderList_Document", testOrderList_Document),
        ("testUnorderList_Document", testUnorderList_Document),
        ("testHR_Document", testHR_Document),
        ("testTable_Document", testTable_Document),
        ("testBlockquote_Document", testBlockquote_Document),
        ("testCode_Document", testCode_Document),
        ("testFragment_Document", testFragment_Document),
    ]

}
