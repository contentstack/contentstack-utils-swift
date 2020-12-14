//
//  ContentBlock.swift
//  ContentstackUtilsTests
//
//  Created by Uttam Ukkoji on 01/10/20.
//

import Foundation
import ContentstackUtils

class ContentBlock: EmbeddedObject, EmbeddedContentTypeUid, EntryEmbedable, Decodable {

    static var contentTypeUid: String = "content_block"

    var uid: String
    var contentTypeUID: String
    var embeddedItems: [AnyHashable: [EmbeddedObject]]?
    let richTextEditor: String
    let rte: String

    private enum CodingKeys: String, CodingKey {
        case uid, rte
        case contentTypeUID = "_content_type_uid"
        case richTextEditor = "rich_text_editor"
        case embeddedItems = "_embedded_items"
    }

    required public init(from decoder: Decoder) throws {
        let container   = try decoder.container(keyedBy: CodingKeys.self)
        self.uid = try container.decode(String.self, forKey: .uid)
        self.rte = try container.decode(String.self, forKey: .rte)
        self.richTextEditor = try container.decode(String.self, forKey: .richTextEditor)
        self.contentTypeUID = try container.decode(String.self, forKey: .contentTypeUID)

        let embedded   = try decoder.container(keyedBy: JSONCodingKeys.self)
        let fields = try embedded.decode(Dictionary<String, Any>.self)
        if let embItems = fields["_embedded_items"] as? [AnyHashable: [EmbeddedObject]] {
            self.embeddedItems = embItems
        }
    }
}

class Asset: EmbeddedAsset, Decodable {

    var uid: String
    var title: String
    var url: String
    var filename: String
    var contentTypeUID: String

    private enum CodingKeys: String, CodingKey {
        case uid, title, filename, url
        case contentTypeUID = "_content_type_uid"
    }

    required public init(from decoder: Decoder) throws {
        let container   = try decoder.container(keyedBy: CodingKeys.self)
        self.uid = try container.decode(String.self, forKey: .uid)
        self.title = try container.decode(String.self, forKey: .title)
        self.url = try container.decode(String.self, forKey: .url)
        self.filename = try container.decode(String.self, forKey: .filename)
        self.contentTypeUID = try container.decode(String.self, forKey: .contentTypeUID)
    }
}

class EmbeddedRTE: EmbeddedContentTypeUid, Decodable {
    static var contentTypeUid: String = "embeddedrte"
    var uid: String
    var title: String
    var richTextEditor: String
    var contentTypeUID: String
    private enum CodingKeys: String, CodingKey {
        case contentTypeUID = "_content_type_uid"
        case uid = "uid"
        case title
        case richTextEditor = "rich_text_editor"
    }

    required public init(from decoder: Decoder) throws {
        let container   = try decoder.container(keyedBy: CodingKeys.self)
        self.uid = try container.decode(String.self, forKey: .uid)
        self.title = try container.decode(String.self, forKey: .title)
        self.richTextEditor = try container.decode(String.self, forKey: .richTextEditor)
        self.contentTypeUID = try container.decode(String.self, forKey: .contentTypeUID)
    }
}
