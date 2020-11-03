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

    init(_ rte: String, embedContentUID: String = "uid", embedAssetUID: String = "uid") {
        self.rte = rte
        self.embeddedEntries = ["rte": [EmbeddedContentTypeUidModel(uid: embedContentUID)]]
        self.embeddedAssets = ["rte": [EmbeddedAssetModel(uid: embedAssetUID)]]
    }

    var embeddedEntries: [AnyHashable: [EmbeddedContentTypeUid]]?
    var embeddedAssets: [AnyHashable: [EmbeddedAsset]]?
}

class Embedded: EmbeddedObject {
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
    static var contentTypeUid: String = "contentTypeUid"
    var uid: String
    init(uid: String = "uid") {
        self.uid = uid
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

class EmbeddedEntryModel: EmbeddedContentTypeUid, EmbeddedEntry {
    static var contentTypeUid: String = "contentTypeUid"
    var title: String = "title"
    var uid: String
    init(uid: String = "uid") {
        self.uid = uid
    }

    func renderString(_ embedType: StyleType, text: String? = nil) -> String {
        switch embedType {
        case .block:
            return "<div><p>\(self.uid)</p><p>Content type: <span>\(self.title)</span></p></div>"
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
