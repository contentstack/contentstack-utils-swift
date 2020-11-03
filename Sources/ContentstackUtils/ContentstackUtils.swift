struct ContentstackUtils {

    static func render(content: String, _ option: Option) throws -> String {
        do {
            let appendContent = content.appendFrame()
            var resultContent = try HTML(html: appendContent, encoding: .utf8)
                .body!
                .at_xpath("//documentfragmentcontainer")!.innerHTML!
            try appendContent
                .findEmbeddedObject { (model) in
                    if let outerHTML = model.outerHTML {
                        var replaceString = ""
                        if let embeddedObject = findObject(model, entry: option.entry) {
                            if let string = option.renderOptions(model, embeddedObject: embeddedObject) {
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

    static func render(contents: [String], _ options: Option) throws -> [String] {
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

    static private func findObject(_ model: Metadata, entry: EntryEmbedable) -> EmbeddedObject? {
        switch model.itemType {
        case .asset:
            if let assets = entry.embeddedAssets, let uid = model.itemUid {
                for (_, value) in assets {
                    let embedModel = value.filter { (asset: EmbeddedAsset) -> Bool in
                        return asset.uid == uid
                    }
                    if !embedModel.isEmpty {
                        return embedModel.first
                    }
                }
            }
        case .entry:
            if let entries = entry.embeddedEntries,
                let uid = model.itemUid {
                for (_, value) in entries {
                    let embedModel = value.filter { (entry: EmbeddedContentTypeUid) -> Bool in
                        return entry.uid == uid
                    }
                    if !embedModel.isEmpty {
                        return embedModel.first
                    }
                }
            }
        }
        return nil
    }
}
