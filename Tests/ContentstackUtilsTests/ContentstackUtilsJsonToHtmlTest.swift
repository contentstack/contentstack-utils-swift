//
//  ContentstackUtilsJsonToHtmlTest.swift
//  ContentstackUtilsTests
//
//  Created by Uttam Ukkoji on 07/06/21.
//

import XCTest

@testable import ContentstackUtils

class ContentstackUtilsJsonToHtmlTest: XCTestCase {
    let defaultRender = DefaultRender()

    func testEmpty_Node_Returns_Empty_String()  {
        let node = NodeParser.parse(from: kBlankDocument)

        let result = ContentstackUtils.jsonToHtml(node: node, defaultRender)

        XCTAssertEqual(result, "")
    }
    
    func testEmpty_Nodes_Array_Returns_Empty_String_Array()  {
        let node = NodeParser.parse(from: kBlankDocument)

        let result = ContentstackUtils.jsonToHtml(node: [node], defaultRender)

        XCTAssertEqual(result, [""])
    }
    
    func testPlainText_Document_Return_HtmlString_Result()  {
        let node = NodeParser.parse(from: kPlainTextJson)

        let result = ContentstackUtils.jsonToHtml(node: node, defaultRender)

        XCTAssertEqual(result, kPlainTextHtml)
    }
    
    func testArray_PlainText_Document_Return_HtmlString_Result()  {
        let node = NodeParser.parse(from: kPlainTextJson)

        let result = ContentstackUtils.jsonToHtml(node: [node], defaultRender)

        XCTAssertEqual(result, [kPlainTextHtml])
    }
    
    func testAsset_Reference_Document() {
        let node = NodeParser.parse(from: kAssetReferenceJson)

        var result = ContentstackUtils.jsonToHtml(node: node, defaultRender)

        XCTAssertEqual(result, "")

        result = ContentstackUtils.jsonToHtml(node: node,
                                                  DefaultRender(entry:
                                                                    EmbeddedModel("", embedAssetUID: "blt44asset")))

        XCTAssertEqual(result, "<img src=\"url\" alt=\"title\" />")

    }
    
    func testAssetArray_Reference_Document() {
        let node = NodeParser.parse(from: kAssetReferenceJson)

        
        var result = ContentstackUtils.jsonToHtml(node: [node], defaultRender)

        XCTAssertEqual(result, [""])
        
        result = ContentstackUtils.jsonToHtml(node: [node],
                                                  DefaultRender(entry:
                                                                    EmbeddedModel("", embedAssetUID: "blt44asset")))

        XCTAssertEqual(result, ["<img src=\"url\" alt=\"title\" />"])
    }
    
    func testEntryBlock_Reference_Document() {
        let node = NodeParser.parse(from: kEntryReferenceBlockJson)

        var result = ContentstackUtils.jsonToHtml(node: node, defaultRender)

        XCTAssertEqual(result, "")

        result = ContentstackUtils.jsonToHtml(node: node,
                                                  DefaultRender(entry:
                                                                    EmbeddedModel("",
                                                                                  embedContentUID: "blttitleuid",
                                                                                  embedContentTypeUID: "content_block")))

        XCTAssertEqual(result, "<div><p>blttitleuid</p><p>Content type: <span>contentTypeUid</span></p></div>")

    }
    
    func testEntryBlockArray_Reference_Document() {
        let node = NodeParser.parse(from: kEntryReferenceBlockJson)

        
        var result = ContentstackUtils.jsonToHtml(node: [node], defaultRender)

        XCTAssertEqual(result, [""])
        
        result = ContentstackUtils.jsonToHtml(node: [node],
                                                  DefaultRender(entry:
                                                                    EmbeddedModel("",
                                                                                  embedContentUID: "blttitleuid",
                                                                                  embedContentTypeUID: "content_block")))

        XCTAssertEqual(result, ["<div><p>blttitleuid</p><p>Content type: <span>contentTypeUid</span></p></div>"])
    }
    
    func testEntryLink_Reference_Document() {
        let node = NodeParser.parse(from: kEntryReferenceLinkJson)

        var result = ContentstackUtils.jsonToHtml(node: node, defaultRender)

        XCTAssertEqual(result, "")

        result = ContentstackUtils.jsonToHtml(node: node,
                                                  DefaultRender(entry:
                                                                    EmbeddedModel("",
                                                                                  embedContentUID: "bltemmbedEntryuid",
                                                                                  embedContentTypeUID: "embeddedrte")))

        XCTAssertEqual(result, "<a href=\"bltemmbedEntryuid\">/copy-of-entry-final-02</a>")

    }

