//
//  CustomRenderOptionMock.swift
//  ContentstackUtilsTests
//
//  Created by Uttam Ukkoji on 02/11/20.
//

import Foundation
import ContentstackUtils
class CustomRenderOption: Option {
    var entry: EntryEmbedable?

    init(entry: EntryEmbedable) {
        self.entry = entry
    }

    func renderOptions(embeddedObject: EmbeddedObject, metadata: Metadata) -> String? {
        let attributeString = metadata.attributes.map { (key: AnyHashable, value: Any) -> String in
            if let stringKey = key as? String ,
                let stringValue = value as? String {
                return "\(stringKey)=\"\(stringValue)\""
            }
            return ""
            }.sorted().joined(separator: " ")

        var result = ""
        switch metadata.styleType {
        case .block:
            if let blockEntry = embeddedObject as? EmbeddedRTE {
                result = """
<div \(attributeString)> <b>\(blockEntry.title)</b>
\(blockEntry.richTextEditor)
</div>
"""
            } else if let blockEntry = embeddedObject as? EmbeddedContentTypeUidModel {
                result = "<div \(attributeString)> <b>\(blockEntry.uid)</b></div>"
            }

        case .inline:
            if let inlineEntry = embeddedObject as? EmbeddedRTE {
                result = "<span \(attributeString)><b>\(inlineEntry.title)</b> \(metadata.text ?? "")</span>"
            } else if let inlineEntry = embeddedObject as? EmbeddedAssetModel {
                result = "<span \(attributeString)><b>\(inlineEntry.title)</b> \(metadata.text ?? "")</span>"
            } else if let inlineEntry = embeddedObject as? EmbeddedContentTypeUidModel {
                result = "<span \(attributeString)><b>\(inlineEntry.uid)</b></span>"
            }

        case .link:
            if let linkEntry = embeddedObject as? EmbeddedRTE {
                result = """
<span> Please find link to: <a \(attributeString)><b>\(metadata.text ?? linkEntry.title)</b></a>
"""
            } else if let linkEntry = embeddedObject as? EmbeddedContentTypeUidModel {
                result = """
<span> Please find link to: <a \(attributeString)><b>\(metadata.text ?? linkEntry.uid)</b></a>
"""
            }
        case .display:
            if let asset = embeddedObject as? Asset {
                result = "<b>\(asset.title)</b><p>\(asset.filename) image: <img \(attributeString) /></p>"
            } else if let asset = embeddedObject as? EmbeddedAssetModel {
                result = "<b>\(asset.title)</b><p>\(asset.filename) image: <img \(attributeString) /></p>"
            }
        }
        return result
    }
}
