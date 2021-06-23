//
//  OptionTests.swift
//  ContentstackUtilsTests
//
//  Created by Uttam Ukkoji on 28/09/20.
//

import XCTest
@testable import ContentstackUtils

class OptionTests: XCTestCase {
    let defaultRender = Option(entry: EmbeddedModel(""))
    let embedded = Embedded()
    let embeddedEntry = EmbeddedEntryModel()
    let embeddedContentType = EmbeddedContentTypeUidModel(contentTypeUID: "data-sys-content-type-uid")
    let embeddedAsset = EmbeddedAssetModel()
    let text: String = "Text To set Link"
    func testEmbedded() {
        let blockString = defaultRender.renderItem(embeddedObject: self.embedded, metadata: getMetaData())
        XCTAssertEqual(blockString, self.embedded.renderString(.block))

        let inlineString = defaultRender.renderItem(embeddedObject: self.embedded,
                                                       metadata: getMetaData(styleType: .inline))
        XCTAssertEqual(inlineString, self.embedded.renderString(.inline))

        let linkString = defaultRender.renderItem(embeddedObject: self.embedded,
                                                     metadata: getMetaData(styleType: .link))
        XCTAssertEqual(linkString, self.embedded.renderString(.link))

        let displayString = defaultRender.renderItem(embeddedObject: self.embedded,
                                                        metadata: getMetaData(styleType: .display))
        XCTAssertEqual(displayString, self.embedded.renderString(.display))
    }

    func testEmbeddedContentTypeEntry() {
        let blockString = defaultRender.renderItem(embeddedObject: self.embeddedContentType, metadata: getMetaData())
        XCTAssertEqual(blockString, self.embeddedContentType.renderString(.block))

        let inlineString = defaultRender.renderItem(embeddedObject: self.embeddedContentType,
                                                       metadata: getMetaData(styleType: .inline))
        XCTAssertEqual(inlineString, self.embeddedContentType.renderString(.inline))

        let linkString = defaultRender.renderItem(embeddedObject: self.embeddedContentType,
                                                     metadata: getMetaData(styleType: .link))
        XCTAssertEqual(linkString, self.embeddedContentType.renderString(.link))
    }

    func testEmbeddedEntry() {
        let blockString = defaultRender.renderItem(embeddedObject: self.embeddedEntry, metadata: getMetaData())
        XCTAssertEqual(blockString, self.embeddedEntry.renderString(.block))

        let inlineString = defaultRender.renderItem(embeddedObject: self.embeddedEntry,
                                                       metadata: getMetaData(styleType: .inline))
        XCTAssertEqual(inlineString, self.embeddedEntry.renderString(.inline))

        let linkString = defaultRender.renderItem(embeddedObject: self.embeddedEntry,
                                                     metadata: getMetaData(styleType: .link))
        XCTAssertEqual(linkString, self.embeddedEntry.renderString(.link))
    }

    func testEmbeddedAsset() {
        let displayString = defaultRender.renderItem(embeddedObject: self.embeddedAsset,
                                                        metadata: getMetaData(styleType: .display))
        XCTAssertEqual(displayString, self.embeddedAsset.renderString(.display))
    }

    func testEmbeddedWithText() {
        let blockString = defaultRender.renderItem(embeddedObject: self.embedded, metadata: getMetaData(text: text))
        XCTAssertEqual(blockString, self.embedded.renderString(.block, text: text))

        let inlineString = defaultRender.renderItem(embeddedObject: self.embedded,
                                                       metadata: getMetaData(styleType: .inline, text: text))
        XCTAssertEqual(inlineString, self.embedded.renderString(.inline, text: text))

        let linkString = defaultRender.renderItem(embeddedObject: self.embedded,
                                                     metadata: getMetaData(styleType: .link, text: text))
        XCTAssertEqual(linkString, self.embedded.renderString(.link, text: text))

        let displayString = defaultRender.renderItem(embeddedObject: self.embedded,
                                                        metadata: getMetaData(styleType: .display, text: text))
        XCTAssertEqual(displayString, self.embedded.renderString(.display, text: text))
       }