    func testEntryLinkArray_Reference_Document() {
        let node = NodeParser.parse(from: kEntryReferenceLinkJson)

        
        var result = ContentstackUtils.jsonToHtml(node: [node], defaultRender)

        XCTAssertEqual(result, [""])
        
        result = ContentstackUtils.jsonToHtml(node: [node],
                                                  DefaultRender(entry:
                                                                    EmbeddedModel("",
                                                                                  embedContentUID: "bltemmbedEntryuid",
                                                                                  embedContentTypeUID: "embeddedrte")))

        XCTAssertEqual(result, ["<a href=\"bltemmbedEntryuid\">/copy-of-entry-final-02</a>"])
    }

    func testEntryInline_Reference_Document() {
        let node = NodeParser.parse(from: kEntryReferenceInlineJson)

        var result = ContentstackUtils.jsonToHtml(node: node, defaultRender)

        XCTAssertEqual(result, "")

        result = ContentstackUtils.jsonToHtml(node: node,
                                                  DefaultRender(entry:
                                                                    EmbeddedModel("",
                                                                                  embedContentUID: "blttitleUpdateuid",
                                                                                  embedContentTypeUID: "embeddedrte")))

        XCTAssertEqual(result, "<span>blttitleUpdateuid</span>")

    }
    
    func testEntryInlineArray_Reference_Document() {
        let node = NodeParser.parse(from: kEntryReferenceInlineJson)

        
        var result = ContentstackUtils.jsonToHtml(node: [node], defaultRender)

        XCTAssertEqual(result, [""])
        
        result = ContentstackUtils.jsonToHtml(node: [node],
                                                  DefaultRender(entry:
                                                                    EmbeddedModel("",
                                                                                  embedContentUID: "blttitleUpdateuid",
                                                                                  embedContentTypeUID: "embeddedrte")))

        XCTAssertEqual(result, ["<span>blttitleUpdateuid</span>"])
    }
    
    func testParagraph_Document()  {
        let node = NodeParser.parse(from: kParagraphJson)
        
        let result = ContentstackUtils.jsonToHtml(node: node, defaultRender)
        
        XCTAssertEqual(result, kParagraphHtml)
    }
    
    func testParagraphArray_Document()  {
        let node = NodeParser.parse(from: kParagraphJson)
        
        let result = ContentstackUtils.jsonToHtml(node: [node], defaultRender)
        
        XCTAssertEqual(result, [kParagraphHtml])
    }
    
    func testLink_Document()  {
        let node = NodeParser.parse(from: kLinkInPJson)
        
        let result = ContentstackUtils.jsonToHtml(node: node, defaultRender)
        
        XCTAssertEqual(result, kLinkInPHtml)
    }
    
    func testLinkArray_Document()  {
        let node = NodeParser.parse(from: kLinkInPJson)
        
        let result = ContentstackUtils.jsonToHtml(node: [node], defaultRender)
        
        XCTAssertEqual(result, [kLinkInPHtml])
    }
    
    func testImage_Document()  {
        let node = NodeParser.parse(from: kImgJson)
        
        let result = ContentstackUtils.jsonToHtml(node: node, defaultRender)
        
        XCTAssertEqual(result, kImgHtml)
    }
    
    func testImageArray_Document()  {
        let node = NodeParser.parse(from: kImgJson)
        
        let result = ContentstackUtils.jsonToHtml(node: [node], defaultRender)
        
        XCTAssertEqual(result, [kImgHtml])
    }
    
    func testEmbed_Document()  {
        let node = NodeParser.parse(from: kEmbedJson)
        
        let result = ContentstackUtils.jsonToHtml(node: node, defaultRender)
        
        XCTAssertEqual(result, kEmbedHtml)
    }
    
    func testEmbedArray_Document()  {
        let node = NodeParser.parse(from: kEmbedJson)
        
        let result = ContentstackUtils.jsonToHtml(node: [node], defaultRender)
        
        XCTAssertEqual(result, [kEmbedHtml])
    }
    
    func testH1_Document()  {
        let node = NodeParser.parse(from: kH1Json)
        
        let result = ContentstackUtils.jsonToHtml(node: node, defaultRender)
        
        XCTAssertEqual(result, kH1Html)
    }
    
