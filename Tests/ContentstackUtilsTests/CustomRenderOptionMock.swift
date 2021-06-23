//
//  CustomRenderOptionMock.swift
//  ContentstackUtilsTests
//
//  Created by Uttam Ukkoji on 02/11/20.
//

import Foundation
import ContentstackUtils
class CustomRenderOption: Option {

    override func renderMark(markType: MarkType, text: String) -> String {
        switch markType {
        case .bold:
            return "<b>\(text)</b>"
        default:
            return super.renderMark(markType: markType, text: text)
        }
    }
    
    override func renderNode(nodeType: String, node: Node, next: (([Node]) -> String)) -> String {
        switch nodeType {
        case NodeType.paragraph.rawValue:
            return "<p class='class-id'>\(next(node.children))</p>"
        case NodeType.heading_1.rawValue:
            return "<h1 class='class-id'>\(next(node.children))</h1>"
        default:
            return super.renderNode(nodeType: nodeType, node: node, next: next)
        }
    }
    
    override func renderItem(embeddedObject: EmbeddedObject, metadata: Metadata) -> String? {
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
            return result

        case .inline:
            if let inlineEntry = embeddedObject as? EmbeddedRTE {
                result = "<span \(attributeString)><b>\(inlineEntry.title)</b> \(metadata.text ?? "")</span>"
            } else if let inlineEntry = embeddedObject as? EmbeddedAssetModel {
                result = "<span \(attributeString)><b>\(inlineEntry.title)</b> \(metadata.text ?? "")</span>"
            } else if let inlineEntry = embeddedObject as? EmbeddedContentTypeUidModel {
                result = "<span \(attributeString)><b>\(inlineEntry.uid)</b></span>"
            }
            return result

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
            return result
        case .display:
            if let asset = embeddedObject as? Asset {
                result = "<b>\(asset.title)</b><p>\(asset.filename) image: <img \(attributeString) /></p>"
            } else if let asset = embeddedObject as? EmbeddedAssetModel {
                result = "<b>\(asset.title)</b><p>\(asset.filename) image: <img \(attributeString) /></p>"
            }
            return result
        }
    }
}
