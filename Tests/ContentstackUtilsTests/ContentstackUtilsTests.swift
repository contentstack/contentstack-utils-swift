import XCTest
@testable import ContentstackUtils

final class ContentstackUtilsTests: XCTestCase {
    let defaultRender = Option(entry: EmbeddedModel(kBlankString))
    func testRenderBlankString() {
        XCTAssertEqual(try? ContentstackUtils.render(content: kBlankString, defaultRender), kBlankString)
    }

    func testRenderString() {
        XCTAssertEqual(try ContentstackUtils.render(content: "<h1>TEST </h2>", defaultRender), "<h1>TEST </h1>")
    }

    func testNonHtmlString() {
        do {
            let result = try ContentstackUtils.render(content: kNoHTML, defaultRender)
            XCTAssertEqual(result, kNoHTML)
        } catch {}
    }

    func testHtmlString() {
        do {
            let result = try ContentstackUtils.render(content: kSimpleHTML, defaultRender)
            XCTAssertEqual(result, kSimpleHTML)
        } catch {}
    }

    func testUnexpectedClose() {
        do {
            let result = try ContentstackUtils.render(content: kUnexpectedClose, defaultRender)
            XCTAssertEqual(result, "<span>entryuid</span>")
        } catch {}
    }

    func testNoChildmodel() {
        do {
            let result = try ContentstackUtils.render(content: kNoChildNode, defaultRender)
            XCTAssertEqual(result, "<span>entryuid</span>")
        } catch {}
    }

    func testAssetDisplay() {
        do {
            var result = try ContentstackUtils.render(content: kAssetDisplay, defaultRender)
            XCTAssertEqual(result, "")

            result = try ContentstackUtils
                .render(content: kAssetDisplay,
                        Option(entry:
                            EmbeddedModel("", embedAssetUID: "blt55f6d8cbd7e03a1f")))
            XCTAssertEqual(result, "<img src=\"url\" alt=\"title\" />")

        } catch {}
    }

    func testEntryBlock() {
        do {
            var result = try ContentstackUtils.render(content: kEntryBlock, defaultRender)
            XCTAssertEqual(result, "")

            result = try ContentstackUtils
                .render(content: kEntryBlock,
                        Option(entry:
                            EmbeddedModel("", embedContentUID: "blt55f6d8cbd7e03a1f", embedContentTypeUID: "article")))
            XCTAssertEqual(result,
                           "<div><p>blt55f6d8cbd7e03a1f</p><p>Content type: <span>contentTypeUid</span></p></div>")
        } catch {}
    }

    func testEntryInline() {
        do {
            var result = try ContentstackUtils.render(content: kEntryInline, defaultRender)
            XCTAssertEqual(result, "")

            result = try ContentstackUtils
                .render(content: kEntryInline,
                        Option(entry:
                            EmbeddedModel("", embedContentUID: "blt55f6d8cbd7e03a1f", embedContentTypeUID: "article")))
            XCTAssertEqual(result,
                           "<span>blt55f6d8cbd7e03a1f</span>")
        } catch {}
    }

    func testEntryLink() {
        do {
            var result = try ContentstackUtils.render(content: kEntryLink, defaultRender)
            XCTAssertEqual(result, "")

            result = try ContentstackUtils
                .render(content: kEntryLink,
                        Option(entry:
                            EmbeddedModel("", embedContentUID: "blt55f6d8cbd7e03a1f", embedContentTypeUID: "article")))
            XCTAssertEqual(result,
                           """
<a href="blt55f6d8cbd7e03a1f">
{{title}}
</a>
""")
        } catch {}
    }

    func testAsset() {
        do {
            var result = try ContentstackUtils.render(content: kAssetEmbed, defaultRender)
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
                        Option(entry: embModel))
            XCTAssertEqual(result, """
<img src="url" alt="title" />
<p></p>
<p></p>
<img src="url" alt="title" />
""")
        } catch {}
    }

    func testEntryBlockLink () {
        do {
            var result = try ContentstackUtils.render(content: "\(kEntryBlock)\(kEntryLink)", defaultRender)
            XCTAssertEqual(result, "")

            result = try ContentstackUtils
                .render(content: "\(kEntryBlock)\(kEntryLink)",
                        Option(entry:
                            EmbeddedModel("", embedContentUID: "blt55f6d8cbd7e03a1f", embedContentTypeUID: "article")))
            XCTAssertEqual(result, """
<div><p>blt55f6d8cbd7e03a1f</p><p>Content type: <span>contentTypeUid</span></p></div><a href="blt55f6d8cbd7e03a1f">
{{title}}
</a>
""")
        } catch {}
    }

    func testEntryBlockLinkInline () {
        do {
            let rte = "\(kEntryBlock)\(kEntryLink) \(kEntryInline)"
            var result = try ContentstackUtils.render(content: rte, defaultRender)
            XCTAssertEqual(result, " ")

            result = try ContentstackUtils
                .render(content: rte,
                        Option(entry:
                            EmbeddedModel("", embedContentUID: "blt55f6d8cbd7e03a1f", embedContentTypeUID: "article")))
            XCTAssertEqual(result, """
<div><p>blt55f6d8cbd7e03a1f</p><p>Content type: <span>contentTypeUid</span></p></div><a href="blt55f6d8cbd7e03a1f">
{{title}}
</a> <span>blt55f6d8cbd7e03a1f</span>
""")
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
            var result = try ContentstackUtils.render(content: rte, defaultRender)
            XCTAssertEqual(result, """




""")

            result = try ContentstackUtils
                .render(content: rte,
                        Option(entry:
                            EmbeddedModel("", embedContentUID: "blt55f6d8cbd7e03a1f", embedContentTypeUID: "article")))
            XCTAssertEqual(result, """

<div><p>blt55f6d8cbd7e03a1f</p><p>Content type: <span>contentTypeUid</span></p></div>
<a href="blt55f6d8cbd7e03a1f">
{{title}}
</a>
<span>blt55f6d8cbd7e03a1f</span>
""")
        } catch {}
    }

    func testContentBlockModel () {
        if let contentblock = TestDecodable.getMultilevelEmbed() {
            do {
                var result = try ContentstackUtils.render(content: contentblock.rte, Option(entry: contentblock))
                XCTAssertEqual(result, """
<div><p>blttitleuid</p><p>Content type: <span>embeddedrte</span></p></div>
<span>bltemmbedEntryUID</span>
<p></p>
""")

                result = try ContentstackUtils
                    .render(content: contentblock.richTextEditor,
                            Option(entry: contentblock))
                XCTAssertEqual(result, """
<div><p>blttitleUpdateUID</p><p>Content type: <span>embeddedrte</span></p></div>
<p></p>

""")
            } catch {

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