    func testH1kArray_Document()  {
        let node = NodeParser.parse(from: kH1Json)
        
        let result = ContentstackUtils.jsonToHtml(node: [node], defaultRender)
        
        XCTAssertEqual(result, [kH1Html])
    }
    
    func testH2_Document()  {
        let node = NodeParser.parse(from: kH2Json)
        
        let result = ContentstackUtils.jsonToHtml(node: node, defaultRender)
        
        XCTAssertEqual(result, kH2Html)
    }
    
    func testH2Array_Document()  {
        let node = NodeParser.parse(from: kH2Json)
        
        let result = ContentstackUtils.jsonToHtml(node: [node], defaultRender)
        
        XCTAssertEqual(result, [kH2Html])
    }
    
    func testH3_Document()  {
        let node = NodeParser.parse(from: kH3Json)
        
        let result = ContentstackUtils.jsonToHtml(node: node, defaultRender)
        
        XCTAssertEqual(result, kH3Html)
    }
    
    func testH3Array_Document()  {
        let node = NodeParser.parse(from: kH3Json)
        
        let result = ContentstackUtils.jsonToHtml(node: [node], defaultRender)
        
        XCTAssertEqual(result, [kH3Html])
    }
    
    func testH4_Document()  {
        let node = NodeParser.parse(from: kH4Json)
        
        let result = ContentstackUtils.jsonToHtml(node: node, defaultRender)
        
        XCTAssertEqual(result, kH4Html)
    }
    
    func testH4Array_Document()  {
        let node = NodeParser.parse(from: kH4Json)
        
        let result = ContentstackUtils.jsonToHtml(node: [node], defaultRender)
        
        XCTAssertEqual(result, [kH4Html])
    }
    
    func testH5_Document()  {
        let node = NodeParser.parse(from: kH5Json)
        
        let result = ContentstackUtils.jsonToHtml(node: node, defaultRender)
        
        XCTAssertEqual(result, kH5Html)
    }
    
    func testH5Array_Document()  {
        let node = NodeParser.parse(from: kH5Json)
        
        let result = ContentstackUtils.jsonToHtml(node: [node], defaultRender)
        
        XCTAssertEqual(result, [kH5Html])
    }
    
    func testH6_Document()  {
        let node = NodeParser.parse(from: kH6Json)
        
        let result = ContentstackUtils.jsonToHtml(node: node, defaultRender)
        
        XCTAssertEqual(result, kH6Html)
    }
    
    func testH6Array_Document()  {
        let node = NodeParser.parse(from: kH6Json)
        
        let result = ContentstackUtils.jsonToHtml(node: [node], defaultRender)
        
        XCTAssertEqual(result, [kH6Html])
    }
    
    func testOrderList_Document()  {
        let node = NodeParser.parse(from: kOrderListJson)
        
        let result = ContentstackUtils.jsonToHtml(node: node, defaultRender)
        
        XCTAssertEqual(result, kOrderListHtml)
    }
    
    func testOrderListArray_Document()  {
        let node = NodeParser.parse(from: kOrderListJson)
        
        let result = ContentstackUtils.jsonToHtml(node: [node], defaultRender)
        
        XCTAssertEqual(result, [kOrderListHtml])
    }
    
    func testUnorderList_Document()  {
        let node = NodeParser.parse(from: kUnorderListJson)
        
        let result = ContentstackUtils.jsonToHtml(node: node, defaultRender)
        
        XCTAssertEqual(result, kIUnorderListHtml)
    }
    
    func testUnorderListArray_Document()  {
        let node = NodeParser.parse(from: kUnorderListJson)
        
        let result = ContentstackUtils.jsonToHtml(node: [node], defaultRender)
        
        XCTAssertEqual(result, [kIUnorderListHtml])
    }
    
    func testTable_Document()  {
        let node = NodeParser.parse(from: kTableJson)
        
        let result = ContentstackUtils.jsonToHtml(node: node, defaultRender)
        
        XCTAssertEqual(result, kTableHtml)
    }
    
    func testTableArray_Document()  {
        let node = NodeParser.parse(from: kTableJson)
        
        let result = ContentstackUtils.jsonToHtml(node: [node], defaultRender)
        
        XCTAssertEqual(result, [kTableHtml])
    }
    
    func testBlockquote_Document()  {
        let node = NodeParser.parse(from: kBlockquoteJson)
        
        let result = ContentstackUtils.jsonToHtml(node: node, defaultRender)
        
        XCTAssertEqual(result, kBlockquoteHtml)
    }
    
