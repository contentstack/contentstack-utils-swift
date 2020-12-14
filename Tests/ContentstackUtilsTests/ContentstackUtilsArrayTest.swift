//
//  ContentstackUtilsArrayTest.swift
//  ContentstackUtilsTests
//
//  Created by Uttam Ukkoji on 03/11/20.
//

import XCTest
@testable import ContentstackUtils

class ContentstackUtilsArrayTest: XCTestCase {
    let defaultRender = DefaultRender(entry: EmbeddedModel(""))

    func testRenderBlankArray() {
        XCTAssertEqual(try? ContentstackUtils.render(contents: [""], defaultRender), [""])
    }

    func testRenderArray() {
        XCTAssertEqual(try ContentstackUtils.render(contents: ["<h1>TEST <h1>"], defaultRender),
                       ["<h1>TEST <h1></h1>\n</h1>"])
    }

    func testNonHtmlArray() {
        do {
            let result = try ContentstackUtils.render(contents: [kNoHTML], defaultRender)
            XCTAssertEqual(result, [kNoHTML])
        } catch {}
    }

    func testHtmlArray() {
        do {
            let result = try ContentstackUtils.render(contents: [kSimpleHTML], defaultRender)
            XCTAssertEqual(result, [kSimpleHTML])
        } catch {}
    }

    func testUnexpectedClose() {
        do {
            let result = try ContentstackUtils.render(contents: [kUnexpectedClose], defaultRender)
            XCTAssertEqual(result, ["<span>entryuid</span>"])
        } catch {}
    }

    func testNoChildmodel() {
        do {
            let result = try ContentstackUtils.render(contents: [kNoChildNode], defaultRender)
            XCTAssertEqual(result, ["<span>entryuid</span>"])
        } catch {}
    }

    func testAssetDisplay() {
        do {
            var result = try ContentstackUtils.render(contents: [kAssetDisplay], defaultRender)
            XCTAssertEqual(result, [""])

            result = try ContentstackUtils
                .render(contents: [kAssetDisplay],
                        DefaultRender(entry:
                            EmbeddedModel("", embedAssetUID: "blt55f6d8cbd7e03a1f")))
            XCTAssertEqual(result, ["<img src=\"url\" alt=\"title\" />"])

        } catch {}
    }

    func testEntryBlock() {
        do {
            var result = try ContentstackUtils.render(contents: [kEntryBlock], defaultRender)
            XCTAssertEqual(result, [""])

            result = try ContentstackUtils
                .render(contents: [kEntryBlock],
                        DefaultRender(entry:
                            EmbeddedModel("", embedContentUID: "blt55f6d8cbd7e03a1f", embedContentTypeUID: "article")))
            XCTAssertEqual(result,
                           ["<div><p>blt55f6d8cbd7e03a1f</p><p>Content type: <span>contentTypeUid</span></p></div>"])
        } catch {}
    }

    func testEntryInline() {
        do {
            var result = try ContentstackUtils.render(contents: [kEntryInline], defaultRender)
            XCTAssertEqual(result, [""])

            result = try ContentstackUtils
                .render(contents: [kEntryInline],
                        DefaultRender(entry:
                            EmbeddedModel("", embedContentUID: "blt55f6d8cbd7e03a1f", embedContentTypeUID: "article")))
            XCTAssertEqual(result,
                           ["<span>blt55f6d8cbd7e03a1f</span>"])
        } catch {}
    }

    func testEntryLink() {
        do {
            var result = try ContentstackUtils.render(contents: [kEntryLink], defaultRender)
            XCTAssertEqual(result, [""])

            result = try ContentstackUtils
                .render(contents: [kEntryLink],
                        DefaultRender(entry:
                            EmbeddedModel("", embedContentUID: "blt55f6d8cbd7e03a1f", embedContentTypeUID: "article")))
            XCTAssertEqual(result,
                           ["""
<a href="blt55f6d8cbd7e03a1f">
{{title}}
</a>
"""])
        } catch {}
    }

