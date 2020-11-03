//
//  StringExtensionTests.swift
//  ContentstackUtilsTests
//
//  Created by Uttam Ukkoji on 30/09/20.
//

import XCTest
@testable import ContentstackUtils

class StringExtensionTests: XCTestCase {
    func testnilString() {
        let nilString: String? = nil
        try? nilString?.findEmbeddedObject({ (_) in
            XCTAssert(false, "Should not call on nil string")
        })
    }

    func testBlankString() {
        do {
            try kBlankString.findEmbeddedObject({ (_) in
                XCTAssert(false, "Should not call on non xml string")
            })
            XCTFail("Blank string should not parse")
        } catch {
            XCTAssertTrue(true)
        }
    }

    func testNonHtmlString() {
        try? kNoHTML.findEmbeddedObject({ (_) in
            XCTAssert(false, "Should not call on non xml string")

        })
    }

    func testHtmlString() {
        try? kSimpleHTML.findEmbeddedObject({ (_) in
            XCTAssert(false, "Should not call on non xml string")
        })
    }

    func testUnexpectedClose() {
        try? kUnexpectedClose.findEmbeddedObject { (model) in
            XCTAssertEqual(model.itemType, EmbedItemType.asset)
            XCTAssertEqual(model.itemUid, "uid")
            XCTAssertEqual(model.contentTypeUid, "data-sys-content-type-uid")
            XCTAssertEqual(model.styleType, StyleType.inline)
            XCTAssertEqual(model.text, "\n")
        }
    }

    func testNoChildmodel() {
        try? kNoChildNode.findEmbeddedObject { (model) in
            XCTAssertEqual(model.itemType, EmbedItemType.asset)
            XCTAssertEqual(model.itemUid, "uid")
            XCTAssertEqual(model.contentTypeUid, "data-sys-content-type-uid")
            XCTAssertEqual(model.styleType, StyleType.inline)
            XCTAssertEqual(model.text, "\n")
        }
    }

    func testAssetDisplay() {
        try? kAssetDisplay.findEmbeddedObject { (model) in
            XCTAssertEqual(model.itemType, EmbedItemType.asset)
            XCTAssertEqual(model.itemUid, "blt55f6d8cbd7e03a1f")
            XCTAssertEqual(model.contentTypeUid, "")
            XCTAssertEqual(model.styleType, StyleType.display)
            XCTAssertEqual(model.text, "\n")
        }
    }

    func testEntryBlock() {
        try? kEntryBlock.findEmbeddedObject { (model) in
            XCTAssertEqual(model.itemType, EmbedItemType.entry)
            XCTAssertEqual(model.itemUid, "blt55f6d8cbd7e03a1f")
            XCTAssertEqual(model.contentTypeUid, "article")
            XCTAssertEqual(model.styleType, StyleType.block)
            XCTAssertEqual(model.text, "\n{{title}}\n")
        }
    }

    func testEntryInline() {
        try? kEntryInline.findEmbeddedObject { (model) in
            XCTAssertEqual(model.itemType, EmbedItemType.entry)
            XCTAssertEqual(model.itemUid, "blt55f6d8cbd7e03a1f")
            XCTAssertEqual(model.contentTypeUid, "article")
            XCTAssertEqual(model.styleType, StyleType.inline)
            XCTAssertEqual(model.text, "\n{{title}}\n")
        }
    }

    func testEntryLink() {
        try? kEntryLink.findEmbeddedObject { (model) in
            XCTAssertEqual(model.itemType, EmbedItemType.entry)
            XCTAssertEqual(model.itemUid, "blt55f6d8cbd7e03a1f")
            XCTAssertEqual(model.contentTypeUid, "article")
            XCTAssertEqual(model.styleType, StyleType.link)
            XCTAssertEqual(model.text, "\n{{title}}\n")
        }
    }