    func testBlockquoteArray_Document()  {
        let node = NodeParser.parse(from: kBlockquoteJson)
        
        let result = ContentstackUtils.jsonToHtml(node: [node], defaultRender)
        
        XCTAssertEqual(result, [kBlockquoteHtml])
    }
    
    func testCode_Document()  {
        let node = NodeParser.parse(from: kCodeJson)
        
        let result = ContentstackUtils.jsonToHtml(node: node, defaultRender)
        
        XCTAssertEqual(result, kCodeHtml)
    }
    
    func testCodeArray_Document()  {
        let node = NodeParser.parse(from: kCodeJson)
        
        let result = ContentstackUtils.jsonToHtml(node: [node], defaultRender)
        
        XCTAssertEqual(result, [kCodeHtml])
    }
    
    func testHR_Document()  {
        let node = NodeParser.parse(from: kHRJson)

        let result = ContentstackUtils.jsonToHtml(node: node, defaultRender)

        XCTAssertEqual(result, "<hr>")
    }

    func testHRArray_Document()  {
        let node = NodeParser.parse(from: kHRJson)

        let result = ContentstackUtils.jsonToHtml(node: [node], defaultRender)

        XCTAssertEqual(result, ["<hr>"])
    }
    
    static var allTests = [
        ("testEmpty_Node_Returns_Empty_String", testEmpty_Node_Returns_Empty_String),
        ("testEmpty_Nodes_Array_Returns_Empty_String_Array", testEmpty_Nodes_Array_Returns_Empty_String_Array),
        ("testPlainText_Document_Return_HtmlString_Result", testPlainText_Document_Return_HtmlString_Result),
        ("testArray_PlainText_Document_Return_HtmlString_Result", testArray_PlainText_Document_Return_HtmlString_Result),
        ("testAsset_Reference_Document", testAsset_Reference_Document),
        ("testAssetArray_Reference_Document", testAssetArray_Reference_Document),
        ("testEntryBlock_Reference_Document", testEntryBlock_Reference_Document),
        ("testEntryBlockArray_Reference_Document", testEntryBlockArray_Reference_Document),
        ("testEntryLink_Reference_Document", testEntryLink_Reference_Document),
        ("testEntryLinkArray_Reference_Document", testEntryLinkArray_Reference_Document),
        ("testEntryInline_Reference_Document", testEntryInline_Reference_Document),
        ("testEntryInlineArray_Reference_Document", testEntryInlineArray_Reference_Document),
        
        ("testParagraph_Document", testParagraph_Document),
        ("testParagraphArray_Document", testParagraphArray_Document),
        
        ("testLink_Document", testLink_Document),
        ("testLinkArray_Document", testLinkArray_Document),
        
        ("testImage_Document", testImage_Document),
        ("testImageArray_Document", testImageArray_Document),
        
        ("testEmbed_Document", testEmbed_Document),
        ("testEmbedArray_Document", testEmbedArray_Document),
        
        ("testH1_Document", testH1_Document),
        ("testH1kArray_Document", testH1kArray_Document),
        
        ("testH2_Document", testH2_Document),
        ("testH2Array_Document", testH2Array_Document),
        
        ("testH3_Document", testH3_Document),
        ("testH3Array_Document", testH3Array_Document),
        
        ("testH4_Document", testH4_Document),
        ("testH4Array_Document", testH4Array_Document),
        
        ("testH5_Document", testH5_Document),
        ("testH5Array_Document", testH5Array_Document),
        
        ("testH6_Document", testH6_Document),
        ("testH6Array_Document", testH6Array_Document),
        
        ("testOrderList_Document", testOrderList_Document),
        ("testOrderListArray_Document", testOrderListArray_Document),
        
        ("testUnorderList_Document", testUnorderList_Document),
        ("testUnorderListArray_Document", testUnorderListArray_Document),
        
        ("testHR_Document", testHR_Document),
        ("testHRArray_Document", testHRArray_Document),
        
        ("testTable_Document", testTable_Document),
        ("testTableArray_Document", testTableArray_Document),
        
        ("testBlockquote_Document", testBlockquote_Document),
        ("testBlockquoteArray_Document", testBlockquoteArray_Document),
        
        ("testCode_Document", testCode_Document),
        ("testCodeArray_Document", testCodeArray_Document),
    ]

}
