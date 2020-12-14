//
//  ContentstackUtilsCustomRendertest.swift
//  ContentstackUtilsTests
//
//  Created by Uttam Ukkoji on 03/11/20.
//

import XCTest
@testable import ContentstackUtils

final class ContentstackUtilsCustomRendertest: XCTestCase {
    let customRender = CustomRenderOption(entry: EmbeddedModel(""))
    func testRenderBlankString() {
        XCTAssertEqual(try? ContentstackUtils.render(content: "", customRender), "")
    }

    func testRenderString() {
        XCTAssertEqual(try ContentstackUtils.render(content: "<h1>TEST </h2>", customRender), "<h1>TEST </h1>")
    }

    func testNonHtmlString() {
        do {
            let result = try ContentstackUtils.render(content: kNoHTML, customRender)
            XCTAssertEqual(result, kNoHTML)
        } catch {}
    }

    func testHtmlString() {
        do {
            let result = try ContentstackUtils.render(content: kSimpleHTML, customRender)
            XCTAssertEqual(result, kSimpleHTML)
        } catch {}
    }

    func testUnexpectedClose() {
        do {
            let result = try ContentstackUtils.render(content: kUnexpectedClose, customRender)
            XCTAssertEqual(result, kUnexpectedResult)
        } catch {}
    }

    func testNoChildmodel() {
        do {
            let result = try ContentstackUtils.render(content: kNoChildNode, customRender)
            XCTAssertEqual(result, kUnexpectedResult)
        } catch {}
    }

    func testAssetDisplay() {
        do {
            var result = try ContentstackUtils.render(content: kAssetDisplay, customRender)
            XCTAssertEqual(result, "")

            result = try ContentstackUtils
                .render(content: kAssetDisplay,
                        CustomRenderOption(entry:
                            EmbeddedModel("", embedAssetUID: "blt55f6d8cbd7e03a1f")))
            XCTAssertEqual(result, kAssetDisplayCustomResult)

        } catch {}
    }

    func testEntryBlock() {
        do {
            var result = try ContentstackUtils.render(content: kEntryBlock, customRender)
            XCTAssertEqual(result, "")

            result = try ContentstackUtils
                .render(content: kEntryBlock,
                        CustomRenderOption(entry:
                            EmbeddedModel("", embedContentUID: "blt55f6d8cbd7e03a1f", embedContentTypeUID: "article")))
            XCTAssertEqual(result, kEntryBlockCustomResult)
        } catch {}
    }

    func testEntryInline() {
        do {
            var result = try ContentstackUtils.render(content: kEntryInline, customRender)
            XCTAssertEqual(result, "")

            result = try ContentstackUtils
                .render(content: kEntryInline,
                        CustomRenderOption(entry:
                            EmbeddedModel("", embedContentUID: "blt55f6d8cbd7e03a1f", embedContentTypeUID: "article")))
            XCTAssertEqual(result, kEntryInlineCustomeResult)
        } catch {}
    }

    func testEntryLink() {
        do {
            var result = try ContentstackUtils.render(content: kEntryLink, customRender)
            XCTAssertEqual(result, "")

            result = try ContentstackUtils
                .render(content: kEntryLink,
                        CustomRenderOption(entry:
                            EmbeddedModel("", embedContentUID: "blt55f6d8cbd7e03a1f", embedContentTypeUID: "article")))
            XCTAssertEqual(result, kEntryLinkCustomResult)
        } catch {}
    }

    func testAsset() {
        do {
            var result = try ContentstackUtils.render(content: kAssetEmbed, customRender)
            XCTAssertEqual(result, """

<p></p>
<p></p>

""")
            let embModel = EmbeddedModel("")
            embModel.embeddedItems = ["rte": [
                EmbeddedAssetModel(uid: "blt8d49bb742bcf2c83"),
                EmbeddedAssetModel(uid: "blt120a5a04d91c9466")]]

            result = try ContentstackUtils
                .render(content: kAssetEmbed,
                        CustomRenderOption(entry: embModel))
            XCTAssertEqual(result, kAssetdisplayCustomResult)
        } catch {}
    }

    func testEntryBlockLink () {
        do {
            var result = try ContentstackUtils.render(content: "\(kEntryBlock)\(kEntryLink)", customRender)
            XCTAssertEqual(result, "")

            result = try ContentstackUtils
                .render(content: "\(kEntryBlock)\(kEntryLink)",
                        CustomRenderOption(entry:
                            EmbeddedModel("", embedContentUID: "blt55f6d8cbd7e03a1f", embedContentTypeUID: "article")))
            XCTAssertEqual(result, kEntryBlockLinkCustomResult)
        } catch {}
    }

    func testEntryBlockLinkInline () {
        do {
            let rte = "\(kEntryBlock)\(kEntryLink) \(kEntryInline)"
            var result = try ContentstackUtils.render(content: rte, customRender)
            XCTAssertEqual(result, " ")

            result = try ContentstackUtils
                .render(content: rte,
                        CustomRenderOption(entry:
                            EmbeddedModel("", embedContentUID: "blt55f6d8cbd7e03a1f", embedContentTypeUID: "article")))
            XCTAssertEqual(result, kEntryBlockLinkInlineCustomResult)
        } catch {}
    }

    func testAllEmbedStyles () {
        do {
            let rte = """
            \(kAssetDisplay)
            \(kEntryBlock)
            \(kEntryLink)
            \(kEntryInline)
            """
            var result = try ContentstackUtils.render(content: rte, customRender)
            XCTAssertEqual(result, """




""")

            result = try ContentstackUtils
                .render(content: rte,
                        CustomRenderOption(entry:
                            EmbeddedModel("", embedContentUID: "blt55f6d8cbd7e03a1f", embedContentTypeUID: "article")))
            XCTAssertEqual(result, kAllEmbedCustomeResult)
        } catch {}
    }

    func testContentBlockModel () {
        if let contentblock = TestDecodable.getMultilevelEmbed() {
            do {
                var result = try ContentstackUtils.render(content: contentblock.rte,
                                                          CustomRenderOption(entry: contentblock))
                XCTAssertEqual(result, kContentblockRTEResult)

                result = try ContentstackUtils
                    .render(content: contentblock.richTextEditor,
                            CustomRenderOption(entry: contentblock))
                XCTAssertEqual(result, kContentblockRichTextResult)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }

    static var allTests = [
        ("testRenderBlankString", testRenderBlankString),
        ("testRenderString", testRenderString),
        ("testNonHtmlString", testNonHtmlString),
        ("testHtmlString", testHtmlString),
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