    func testAsset() {
        do {
            var result = try ContentstackUtils.render(contents: [kAssetEmbed], defaultRender)
            XCTAssertEqual(result, ["""

<p></p>
<p></p>

"""])
            let embModel = EmbeddedModel("")
            embModel.embeddedItems = ["rte": [
                EmbeddedAssetModel(uid: "blt8d49bb742bcf2c83"),
                EmbeddedAssetModel(uid: "blt120a5a04d91c9466")]]

            result = try ContentstackUtils
                .render(contents: [kAssetEmbed],
                        DefaultRender(entry: embModel))
            XCTAssertEqual(result, ["""
<img src="url" alt="title" />
<p></p>
<p></p>
<img src="url" alt="title" />
"""])
        } catch {}
    }

    func testEntryBlockLink () {
        do {
            var result = try ContentstackUtils.render(contents: ["\(kEntryBlock)\(kEntryLink)"], defaultRender)
            XCTAssertEqual(result, [""])

            result = try ContentstackUtils
                .render(contents: ["\(kEntryBlock)\(kEntryLink)"],
                        DefaultRender(entry:
                            EmbeddedModel("", embedContentUID: "blt55f6d8cbd7e03a1f", embedContentTypeUID: "article")))
            XCTAssertEqual(result, ["""
<div><p>blt55f6d8cbd7e03a1f</p><p>Content type: <span>contentTypeUid</span></p></div><a href="blt55f6d8cbd7e03a1f">
{{title}}
</a>
"""])
        } catch {}
    }

    func testEntryBlockLinkInline () {
        do {
            let rte = ["\(kEntryBlock)\(kEntryLink) \(kEntryInline)"]
            var result = try ContentstackUtils.render(contents: rte, defaultRender)
            XCTAssertEqual(result, [" "])

            result = try ContentstackUtils
                .render(contents: rte,
                        DefaultRender(entry:
                            EmbeddedModel("", embedContentUID: "blt55f6d8cbd7e03a1f", embedContentTypeUID: "article")))
            XCTAssertEqual(result, ["""
<div><p>blt55f6d8cbd7e03a1f</p><p>Content type: <span>contentTypeUid</span></p></div><a href="blt55f6d8cbd7e03a1f">
{{title}}
</a> <span>blt55f6d8cbd7e03a1f</span>
"""])
        } catch {}
    }

    func testAllEmbedStyles () {
        do {
            let rte = ["""
            \(kAssetDisplay)
            \(kEntryBlock)
            \(kEntryLink)
            \(kEntryInline)
            """]
            var result = try ContentstackUtils.render(contents: rte, defaultRender)
            XCTAssertEqual(result, ["""




"""])

            result = try ContentstackUtils
                .render(contents: rte,
                        DefaultRender(entry:
                            EmbeddedModel("", embedContentUID: "blt55f6d8cbd7e03a1f", embedContentTypeUID: "article")))
            XCTAssertEqual(result, ["""

<div><p>blt55f6d8cbd7e03a1f</p><p>Content type: <span>contentTypeUid</span></p></div>
<a href="blt55f6d8cbd7e03a1f">
{{title}}
</a>
<span>blt55f6d8cbd7e03a1f</span>
"""])
        } catch {}
    }

    func testContentBlockModel () {
        if let contentblock = TestDecodable.getMultilevelEmbed() {
            do {
                let result = try ContentstackUtils.render(contents:
                    [contentblock.rte, contentblock.richTextEditor],
                                                          DefaultRender(entry: contentblock))
                XCTAssertEqual(result, ["""
<div><p>blttitleuid</p><p>Content type: <span>embeddedrte</span></p></div>
<span>bltemmbedEntryUID</span>
<p></p>
""",
"""
<div><p>blttitleUpdateUID</p><p>Content type: <span>embeddedrte</span></p></div>
<p></p>

"""])
            } catch {

            }

        }
    }

    static var allTests = [
        ("testRenderBlankArray", testRenderBlankArray),
        ("testRenderArray", testRenderArray),
        ("testNonHtmlArray", testNonHtmlArray),
        ("testHtmlArray", testHtmlArray),
        ("testUnexpectedClose", testUnexpectedClose),
        ("testNoChildmodel", testNoChildmodel),
        ("testAssetDisplay", testAssetDisplay),
        ("testEntryBlock", testEntryBlock),
        ("testEntryInline", testEntryInline),
        ("testEntryLink", testEntryLink),
        ("testAsset", testAsset),
        ("testEntryBlockLink", testEntryBlockLink),
        ("testEntryBlockLinkInline", testEntryBlockLinkInline),
        ("testAllEmbedStyles", testAllEmbedStyles),
        ("testContentBlockModel", testContentBlockModel)
    ]

}
