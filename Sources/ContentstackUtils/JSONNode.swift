//
//  JSONNode.swift
//  ContentstackUtils
//
//  Created by Uttam Ukkoji on 20/07/21.
//

public class JSONNode: Decodable {
    let json: Node
    let embeddedItemsConnection: Edges?
    public enum FieldKeys: String, CodingKey {
        case json
        case embeddedItemsConnection = "embedded_itemsConnection"
    }
    public required init(from decoder: Decoder) throws {
        let container   = try decoder.container(keyedBy: FieldKeys.self)
        json = try container.decode(Node.self, forKey: .json)
        embeddedItemsConnection = try container.decodeIfPresent(Edges.self, forKey: .embeddedItemsConnection)
    }
}
