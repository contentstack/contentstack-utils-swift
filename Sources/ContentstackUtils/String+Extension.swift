//
//  String+Extension.swift
//  ContentstackUtils
//
//  Created by Uttam Ukkoji on 29/09/20.
//

import Foundation

internal extension String {
    func appendFrame() -> String {
        return "<documentfragmentcontainer>\(self)</documentfragmentcontainer>"
    }

    func findEmbeddedObject(_ object: ((Metadata) -> Void)) throws {
        do {
            let document = try HTML(html: self, encoding: .utf8)
            let nodesObject = document.xpath(
                "//*[contains(@class, 'embedded-asset') or contains(@class, 'embedded-entry')]"
            )
            nodesObject.forEach { (node) in
                    let model = Metadata(node: node)
                    object(model)
            }
        } catch let error {
            throw error
        }
    }
}
