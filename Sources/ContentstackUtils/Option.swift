public protocol Renderable {
    func renderOptions(embeddedObject: EmbeddedObject, metadata: Metadata) -> String?
}

public protocol Option: Renderable {
    var entry: EntryEmbedable { get }
}

extension Option {
    func renderOptions(embeddedObject: EmbeddedObject, metadata: Metadata) -> String? {
        switch metadata.styleType {
        case StyleType.block:
            var renderString = "<div><p>\(embeddedObject.uid)</p>"
            if let embeddedEntry = embeddedObject as? EmbeddedEntry {
                renderString = """
<div><p>\(embeddedEntry.title)</p><p>Content type: <span>\(type(of: embeddedEntry).contentTypeUid)</span></p>
"""
            } else if let embeddedContentTypeUid = embeddedObject as? EmbeddedContentTypeUid {
                renderString += "<p>Content type: <span>\(type(of: embeddedContentTypeUid).contentTypeUid)</span></p>"
            }
            return renderString + "</div>"
        case StyleType.inline:
            if let embeddedEntry = embeddedObject as? EmbeddedEntry {
                return "<span>\(embeddedEntry.title)</span>"
            }
            return "<span>\(embeddedObject.uid)</span>"
        case StyleType.link:
            if let embeddedEntry = embeddedObject as? EmbeddedEntry {
                return "<a href=\"\(embeddedObject.uid)\">\(metadata.text ?? embeddedEntry.title)</a>"
            }
            return "<a href=\"\(embeddedObject.uid)\">\(metadata.text ?? embeddedObject.uid)</a>"
        case StyleType.display:
            if let asset = embeddedObject as? EmbeddedAsset {
                return "<img src=\"\(asset.url)\" alt=\"\(asset.title)\" />"
            }
            return "<img src=\"\(embeddedObject.uid)\" alt=\"\(embeddedObject.uid)\" />"
        }
    }
}