    func testEmbeddedContentTypeEntryWithText() {
        let blockString = defaultRender.renderItem(embeddedObject: self.embeddedContentType,
                                                      metadata: getMetaData(styleType: .block, text: text))
        XCTAssertEqual(blockString, self.embeddedContentType.renderString(.block, text: text))

        let inlineString = defaultRender
            .renderItem(embeddedObject: self.embeddedContentType,
                           metadata: getMetaData(styleType: .inline, text: text))
        XCTAssertEqual(inlineString, self.embeddedContentType.renderString(.inline, text: text))

        let linkString = defaultRender.renderItem(embeddedObject: self.embeddedContentType,
                                                     metadata: getMetaData(styleType: .link, text: text))
        XCTAssertEqual(linkString, self.embeddedContentType.renderString(.link, text: text))
    }

    func testEmbeddedEntryWithText() {
        let blockString = defaultRender.renderItem(embeddedObject: self.embeddedEntry,
                                                      metadata: getMetaData(styleType: .block, text: text))
        XCTAssertEqual(blockString, self.embeddedEntry.renderString(.block, text: text))

        let inlineString = defaultRender.renderItem(embeddedObject: self.embeddedEntry,
                                                       metadata: getMetaData(styleType: .inline, text: text))
        XCTAssertEqual(inlineString, self.embeddedEntry.renderString(.inline, text: text))

        let linkString = defaultRender.renderItem(embeddedObject: self.embeddedEntry,
                                                     metadata: getMetaData(styleType: .link, text: text))
        XCTAssertEqual(linkString, self.embeddedEntry.renderString(.link, text: text))
    }
    
    func testMarkTypeRender() {
        let boldString = defaultRender.renderMark(markType: .bold, text: text)
        XCTAssertEqual(boldString, "<strong>\(text)</strong>")
        let italicString = defaultRender.renderMark(markType: .italic, text: text)
        XCTAssertEqual(italicString, "<em>\(text)</em>")
        let underlineString = defaultRender.renderMark(markType: .underline, text: text)
        XCTAssertEqual(underlineString, "<u>\(text)</u>")
        let strickthroughString = defaultRender.renderMark(markType: .strikethrough, text: text)
        XCTAssertEqual(strickthroughString, "<strike>\(text)</strike>")
        let inlineCodeString = defaultRender.renderMark(markType: .inlineCode, text: text)
        XCTAssertEqual(inlineCodeString, "<span>\(text)</span>")
        let subscriptString = defaultRender.renderMark(markType: .subscript, text: text)
        XCTAssertEqual(subscriptString, "<sub>\(text)</sub>")
        let superscriptString = defaultRender.renderMark(markType: .superscript, text: text)
        XCTAssertEqual(superscriptString, "<sup>\(text)</sup>")
    }
    
    func testParagraphRender() {
        let node = NodeParser.parse(from: kBlankDocument)
        
        let result = defaultRender.renderNode(nodeType: NodeType.paragraph.rawValue, node: node, next: { _ in
            return text
        })
        XCTAssertEqual(result, "<p>\(text)</p>")
    }
    
    func testLinkRender() {
        let node = NodeParser.parse(from: kBlankDocument)
        
        let result = defaultRender.renderNode(nodeType: NodeType.link.rawValue, node: node, next: { _ in
            return text
        })
        XCTAssertEqual(result, "<a href=\"\">\(text)</a>")
    }

    func testImageRender() {
        let node = NodeParser.parse(from: kBlankDocument)

        let result = defaultRender.renderNode(nodeType: NodeType.image.rawValue, node: node, next: { _ in
            return text
        })
        XCTAssertEqual(result, "<img src=\"\" />\(text)")
    }

    func testEmbedRender() {
        let node = NodeParser.parse(from: kBlankDocument)

        let result = defaultRender.renderNode(nodeType: NodeType.embed.rawValue, node: node, next: { _ in
            return text
        })
        XCTAssertEqual(result, "<iframe src=\"\">\(text)</iframe>")
    }

    func testH1Render() {
        let node = NodeParser.parse(from: kBlankDocument)

        let result = defaultRender.renderNode(nodeType: NodeType.heading_1.rawValue, node: node, next: { _ in
            return text
        })
        XCTAssertEqual(result, "<h1>\(text)</h1>")
    }

