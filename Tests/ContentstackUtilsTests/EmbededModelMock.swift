//
//  EmbededModelMock.swift
//  ContentstackUtilsTests
//
//  Created by Uttam Ukkoji on 28/09/20.
//

import Foundation
import ContentstackUtils

class EmbeddedModel: EntryEmbedable {
    var rte: String

    init(_ rte: String,
         embedContentUID: String = "entryuid",
         embedContentTypeUID: String = "data-sys-content-type-uid", embedAssetUID: String = "assetuid") {
        self.rte = rte
        self.embeddedItems = [
            "rte": [
                EmbeddedContentTypeUidModel(uid: embedContentUID, contentTypeUID: embedContentTypeUID),
                EmbeddedAssetModel(uid: embedAssetUID)
            ]
        ]
    }

    var embeddedItems: [AnyHashable: [EmbeddedObject]]?
}

class Embedded: EmbeddedObject {
    var fields: [String : Any]? = [:]
    
    var contentTypeUID: String = "data-sys-content-type-uid"
    var uid: String
    init(uid: String = "uid") {
        self.uid = uid
    }
    func renderString(_ embedType: StyleType, text: String? = nil) -> String {
        switch embedType {
        case .block:
            return "<div><p>\(self.uid)</p></div>"
        case .inline:
            return "<span>\(self.uid)</span>"
        case .link:
            return "<a href=\"\(self.uid)\">\(text ?? self.uid)</a>"
        case .display:
            return "<img src=\"\(self.uid)\" alt=\"\(self.uid)\" />"
        }
    }

    func renderCustomString(_ embedType: StyleType, text: String? = nil) -> String {
        switch embedType {
        case .block:
            return "<div><p>\(self.uid)</p></div>"
        case .inline:
            return "<span>\(self.uid)</span>"
        case .link:
            return "<a href=\"\(self.uid)\">\(text ?? self.uid)</a>"
        case .display:
            return "<img src=\"\(self.uid)\" alt=\"\(self.uid)\" />"
        }
    }
}

class EmbeddedContentTypeUidModel: EmbeddedContentTypeUid {
    var fields: [String : Any]? = [:]
    var contentTypeUID: String = "data-sys-content-type-uid"
    static var contentTypeUid: String = "contentTypeUid"
    var uid: String
    init(uid: String = "uid", contentTypeUID: String) {
        self.uid = uid
        self.contentTypeUID = contentTypeUID
    }

    func renderString(_ embedType: StyleType, text: String? = nil) -> String {
        switch embedType {
        case .block:
            return """
<div><p>\(self.uid)</p><p>Content type: <span>\(EmbeddedContentTypeUidModel.contentTypeUid)</span></p></div>
"""
        case .inline:
            return "<span>\(self.uid)</span>"
        case .link:
            return "<a href=\"\(self.uid)\">\(text ?? self.uid)</a>"
        default:
            return ""
        }
    }

    func renderCustomString(_ embedType: StyleType, text: String? = nil) -> String {
        switch embedType {
        case .block:
            return "<div><p>\(self.uid)</p></div>"
        case .inline:
            return "<span>\(self.uid)</span>"
        case .link:
            return "<a href=\"\(self.uid)\">\(text ?? self.uid)</a>"
        case .display:
            return "<img src=\"\(self.uid)\" alt=\"\(self.uid)\" />"
        }
    }
}

class EmbeddedEntryModel: EmbeddedEntry {
    var fields: [String : Any]? = [:]
    var contentTypeUID: String = "data-sys-content-type-uid"
    static var contentTypeUid: String = "contentTypeUid"
    var title: String = "title"
    var uid: String
    init(uid: String = "uid") {
        self.uid = uid
    }

    func renderString(_ embedType: StyleType, text: String? = nil) -> String {
        switch embedType {
        case .block:
            return "<div><p>\(self.title)</p><p>Content type: <span>\(type(of: self).contentTypeUid)</span></p></div>"
        case .inline:
            return "<span>\(self.title)</span>"
        case .link:
            return "<a href=\"\(self.uid)\">\(text ?? self.title)</a>"
        default:
            return ""
        }
    }

    func renderCustomString(_ embedType: StyleType, text: String? = nil) -> String {
        switch embedType {
        case .block:
            return "<div><p>\(self.uid)</p></div>"
        case .inline:
            return "<span>\(self.uid)</span>"
        case .link:
            return "<a href=\"\(self.uid)\">\(text ?? self.uid)</a>"
        case .display:
            return "<img src=\"\(self.uid)\" alt=\"\(self.uid)\" />"
        }
    }

}

class EmbeddedAssetModel: EmbeddedAsset {
    var fields: [String : Any]? = [:]
    var contentTypeUID: String = "sys_assets"
    var title: String = "title"
    var filename: String = "filename"
    var url: String = "url"
    var uid: String
    init(uid: String = "uid") {
        self.uid = uid
    }

    func renderString(_ type: StyleType, text: String? = nil) -> String {
        switch type {
        case .display:
            return "<img src=\"\(self.url)\" alt=\"\(self.title)\" />"
        default:
            return ""
        }
    }

    func renderCustomString(_ embedType: StyleType, text: String? = nil) -> String {
        switch embedType {
        case .block:
            return "<div><p>\(self.uid)</p></div>"
        case .inline:
            return "<span>\(self.uid)</span>"
        case .link:
            return "<a href=\"\(self.uid)\">\(text ?? self.uid)</a>"
        case .display:
            return "<img src=\"\(self.uid)\" alt=\"\(self.uid)\" />"
        }
    }
}
