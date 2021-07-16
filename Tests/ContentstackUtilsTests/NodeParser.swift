//
//  NodeParser.swift
//  ContentstackUtils
//
//  Created by Uttam Ukkoji on 07/06/21.
//

import Foundation
import ContentstackUtils

class NodeParser {
    static func parse(from json: String) -> Node {
        let data = json.data(using: .utf8)
        return try! JSONDecoder().decode(Node.self, from: data!)
    }
}