    func testH2Render() {
        let node = NodeParser.parse(from: kBlankDocument)

        let result = defaultRender.renderNode(nodeType: NodeType.heading_2.rawValue, node: node, next: { _ in
            return text
        })
        XCTAssertEqual(result, "<h2>\(text)</h2>")
    }

    func testH3Render() {
        let node = NodeParser.parse(from: kBlankDocument)

        let result = defaultRender.renderNode(nodeType: NodeType.heading_3.rawValue, node: node, next: { _ in
            return text
        })
        XCTAssertEqual(result, "<h3>\(text)</h3>")
    }

    func testH4Render() {
        let node = NodeParser.parse(from: kBlankDocument)

        let result = defaultRender.renderNode(nodeType: NodeType.heading_4.rawValue, node: node, next: { _ in
            return text
        })
        XCTAssertEqual(result, "<h4>\(text)</h4>")
    }

    func testH5Render() {
        let node = NodeParser.parse(from: kBlankDocument)

        let result = defaultRender.renderNode(nodeType: NodeType.heading_5.rawValue, node: node, next: { _ in
            return text
        })
        XCTAssertEqual(result, "<h5>\(text)</h5>")
    }

    func testH6Render() {
        let node = NodeParser.parse(from: kBlankDocument)

        let result = defaultRender.renderNode(nodeType: NodeType.heading_6.rawValue, node: node, next: { _ in
            return text
        })
        XCTAssertEqual(result, "<h6>\(text)</h6>")
    }

    func testOrderListRender() {
        let node = NodeParser.parse(from: kBlankDocument)

        let result = defaultRender.renderNode(nodeType: NodeType.orderList.rawValue, node: node, next: { _ in
            return text
        })
        XCTAssertEqual(result, "<ol>\(text)</ol>")
    }

    func testUnorderListRender() {
        let node = NodeParser.parse(from: kBlankDocument)

        let result = defaultRender.renderNode(nodeType: NodeType.unOrderList.rawValue, node: node, next: { _ in
            return text
        })
        XCTAssertEqual(result, "<ul>\(text)</ul>")
    }

    func testListItemRender() {
        let node = NodeParser.parse(from: kBlankDocument)

        let result = defaultRender.renderNode(nodeType: NodeType.listItem.rawValue, node: node, next: { _ in
            return text
        })
        XCTAssertEqual(result, "<li>\(text)</li>")
    }

    func testHRRender() {
        let node = NodeParser.parse(from: kBlankDocument)

        let result = defaultRender.renderNode(nodeType: NodeType.hr.rawValue, node: node, next: { _ in
            return text
        })
        XCTAssertEqual(result, "<hr>")
    }

    func testTableRender() {
        let node = NodeParser.parse(from: kBlankDocument)

        let result = defaultRender.renderNode(nodeType: NodeType.table.rawValue, node: node, next: { _ in
            return text
        })
        XCTAssertEqual(result, "<table>\(text)</table>")
    }

    func testTableHeaderRender() {
        let node = NodeParser.parse(from: kBlankDocument)

        let result = defaultRender.renderNode(nodeType: NodeType.tableHeader.rawValue, node: node, next: { _ in
            return text
        })
        XCTAssertEqual(result, "<thead>\(text)</thead>")
    }

    func testTableBodyRender() {
        let node = NodeParser.parse(from: kBlankDocument)

        let result = defaultRender.renderNode(nodeType: NodeType.tableBody.rawValue, node: node, next: { _ in
            return text
        })
        XCTAssertEqual(result, "<tbody>\(text)</tbody>")
    }

    func testTableFooterRender() {
        let node = NodeParser.parse(from: kBlankDocument)

        let result = defaultRender.renderNode(nodeType: NodeType.tableFooter.rawValue, node: node, next: { _ in
            return text
        })
        XCTAssertEqual(result, "<tfoot>\(text)</tfoot>")
    }

    func testTableRowRender() {
        let node = NodeParser.parse(from: kBlankDocument)

        let result = defaultRender.renderNode(nodeType: NodeType.tableRow.rawValue, node: node, next: { _ in
            return text
        })
        XCTAssertEqual(result, "<tr>\(text)</tr>")
    }

    func testTableHeadRender() {
        let node = NodeParser.parse(from: kBlankDocument)

        let result = defaultRender.renderNode(nodeType: NodeType.tableHead.rawValue, node: node, next: { _ in
            return text
        })
        XCTAssertEqual(result, "<th>\(text)</th>")
    }

