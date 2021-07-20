//
//  GQLEmbededAsset.swift
//  ContentstackUtils
//
//  Created by Uttam Ukkoji on 20/07/21.
//

internal class GQLEmbededAsset: Decodable, EmbeddedAsset {
    static var contentTypeUid: String = "sys_asset"

    var uid: String
    
    var url: String
    
    var title: String

    var filename: String

    var contentTypeUID: String
    
    public var fields: [String: Any]?
    public enum FieldKeys: String, CodingKey {
        case title, uid, url, filename
        case contentTypeUID = "content_type_uid"
    }

    public required init(from decoder: Decoder) throws {
        let container   = try decoder.container(keyedBy: FieldKeys.self)
        uid = ""
        url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        filename = try container.decodeIfPresent(String.self, forKey: .filename) ?? ""
        contentTypeUID = ""

        let containerFields   = try decoder.container(keyedBy: JSONCodingKeys.self)
        fields = try containerFields.decode(Dictionary<String, Any>.self)
        
        if let allfields = fields, let system = allfields["system"] as? [String: Any] {
            if let val = system["uid"] as? String {
                uid = val
            }
            
            if let contentType = system["content_type_uid"] as? String {
                contentTypeUID = contentType
            }
        }
    }
}
