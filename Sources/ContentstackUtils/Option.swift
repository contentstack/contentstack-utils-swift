public protocol Renderable {
    func renderItem(embeddedObject: EmbeddedObject, metadata: Metadata) -> String?
    func renderMark(markType: MarkType, text: String) -> String
    func renderNode(nodeType: String, node: Node, next: (([Node]) -> String)) -> String
}

open class Option: Renderable {
    var entry: EntryEmbedable?
    internal var embdeddedItems: [EmbeddedObject]?
    public init() {}
    
    public init(entry: EntryEmbedable?) {
        self.entry = entry
    }

    open func renderItem(embeddedObject: EmbeddedObject, metadata: Metadata) -> String? {
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
    
    open func renderMark(markType: MarkType, text: String) -> String {
        switch markType {
        case .bold:
            return "<strong>\(text)</strong>"
        case .italic:
            return "<em>\(text)</em>"
        case .underline:
            return "<u>\(text)</u>"
        case .strikethrough:
            return "<strike>\(text)</strike>"
        case .inlineCode:
            return "<span>\(text)</span>"
        case .subscript:
            return "<sub>\(text)</sub>"
        case .superscript:
            return "<sup>\(text)</sup>"
        case .break:
            return "<br />\(text)"
        }
    }
    
    open func renderNode(nodeType: String, node: Node, next: (([Node]) -> String)) -> String {
        switch nodeType {
        case NodeType.paragraph.rawValue:
            return "<p>\(next(node.children))</p>"
        case NodeType.link.rawValue:
            return "<a href=\"\(node.attrs["href"] ?? node.attrs["url"] ?? "")\">\(next(node.children))</a>"
        case NodeType.image.rawValue:
            return "<img src=\"\(node.attrs["src"] ?? node.attrs["asset-link"] ?? "")\" />\(next(node.children))"
        case NodeType.embed.rawValue:
            return "<iframe src=\"\(node.attrs["src"] ?? "")\">\(next(node.children))</iframe>"
        case NodeType.heading_1.rawValue:
            return "<h1>\(next(node.children))</h1>"
        case NodeType.heading_2.rawValue:
            return "<h2>\(next(node.children))</h2>"
        case NodeType.heading_3.rawValue:
            return "<h3>\(next(node.children))</h3>"
        case NodeType.heading_4.rawValue:
            return "<h4>\(next(node.children))</h4>"
        case NodeType.heading_5.rawValue:
            return "<h5>\(next(node.children))</h5>"
        case NodeType.heading_6.rawValue:
            return "<h6>\(next(node.children))</h6>"
        case NodeType.orderList.rawValue:
            return "<ol>\(next(node.children))</ol>"
        case NodeType.unOrderList.rawValue:
            return "<ul>\(next(node.children))</ul>"
        case NodeType.listItem.rawValue:
            return "<li>\(next(node.children))</li>"
        case NodeType.hr.rawValue:
            return "<hr>"
        case NodeType.table.rawValue:
            return "<table>\(next(node.children))</table>"
        case NodeType.tableHeader.rawValue:
            return "<thead>\(next(node.children))</thead>"
        case NodeType.tableBody.rawValue:
            return "<tbody>\(next(node.children))</tbody>"
        case NodeType.tableFooter.rawValue:
            return "<tfoot>\(next(node.children))</tfoot>"
        case NodeType.tableRow.rawValue:
            return "<tr>\(next(node.children))</tr>"
        case NodeType.tableHead.rawValue:
            return "<th>\(next(node.children))</th>"
        case NodeType.tableData.rawValue:
            return "<td>\(next(node.children))</td>"
        case NodeType.blockQuote.rawValue:
            return "<blockquote>\(next(node.children))</blockquote>"
        case NodeType.code.rawValue:
            return "<code>\(next(node.children))</code>"
        default:
            return next(node.children)
        }
    }
}
