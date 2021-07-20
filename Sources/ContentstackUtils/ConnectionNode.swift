//
//  ConnectionNode.swift
//  ContentstackUtils
//
//  Created by Uttam Ukkoji on 20/07/21.
//


internal class ConnectionNode: Decodable {
    var node: EmbeddedObject?
    public enum FieldKeys: String, CodingKey {
        case node
    }
    public required init(from decoder: Decoder) throws {
        let container   = try decoder.container(keyedBy: ConnectionNode.FieldKeys.self)
        let containerFields   = try decoder.container(keyedBy: JSONCodingKeys.self)
        let fields = try containerFields.decode(Dictionary<String, Any>.self)
        if let nodes = fields["node"] as? [String: Any],
           let system = nodes["system"] as? [String: Any],
           let contentType = system["content_type_uid"] as? String {
            if contentType == "sys_assets" {
                node = try container.decode(GQLEmbededAsset.self, forKey: .node)
            } else {
                node = try container.decode(GQLEmbededEntry.self, forKey: .node)
            }
        }
    }
    
    static func initWith(container nodes: inout UnkeyedDecodingContainer) throws -> [EmbeddedObject] {
        var nodesArray = nodes

        var object: [EmbeddedObject] = []
        while !nodes.isAtEnd {
            _ = try nodes.nestedContainer(keyedBy: ConnectionNode.FieldKeys.self)
            let connectionNode = try nodesArray.decode(ConnectionNode.self)
            if let item = connectionNode.node {
                object.append(item)
            }
        }
        return object
    }
}