    func testTableDataRender() {
        let node = NodeParser.parse(from: kBlankDocument)

        let result = defaultRender.renderNode(nodeType: NodeType.tableData.rawValue, node: node, next: { _ in
            return text
        })
        XCTAssertEqual(result, "<td>\(text)</td>")
    }

    func testBlockquoteRender() {
        let node = NodeParser.parse(from: kBlankDocument)

        let result = defaultRender.renderNode(nodeType: NodeType.blockQuote.rawValue, node: node, next: { _ in
            return text
        })
        XCTAssertEqual(result, "<blockquote>\(text)</blockquote>")
    }

    func testCodeRender() {
        let node = NodeParser.parse(from: kBlankDocument)

        let result = defaultRender.renderNode(nodeType: NodeType.code.rawValue, node: node, next: { _ in
            return text
        })
        XCTAssertEqual(result, "<code>\(text)</code>")
    }

    func testDocumentRender() {
        let node = NodeParser.parse(from: kBlankDocument)

        let result = defaultRender.renderNode(nodeType: NodeType.document.rawValue, node: node, next: { _ in
            return text
        })
        XCTAssertEqual(result, text)
    }
    
    func testreferenceRender() {
        let node = NodeParser.parse(from: kBlankDocument)

        let result = defaultRender.renderNode(nodeType: NodeType.reference.rawValue, node: node, next: { _ in
            return text
        })
        XCTAssertEqual(result, text)
    }
    
    func testEmbeddedAssetWithText() {
        let displayString = defaultRender.renderItem(embeddedObject: self.embeddedAsset,
                                                        metadata: getMetaData(styleType: .display, text: text))
        XCTAssertEqual(displayString, self.embeddedAsset.renderString(.display, text: text))
    }

    static var allTests = [
        ("testEmbedded", testEmbedded),
        ("testEmbeddedEntry", testEmbeddedEntry),
        ("testEmbeddedContentTypeEntry", testEmbeddedContentTypeEntry),
        ("testEmbeddedAsset", testEmbeddedAsset),
        ("testEmbeddedWithText", testEmbeddedWithText),
        ("testEmbeddedContentTypeEntryWithText", testEmbeddedContentTypeEntryWithText),
        ("testEmbeddedEntryWithText", testEmbeddedEntryWithText),
        ("testEmbeddedAssetWithText", testEmbeddedAssetWithText),
        ("testMarkTypeRender", testMarkTypeRender),

        ("testParagraphRender", testParagraphRender),
        ("testLinkRender", testLinkRender),
        ("testImageRender", testImageRender),
        ("testEmbedded", testEmbedded),
        ("testH1Render", testH1Render),
        ("testH2Render", testH2Render),
        ("testH3Render", testH3Render),
        ("testH4Render", testH4Render),
        ("testH5Render", testH5Render),
        ("testH6Render", testH6Render),
        ("testOrderListRender", testOrderListRender),
        ("testUnorderListRender", testUnorderListRender),
        ("testListItemRender", testListItemRender),
        ("testHRRender", testHRRender),
        ("testTableRender", testTableRender),
        ("testTableHeaderRender", testTableHeaderRender),
        ("testTableBodyRender", testTableBodyRender),
        ("testTableFooterRender", testTableFooterRender),
        ("testTableRowRender", testTableRowRender),
        ("testTableHeadRender", testTableHeadRender),
        ("testTableDataRender", testTableDataRender),
        ("testBlockquoteRender", testBlockquoteRender),
        ("testCodeRender", testCodeRender),
        ("testDocumentRender", testDocumentRender),
        ("testreferenceRender", testreferenceRender)
    ]
}

func getMetaData(itemType: EmbedItemType = .entry,
                 styleType: StyleType = .block,
                 text: String? = nil,
                 itemUid: String = "",
                 contentTypeUid: String = "",
                 attributes: [AnyHashable: Any] = [:],
                 outerHTML: String = "") -> Metadata {
    return Metadata(itemType: itemType,
                    styleType: styleType,
                    text: text,
                    itemUid: itemUid,
                    contentTypeUid: contentTypeUid,
                    attributes: attributes,
                    outerHTML: outerHTML)
}
