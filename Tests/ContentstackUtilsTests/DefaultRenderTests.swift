//
//  DefaultRenderTests.swift
//  ContentstackUtilsTests
//
//  Created by Uttam Ukkoji on 28/09/20.
//

import XCTest
@testable import ContentstackUtils

class DefaultRenderTests: XCTestCase {
    let defaultRender = DefaultRender(entry: EmbeddedModel(""))
    let embedded = Embedded()
    let embeddedEntry = EmbeddedEntryModel()
    let embeddedContentType = EmbeddedContentTypeUidModel()
    let embeddedAsset = EmbeddedAssetModel()
    let text: String = "Text To set Link"
    func testEmbedded() {
        let blockString = defaultRender.renderOptions(getMetaData(), embeddedObject: self.embedded)
        XCTAssertEqual(blockString, self.embedded.renderString(.block))

        let inlineString = defaultRender.renderOptions(getMetaData(styleType: .inline), embeddedObject: self.embedded)
        XCTAssertEqual(inlineString, self.embedded.renderString(.inline))

        let linkString = defaultRender.renderOptions(getMetaData(styleType: .link), embeddedObject: self.embedded)
        XCTAssertEqual(linkString, self.embedded.renderString(.link))

        let displayString = defaultRender.renderOptions(getMetaData(styleType: .display), embeddedObject: self.embedded)
        XCTAssertEqual(displayString, self.embedded.renderString(.display))
    }

    func testEmbeddedContentTypeEntry() {
        let blockString = defaultRender.renderOptions(getMetaData(), embeddedObject: self.embeddedContentType)
        XCTAssertEqual(blockString, self.embeddedContentType.renderString(.block))

        let inlineString = defaultRender.renderOptions(getMetaData(styleType: .inline),
                                                       embeddedObject: self.embeddedContentType)
        XCTAssertEqual(inlineString, self.embeddedContentType.renderString(.inline))

        let linkString = defaultRender.renderOptions(getMetaData(styleType: .link),
                                                     embeddedObject: self.embeddedContentType)
        XCTAssertEqual(linkString, self.embeddedContentType.renderString(.link))
    }

    func testEmbeddedEntry() {
        let blockString = defaultRender.renderOptions(getMetaData(), embeddedObject: self.embeddedEntry)
        XCTAssertEqual(blockString, self.embeddedEntry.renderString(.block))

        let inlineString = defaultRender.renderOptions(getMetaData(styleType: .inline),
                                                       embeddedObject: self.embeddedEntry)
        XCTAssertEqual(inlineString, self.embeddedEntry.renderString(.inline))

        let linkString = defaultRender.renderOptions(getMetaData(styleType: .link), embeddedObject: self.embeddedEntry)
        XCTAssertEqual(linkString, self.embeddedEntry.renderString(.link))
    }

    func testEmbeddedAsset() {
        let displayString = defaultRender.renderOptions(getMetaData(styleType: .display),
                                                        embeddedObject: self.embeddedAsset)
        XCTAssertEqual(displayString, self.embeddedAsset.renderString(.display))
    }

    func testEmbeddedWithText() {
        let blockString = defaultRender.renderOptions(getMetaData(text: text), embeddedObject: self.embedded)
        XCTAssertEqual(blockString, self.embedded.renderString(.block, text: text))

        let inlineString = defaultRender.renderOptions(getMetaData(styleType: .inline, text: text),
                                                       embeddedObject: self.embedded)
        XCTAssertEqual(inlineString, self.embedded.renderString(.inline, text: text))

        let linkString = defaultRender.renderOptions(getMetaData(styleType: .link, text: text),
                                                     embeddedObject: self.embedded)
        XCTAssertEqual(linkString, self.embedded.renderString(.link, text: text))

        let displayString = defaultRender.renderOptions(getMetaData(styleType: .display, text: text),
                                                        embeddedObject: self.embedded)
        XCTAssertEqual(displayString, self.embedded.renderString(.display, text: text))
       }

    func testEmbeddedContentTypeEntryWithText() {
        let blockString = defaultRender.renderOptions(getMetaData(styleType: .block, text: text),
                                                      embeddedObject: self.embeddedContentType)
        XCTAssertEqual(blockString, self.embeddedContentType.renderString(.block, text: text))

        let inlineString = defaultRender
            .renderOptions(getMetaData(styleType: .inline, text: text),
                           embeddedObject: self.embeddedContentType)
        XCTAssertEqual(inlineString, self.embeddedContentType.renderString(.inline, text: text))

        let linkString = defaultRender.renderOptions(getMetaData(styleType: .link, text: text),
                                                     embeddedObject: self.embeddedContentType)
        XCTAssertEqual(linkString, self.embeddedContentType.renderString(.link, text: text))
    }

    func testEmbeddedEntryWithText() {
        let blockString = defaultRender.renderOptions(getMetaData(styleType: .block, text: text),
                                                      embeddedObject: self.embeddedEntry)
        XCTAssertEqual(blockString, self.embeddedEntry.renderString(.block, text: text))

        let inlineString = defaultRender.renderOptions(getMetaData(styleType: .inline, text: text),
                                                       embeddedObject: self.embeddedEntry)
        XCTAssertEqual(inlineString, self.embeddedEntry.renderString(.inline, text: text))

        let linkString = defaultRender.renderOptions(getMetaData(styleType: .link, text: text),
                                                     embeddedObject: self.embeddedEntry)
        XCTAssertEqual(linkString, self.embeddedEntry.renderString(.link, text: text))
    }

    func testEmbeddedAssetWithText() {
        let displayString = defaultRender.renderOptions(getMetaData(styleType: .display, text: text),
                                                        embeddedObject: self.embeddedAsset)
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
        ("testEmbeddedAssetWithText", testEmbeddedAssetWithText)
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
