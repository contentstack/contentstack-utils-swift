//
//  GQLJsonRTE.swift
//  ContentstackUtilsTests
//
//  Created by Uttam Ukkoji on 19/07/21.
//

import Foundation

let kGQLAssetEmbed = """
{
 "edges":
    [{
      "node":
            {
                "system":  {
                  "content_type_uid": "sys_assets",
                  "uid": "blt44asset"
                },
                "created_at": "2020-08-19T09:13:05.864Z",
                "updated_at": "2020-09-10T09:35:28.393Z",
                "created_by": "bltcreate",
                "updated_by": "bltcreate",
                "content_type": "image/png",
                "file_size": "36743",
                "filename": "svg-logo-text.png",
                "url": "svg-logo-text.png",
                "_version": 7,
                "title": "svg-logo-text.png",
                "description": "",
              }
    }]
}
"""

let kGQLEntryblock = """
{
 "edges":
    [{
      "node": {
        "title": "Update this title",
        "url": "",
        "locale": "en-us",
        "system":  {
          "uid": "blttitleuid",
          "content_type_uid": "content_block",
        },
        "_version": 5,
        "_in_progress": false,
        "multi_line": "",
      }
    }]
}
"""

let kGQLEntryLink = """
{
 "edges":
    [{
      "node": {
        "title": "Entry with embedded entry",
        "locale": "en-us",
        "system":  {
          "uid": "bltemmbedEntryuid",
          "content_type_uid": "embeddedrte",
        }
      }
    }]
}
"""
let kGQLEntryInline = """
{
 "edges":
    [{
      "node": {
        "title": "updated title",
        "locale": "en-us",
        "system":  {
          "uid": "blttitleUpdateuid",
          "content_type_uid": "embeddedrte",
        }
      }
    }]
}
"""


func GQLJsonRTE(node: String, items: String = "{}") -> [String: Any?]? {
    let gqlResponse = """
{
    "uid": "EntryUID",
    "single_rte": {
        "json": \(node),
        "embedded_itemsConnection": \(items)
    },
    "multiple_rte": {
        "json": [\(node)],
        "embedded_itemsConnection": \(items)
    }
}
"""
    let data = Data(gqlResponse.utf8)
    if let object = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any?]{
        return object
    }
    
    return nil
}
