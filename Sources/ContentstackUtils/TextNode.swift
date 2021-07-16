//
//  TextNode.swift
//  ContentstackUtils
//
//  Created by Uttam Ukkoji on 07/06/21.
//

import Foundation

class TextNode: Node {
    public var bold: Bool = false
    public var italic: Bool = false
    public var underline: Bool = false
    public var strikethrough: Bool = false
    public var inlineCode: Bool = false
    public var `subscript`: Bool = false
    public var superscript: Bool = false
    public var text: String
    public enum FieldKeys: String, CodingKey {
        case text
        case bold, italic, underline, strikethrough, inlineCode, `subscript`, superscript
    }
    
    public required init(from decoder: Decoder) throws {
        let container   = try decoder.container(keyedBy: FieldKeys.self)

        text = try container.decode(String.self, forKey: .text)
        bold = try container.decodeIfPresent(Bool.self, forKey: .bold) ?? false
        italic = try container.decodeIfPresent(Bool.self, forKey: .italic) ?? false
        underline = try container.decodeIfPresent(Bool.self, forKey: .underline) ?? false
        strikethrough = try container.decodeIfPresent(Bool.self, forKey: .strikethrough) ?? false
        inlineCode = try container.decodeIfPresent(Bool.self, forKey: .inlineCode) ?? false
        `subscript` = try container.decodeIfPresent(Bool.self, forKey: .`subscript`) ?? false
        superscript = try container.decodeIfPresent(Bool.self, forKey: .superscript) ?? false
        
        try super.init(from: decoder)
        type = NodeType.text.rawValue
    }
}
