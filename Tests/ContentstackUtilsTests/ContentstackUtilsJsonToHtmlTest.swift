//
//  ContentstackUtilsJsonToHtmlTest.swift
//  ContentstackUtilsTests
//
//  Created by Uttam Ukkoji on 07/06/21.
//

import XCTest

@testable import ContentstackUtils

class ContentstackUtilsJsonToHtmlTest: XCTestCase {
    let defaultRender = DefaultRender(entry: EmbeddedModel(""))

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
    
    static var allTests = [
        ("testEmpty_Node_Returns_Empty_String", testEmpty_Node_Returns_Empty_String),
        ("testEmpty_Nodes_Array_Returns_Empty_String_Array", testEmpty_Nodes_Array_Returns_Empty_String_Array),
        ("testPlainText_Document_Return_HtmlString_Result", testPlainText_Document_Return_HtmlString_Result),
        ("testArray_PlainText_Document_Return_HtmlString_Result", testArray_PlainText_Document_Return_HtmlString_Result),
        ("testAsset_Reference_Document", testAsset_Reference_Document),
        ("testAssetArray_Reference_Document", testAssetArray_Reference_Document),
    ]

}

