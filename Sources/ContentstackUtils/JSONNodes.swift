//
//  JSONNodes.swift
//  ContentstackUtils
//
//  Created by Uttam Ukkoji on 20/07/21.
//


public class JSONNodes: Decodable {
    let json: [Node]
    let embeddedItemsConnection: Edges?
   
    public required init(from decoder: Decoder) throws {
        let container   = try decoder.container(keyedBy: JSONNode.FieldKeys.self)
        json = try container.decode([Node].self, forKey: .json)
        embeddedItemsConnection = try container.decodeIfPresent(Edges.self, forKey: .embeddedItemsConnection)
    }
}
