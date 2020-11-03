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

    var embeddedEntries: [AnyHashable: [EmbeddedContentTypeUid]]?
    var embeddedAssets: [AnyHashable: [EmbeddedAsset]]?

    let richTextEditor: String
    let rte: String

    private enum CodingKeys: String, CodingKey {
        case uid, rte
        case richTextEditor = "rich_text_editor"
        case embeddedEntries = "_embedded_entries"
        case embeddedAssets = "_embedded_assets"
    }

    required public init(from decoder: Decoder) throws {
        let container   = try decoder.container(keyedBy: CodingKeys.self)
        self.uid = try container.decode(String.self, forKey: .uid)
        self.rte = try container.decode(String.self, forKey: .rte)
        self.richTextEditor = try container.decode(String.self, forKey: .richTextEditor)
        self.embeddedEntries = try? container.decodeIfPresent([String: [EmbeddedRTE]].self, forKey: .embeddedEntries)
        self.embeddedAssets = try container.decode([String: [Asset]].self, forKey: .embeddedAssets)
    }
}

class Asset: EmbeddedAsset, Decodable {
    var uid: String
    var title: String
    var url: String
    var filename: String

    private enum CodingKeys: String, CodingKey {
        case uid, title, filename, url
    }

    required public init(from decoder: Decoder) throws {
        let container   = try decoder.container(keyedBy: CodingKeys.self)
        self.uid = try container.decode(String.self, forKey: .uid)
        self.title = try container.decode(String.self, forKey: .title)
        self.url = try container.decode(String.self, forKey: .url)
        self.filename = try container.decode(String.self, forKey: .filename)
    }
}

class EmbeddedRTE: EmbeddedContentTypeUid, Decodable {
    static var contentTypeUid: String = "embeddedrte"
    var uid: String
    var title: String
    var richTextEditor: String
    private enum CodingKeys: String, CodingKey {
        case contentTypeUid = "_content_type_uid"
        case uid = "uid"
        case title
        case richTextEditor = "rich_text_editor"
    }

    required public init(from decoder: Decoder) throws {
        let container   = try decoder.container(keyedBy: CodingKeys.self)
        self.uid = try container.decode(String.self, forKey: .uid)
        self.title = try container.decode(String.self, forKey: .title)
        self.richTextEditor = try container.decode(String.self, forKey: .richTextEditor)
    }
}