    func testAsset() {
        try? kAssetEmbed
            .appendFrame()
            .findEmbeddedObject({ (model) in
                print(model)
                if model.itemUid == "blt8d49bb742bcf2c83" {
                    XCTAssertEqual(model.itemType, EmbedItemType.asset)
                    XCTAssertEqual(model.itemUid, "blt8d49bb742bcf2c83")
                    XCTAssertEqual(model.contentTypeUid, "")
                    XCTAssertEqual(model.styleType, StyleType.display)
                    XCTAssertEqual(model.text, "")
                    XCTAssertEqual(model.attributes["data-sys-asset-uid"] as? String, "blt8d49bb742bcf2c83")
                    XCTAssertEqual(model.attributes["data-sys-asset-alt"] as? String,
                                   "Cuvier-67_Autruche_d_Afrique.jpg")
                    XCTAssertEqual(model.attributes["data-sys-asset-link"] as? String, "http://abc.com")
                    XCTAssertEqual(model.attributes["data-sys-asset-filelink"] as? String,
                                   "https://images.contentstack.com/v3/assets/blt77263d300aee3e6b/blt8d49bb742bcf2c83/5f744bfcb3d3d20813386c10/clitud.jpeg")
                    XCTAssertEqual(model.attributes["data-sys-asset-position"] as? String, "center")
                    XCTAssertEqual(model.attributes["data-sys-asset-caption"] as? String, "somecaption")
                    XCTAssertEqual(model.attributes["data-sys-asset-contenttype"] as? String, "image/jpeg")
                    XCTAssertEqual(model.attributes["data-sys-asset-isnewtab"] as? String, "true")
                    XCTAssertEqual(model.attributes["data-sys-asset-filename"] as? String,
                                   "Cuvier-67_Autruche_d_Afrique.jpg")
                }
            })
    }

    func testEntryBlockLink () {
        try? "\(kEntryBlock)\(kEntryLink)"
            .appendFrame()
            .findEmbeddedObject { (model) in
            if model.styleType == StyleType.link {
                XCTAssertEqual(model.itemType, EmbedItemType.entry)
                XCTAssertEqual(model.itemUid, "blt55f6d8cbd7e03a1f")
                XCTAssertEqual(model.contentTypeUid, "article")
                XCTAssertEqual(model.styleType, StyleType.link)
                XCTAssertEqual(model.text, "\n{{title}}\n")
            } else if model.styleType == StyleType.block {
                XCTAssertEqual(model.itemType, EmbedItemType.entry)
                XCTAssertEqual(model.itemUid, "blt55f6d8cbd7e03a1f")
                XCTAssertEqual(model.contentTypeUid, "article")
                XCTAssertEqual(model.styleType, StyleType.block)
                XCTAssertEqual(model.text, "\n{{title}}\n")
            } else {
                XCTFail("Should not get xml not required")
            }
        }
    }

    func testEntryBlockLinkInline () {
        try? "\(kEntryBlock)\(kEntryLink) \(kEntryInline)"
            .appendFrame()
            .findEmbeddedObject { (model) in
            if model.styleType == StyleType.link {
                XCTAssertEqual(model.itemType, EmbedItemType.entry)
                XCTAssertEqual(model.itemUid, "blt55f6d8cbd7e03a1f")
                XCTAssertEqual(model.contentTypeUid, "article")
                XCTAssertEqual(model.styleType, StyleType.link)
                XCTAssertEqual(model.text, "\n{{title}}\n")
            } else if model.styleType == StyleType.block {
                XCTAssertEqual(model.itemType, EmbedItemType.entry)
                XCTAssertEqual(model.itemUid, "blt55f6d8cbd7e03a1f")
                XCTAssertEqual(model.contentTypeUid, "article")
                XCTAssertEqual(model.styleType, StyleType.block)
                XCTAssertEqual(model.text, "\n{{title}}\n")
            } else if model.styleType == StyleType.inline {
                XCTAssertEqual(model.itemType, EmbedItemType.entry)
                XCTAssertEqual(model.itemUid, "blt55f6d8cbd7e03a1f")
                XCTAssertEqual(model.contentTypeUid, "article")
                XCTAssertEqual(model.styleType, StyleType.inline)
                XCTAssertEqual(model.text, "\n{{title}}\n")
            } else {
                XCTFail("Should not get xml not required")
            }
        }
    }

