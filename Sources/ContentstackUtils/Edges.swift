//
//  Edges.swift
//  ContentstackUtils
//
//  Created by Uttam Ukkoji on 20/07/21.
//


internal class Edges: Decodable {
    var edges: [EmbeddedObject]?
    public enum FieldKeys: String, CodingKey {
        case edges
    }
    public required init(from decoder: Decoder) throws {
        let container   = try decoder.container(keyedBy: FieldKeys.self)
        if var nodes = try? container.nestedUnkeyedContainer(forKey: .edges) {
            edges = try ConnectionNode.initWith(container: &nodes)
        }
    }
}
