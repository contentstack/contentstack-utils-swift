import Foundation

public struct ContentstackUtils {

//    public struct JsonNode {
//        public var json: Node
//        public var embeddedObject: 
//    }
    public struct GQL {
        public static func jsonToHtml(rte document: [String: Any?], _ option: Option = Option()) throws -> Any {
            do {
                let data = try JSONSerialization.data(withJSONObject: document, options: JSONSerialization.WritingOptions.fragmentsAllowed)
                if (document["json"] as? [[String: Any?]]) != nil {
                    let rte = try JSONDecoder().decode(JSONNodes.self, from: data)
                    option.embdeddedItems = rte.embeddedItemsConnection?.edges
                    return ContentstackUtils.jsonToHtml(node: rte.json, option)
                }else {
                    let rte = try JSONDecoder().decode(JSONNode.self, from: data)
                    option.embdeddedItems = rte.embeddedItemsConnection?.edges
                    return ContentstackUtils.jsonToHtml(node: rte.json, option)
                }
            } catch (let error) {
                throw error
            }
        }
    }

    public static func render(content: String, _ option: Option) throws -> String {
        do {
            let appendContent = content.appendFrame()
            var resultContent = try HTML(html: appendContent, encoding: .utf8)
                .body!
                .at_xpath("//documentfragmentcontainer")!.innerHTML!
            try appendContent
                .findEmbeddedObject { (model) in
                    if let outerHTML = model.outerHTML {
                        var replaceString = ""
                        if let entry = option.entry,
                           let embeddedObject = findObject(model, entry: entry) {
                            if let string = option.renderItem(
                                embeddedObject: embeddedObject,
                                metadata: model) {
                                replaceString = string
                            }
                        }
                        resultContent = resultContent.replacingOccurrences(of: outerHTML, with: replaceString)
                    }
            }
            return resultContent
        } catch let error {
            throw error
        }
    }

    public static func render(contents: [String], _ options: Option) throws -> [String] {
        do {
            var resultContents: [String] = []
            try contents.forEach { (content) in
                let resultContent = try render(content: content, options)
                resultContents.append(resultContent)
            }
            return resultContents
        } catch let error {
            throw error
        }
    }
    
    public static func jsonToHtml(node documents: [Node], _ option: Option = Option()) -> [String] {
        var resultContents: [String] = []
        documents.forEach { (document) in
            resultContents.append(jsonToHtml(node: document, option))
        }
        return resultContents
    }

    public static func jsonToHtml(node document: Node, _ option: Option = Option()) -> String {
        return nodeChildrenToHtml(children: document.children, option)
    }

    static private func nodeChildrenToHtml(children nodes:[Node], _ option: Option) -> String {
        nodes.map{ (node) -> String in
            return nodeToHtml(node, option)
        }.joined()
    }
    
    static private func nodeToHtml(_ node: Node, _ option: Option) -> String {
        switch node.type {
        case NodeType.text.rawValue:
            return textNodeToHtml(node as! TextNode, option)
        case  NodeType.reference.rawValue:
            return referenceToHtml(node, option)
        default:
            return option.renderNode(nodeType: node.type, node: node) { (children) -> String in
                return nodeChildrenToHtml(children: children, option)
            }
        }
    }
    
    static private func textNodeToHtml(_ textNode: TextNode, _ option: Option) -> String {
        var text = textNode.text
        if (textNode.superscript) {
            text = option.renderMark(markType: .superscript, text: text)
        }
        if (textNode.subscript) {
            text = option.renderMark(markType: .subscript, text: text)
        }
        if (textNode.inlineCode) {
            text = option.renderMark(markType: .inlineCode, text: text)
        }
        if (textNode.strikethrough) {
            text = option.renderMark(markType: .strikethrough, text: text)
        }
        if (textNode.underline) {
            text = option.renderMark(markType: .underline, text: text)
        }
        if (textNode.italic) {
            text = option.renderMark(markType: .italic, text: text)
        }
        if (textNode.bold) {
            text = option.renderMark(markType: .bold, text: text)
        }
        return text
    }
    
    static private func referenceToHtml(_ node: Node, _ option: Option) -> String {
        let metadata = Metadata(nodeAttribute: node.attrs, text: node.children.count > 0 ? (node.children.first as? TextNode)?.text : "")
        if let entry = option.entry,
           let embeddedObject = findObject(metadata, entry: entry) {
            return option.renderItem(embeddedObject: embeddedObject, metadata: metadata) ?? ""
        } else if let embdeddedItems = option.embdeddedItems {
            let embedModel = embdeddedItems.filter { (item: EmbeddedObject) -> Bool in
                return item.uid == metadata.itemUid && item.contentTypeUID == metadata.contentTypeUid
            }
            if !embedModel.isEmpty {
                return option.renderItem(embeddedObject: embedModel.first!, metadata: metadata) ?? ""
            }
        }
        return ""
    }
    
    static private func findObject(_ model: Metadata, entry: EntryEmbedable) -> EmbeddedObject? {
        if let items = entry.embeddedItems, let uid = model.itemUid, let contentTypeUID = model.contentTypeUid {
            for (_, value) in items {
                let embedModel = value.filter { (item: EmbeddedObject) -> Bool in
                    return item.uid == uid && item.contentTypeUID == contentTypeUID
                }
                if !embedModel.isEmpty {
                    return embedModel.first
                }
            }
        }
        return nil
    }
}
