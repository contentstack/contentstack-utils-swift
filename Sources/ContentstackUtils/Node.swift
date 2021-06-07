//
//  Node.swift
//  ContentstackUtils
//
//  Created by Uttam Ukkoji on 03/06/21.
//

public class Node: Decodable {
    public var type: NodeType = .unknown
    public var attrs: [String: Any]
    public var children: [Node] = []
    public enum FieldKeys: String, CodingKey {
        case type, attrs, children
    }
    public required init(from decoder: Decoder) throws {
        let container   = try decoder.container(keyedBy: FieldKeys.self)
        if let strinty = try container.decodeIfPresent(String.self, forKey: .type) {
            type = NodeType(rawValue: strinty) ?? NodeType.unknown
        }
        attrs = try container.decodeIfPresent(Dictionary<String, Any>.self, forKey: .attrs) ?? [:]
        if var nodes = try? container.nestedUnkeyedContainer(forKey: .children) {
            children = try Node.initWith(container: &nodes)
        }
    }
    
    static func initWith(container nodes: inout UnkeyedDecodingContainer) throws -> [Node] {
        var nodesArray = nodes

        var objects: [Node] = []
        while !nodes.isAtEnd {
             let acontainer = try nodes.nestedContainer(keyedBy: Node.FieldKeys.self)
             let type = try acontainer.decodeIfPresent(String.self, forKey: Node.FieldKeys.type) ?? "text"
             switch type {
             case NodeType.text.rawValue:
                 objects.append(try nodesArray.decode(TextNode.self))
             default:
                 objects.append(try nodesArray.decode(Node.self))
             }
        }
        return objects
    }
}
