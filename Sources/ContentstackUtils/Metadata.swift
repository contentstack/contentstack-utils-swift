//
//  Metadata.swift
//  ContentstackUtils
//
//  Created by Uttam Ukkoji on 02/11/20.
//

import Foundation

public struct Metadata {

    internal init(itemType: EmbedItemType,
                  styleType: StyleType,
                  text: String?,
                  itemUid: String,
                  contentTypeUid: String,
                  attributes: [AnyHashable: Any],
                  outerHTML: String) {
        self.text = text
        self.itemUid = itemUid
        self.itemType = itemType
        self.outerHTML = outerHTML
        self.styleType = styleType
        self.attributes = attributes
        self.contentTypeUid = contentTypeUid

    }

    internal init(node: XMLElement) {
        if let type = node["type"] {
            self.itemType = EmbedItemType(rawValue: type) ?? .entry
        }
        if let styleType = node["sys-style-type"] {
            self.styleType = StyleType(rawValue: styleType) ?? .block
        }
        self.itemUid = node["data-sys-entry-uid"] ?? node["data-sys-asset-uid"] ?? ""
        self.contentTypeUid = node["data-sys-content-type-uid"] ?? ""
        self.outerHTML = node.toHTML
        self.text = node.text
        self.attributes = node.attributes()
    }

    internal init(nodeAttribute: [AnyHashable: Any], text: String?) {
        self.text = text

        if let uid = nodeAttribute["entry-uid"] as? String ?? nodeAttribute["asset-uid"] as? String {
            itemUid = uid
        } else {
            itemUid = ""
        }
        if let type = nodeAttribute["type"] as? String {
            self.itemType = EmbedItemType(rawValue: type) ?? .entry
        }
        if let styleType = nodeAttribute["display-type"] as? String {
            self.styleType = StyleType(rawValue: styleType) ?? .block
        }
        attributes = nodeAttribute
        contentTypeUid =  nodeAttribute["content-type-uid"] as? String ?? ""
        self.outerHTML = ""
    }
    
    public var itemType: EmbedItemType = .entry
    public var styleType: StyleType = .block
    public let itemUid: String?
    public let contentTypeUid: String?
    public let text: String?
    public let attributes: [AnyHashable: Any]

    internal let outerHTML: String?

}
