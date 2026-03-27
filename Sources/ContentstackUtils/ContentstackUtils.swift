import Foundation

public struct ContentstackUtils {

    public enum VariantUtilityError: Error {
    case invalidArgument(String)
    }

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
    
    public static func getVariantAliases(entry: [String: Any], contentTypeUid: String) throws -> [String: Any] {

        try validateContentTypeUid(contentTypeUid)

        guard let uid = entry["uid"] as? String, !uid.isEmpty else{
            throw VariantUtilityError.invalidArgument("entry uid is required.")
        }

        guard let publish = entry["publish_details"] as? [String: Any],
              let variants = publish["variants"] as? [String: Any] else{
            return [
                "entry_uid": uid,
                "contenttype_uid": contentTypeUid,
                "variants": [] as [String]
            ]
        }
        var aliases : [String] = []
        for(_, value) in variants {
            if let obj = value as? [String: Any],
               let alias = obj["alias"] as? String {
                aliases.append(alias)
            }
        }
        
        return [
            "entry_uid": uid,
            "contenttype_uid": contentTypeUid,
            "variants": aliases
        ]
    }

    public static func getVariantAliases(entries: [[String: Any]], contentTypeUid: String) throws -> [[String: Any]] {
        try validateContentTypeUid(contentTypeUid)
        return try entries.map { entry in
            try getVariantAliases(entry: entry, contentTypeUid: contentTypeUid)
        }
    }

    public static func getDataCsvariantsAttribute(entry: [String: Any]?, contentTypeUid: String) throws -> [String: Any]{
        guard let e = entry else {
            return ["data-csvariants": "[]"]
        }
        
        let payload = try getVariantAliases(entry: e, contentTypeUid: contentTypeUid)
        let s = try jsonString(for: [payload])
        return ["data-csvariants": s]

    }

    public static func getDataCsvariantsAttribute(entries: [[String: Any]], contentTypeUid: String) throws -> [String: Any]{
        try validateContentTypeUid(contentTypeUid)
        let payloads = try getVariantAliases(entries: entries, contentTypeUid: contentTypeUid)
        let s = try jsonString(for: payloads)
        return ["data-csvariants": s]
    }


    private static func validateContentTypeUid(_ contentTypeUid: String) throws {
        if contentTypeUid.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw VariantUtilityError.invalidArgument("contentTypeUid must not be empty")
        }
    }

    private static func jsonString(for array: [[String: Any]]) throws -> String{
        let data = try JSONSerialization.data(withJSONObject: array, options: [])
        guard let json = String(data: data, encoding: .utf8) else {
            throw VariantUtilityError.invalidArgument("Failed to encode JSON string")
        }
        return json
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
        if (textNode.break) {
            text = option.renderMark(markType: .break, text: text)
        }
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
        if let attType = node.attrs["type"] as? String, attType == "asset" {
            return option.renderNode(nodeType: NodeType.image.rawValue, node: node) { children in
                return nodeChildrenToHtml(children: children, option)
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