    func testAllEmbedStyles () {
        try? """
            \(kAssetDisplay)
            \(kEntryBlock)
            \(kEntryLink)
            \(kEntryInline)
            """
            .appendFrame()
            .findEmbeddedObject { (model) in
            if model.styleType == StyleType.display {
                XCTAssertEqual(model.itemType, EmbedItemType.asset)
                XCTAssertEqual(model.itemUid, "blt55f6d8cbd7e03a1f")
                XCTAssertEqual(model.contentTypeUid, "")
                XCTAssertEqual(model.styleType, StyleType.display)
                XCTAssertEqual(model.text, "\n")
            } else if model.styleType == StyleType.link {
                XCTAssertEqual(model.itemType, EmbedItemType.entry)
                XCTAssertEqual(model.itemUid, "blt55f6d8cbd7e03a1f")
                XCTAssertEqual(model.contentTypeUid, "article")
                XCTAssertEqual(model.styleType, StyleType.link)
                XCTAssertEqual(model.text, "\n{{title}}\n")
            } else if model.styleType == StyleType.block {
                XCTAssertEqual(model.itemType, EmbedItemType.entry)
                XCTAssertEqual(model.itemUid, "blt55f6d8cbd7e03a1f")
                XCTAssertEqual(model.contentTypeUid, "article")
                XCTAssertEqual(model.styleType, StyleType.block)
                XCTAssertEqual(model.text, "\n{{title}}\n")
            } else if model.styleType == StyleType.inline {
                XCTAssertEqual(model.itemType, EmbedItemType.entry)
                XCTAssertEqual(model.itemUid, "blt55f6d8cbd7e03a1f")
                XCTAssertEqual(model.contentTypeUid, "article")
                XCTAssertEqual(model.styleType, StyleType.inline)
                XCTAssertEqual(model.text, "\n{{title}}\n")
            } else {
                XCTFail("Should not get xml not required")
            }
        }
    }

    func testContentBlockRichTextEditor () {
        if let contentblock = TestDecodable.getMultilevelEmbed() {
            try? contentblock.richTextEditor
                .appendFrame()
                .findEmbeddedObject { (model) in
                if model.styleType == StyleType.display {
                    XCTAssertEqual(model.itemType, EmbedItemType.asset)
                    XCTAssertEqual(model.itemUid, "bltassetEmbuid")
                    XCTAssertEqual(model.contentTypeUid, "")
                    XCTAssertEqual(model.styleType, StyleType.display)
                    XCTAssertEqual(model.text, "")
                } else if model.styleType == StyleType.block {
                    XCTAssertEqual(model.itemType, EmbedItemType.entry)
                    XCTAssertEqual(model.itemUid, "blttitleUpdateUID")
                    XCTAssertEqual(model.contentTypeUid, "embeddedrte")
                    XCTAssertEqual(model.styleType, StyleType.block)
                    XCTAssertEqual(model.text, "")
                } else {
                    XCTFail("Should not get xml not required")
                }
            }
        }
    }

    func testContentBlockRte () {
        if let contentblock = TestDecodable.getMultilevelEmbed() {
            try? contentblock.rte
                .appendFrame()
                .findEmbeddedObject { (model) in
                if model.styleType == StyleType.inline {
                    XCTAssertEqual(model.itemType, EmbedItemType.entry)
                    XCTAssertEqual(model.itemUid, "bltemmbedEntryUID")
                    XCTAssertEqual(model.contentTypeUid, "embeddedrte")
                    XCTAssertEqual(model.styleType, StyleType.inline)
                    XCTAssertEqual(model.text, "")
                } else if model.styleType == StyleType.block {
                    XCTAssertEqual(model.itemType, EmbedItemType.entry)
                    XCTAssertEqual(model.itemUid, "blttitleuid")
                    XCTAssertEqual(model.contentTypeUid, "content_block")
                    XCTAssertEqual(model.styleType, StyleType.block)
                    XCTAssertEqual(model.text, "")
                } else {
                    XCTFail("Should not get xml not required")
                }
            }
        }
    }

    static var allTests = [
        ("testnilString", testnilString),
        ("testBlankString", testBlankString),
        ("testNonHtmlString", testNonHtmlString),
        ("testHtmlString", testHtmlString),
        ("testUnexpectedClose", testUnexpectedClose),
        ("testNoChildmodel", testNoChildmodel),
        ("testAssetDisplay", testAssetDisplay),
        ("testEntryBlock", testEntryBlock),
        ("testEntryInline", testEntryInline),
        ("testEntryLink", testEntryLink),
        ("testEntryBlockLink", testEntryBlockLink),
        ("testEntryBlockLinkInline", testEntryBlockLinkInline),
        ("testAllEmbedStyles", testAllEmbedStyles),
        ("testContentBlockRichTextEditor", testContentBlockRichTextEditor),
        ("testContentBlockRte", testContentBlockRte)
    ]
}
