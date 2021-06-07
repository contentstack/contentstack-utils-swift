public protocol Renderable {
    func renderOptions(embeddedObject: EmbeddedObject, metadata: Metadata) -> String?
    func renderMark(markType: MarkType, text: String) -> String
    func renderNode(nodeType: NodeType, node: Node, next: (([Node]) -> String)) -> String
}

public protocol Option: Renderable {
    var entry: EntryEmbedable? { get }
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
    
    public func renderMark(markType: MarkType, text: String) -> String {
        switch markType {
        case .bold:
            return "<strong>\(text)</strong>"
        case .italic:
            return "<em>\(text)</em>"
        case .underline:
            return "<u>\(text)</u>"
        case .strickthrough:
            return "<strike>\(text)</strike>"
        case .inlineCode:
            return "<span>\(text)</span>"
        case .subscript:
            return "<sub>\(text)</sub>"
        case .superscript:
            return "<sup>\(text)</sup>"
        }
    }
    
    public func renderNode(nodeType: NodeType, node: Node, next: (([Node]) -> String)) -> String {
        switch nodeType {
        case .paragraph:
            return "<p>\(next(node.children))</p>"
        case .link:
            return "<a href=\"\(node.attrs["url"] ?? "")\">\(next(node.children))</a>"
        case .image:
            return "<img src=\"\(node.attrs["url"] ?? "")\" />\(next(node.children))"
        case .embed:
            return "<iframe src=\"\(node.attrs["url"] ?? "")\">\(next(node.children))</iframe>"
        case .heading_1:
            return "<h1>\(next(node.children))</h1>"
        case .heading_2:
            return "<h2>\(next(node.children))</h2>"
        case .heading_3:
            return "<h3>\(next(node.children))</h3>"
        case .heading_4:
            return "<h4>\(next(node.children))</h4>"
        case .heading_5:
            return "<h5>\(next(node.children))</h5>"
        case .heading_6:
            return "<h6>\(next(node.children))</h6>"
        case .orderList:
            return "<ol>\(next(node.children))</ol>"
        case .unOrderList:
            return "<ul>\(next(node.children))</ul>"
        case .listItem:
            return "<li>\(next(node.children))</li>"
        case .hr:
            return "<hr>"
        case .table:
            return "<table>\(next(node.children))</table>"
        case .tableHeader:
            return "<thead>\(next(node.children))</thead>"
        case .tableBody:
            return "<tbody>\(next(node.children))</tbody>"
        case .tableFooter:
            return "<tfoot>\(next(node.children))</tfoot>"
        case .tableRow:
            return "<tr>\(next(node.children))</tr>"
        case .tableHead:
            return "<th>\(next(node.children))</th>"
        case .tableData:
            return "<td>\(next(node.children))</td>"
        case .blockQuote:
            return "<blockquote>\(next(node.children))</blockquote>"
        case .code:
            return "<code>\(next(node.children))</code>"
        default:
            return next(node.children)
        }
    }
}
