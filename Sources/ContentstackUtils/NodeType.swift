//
//  NodeType.swift
//  ContentstackUtils
//
//  Created by Uttam Ukkoji on 03/06/21.
//

public enum NodeType: String {
    case document = "doc",
         paragraph = "p",
    
         link = "a",
         image = "img",
         embed,

         heading_1 = "h1",
         heading_2 = "h2",
         heading_3 = "h3",
         heading_4 = "h4",
         heading_5 = "h5",
         heading_6 = "h6",
  
         orderList = "ol",
         unOrderList = "ul",
         listItem = "li",
  
         hr,

         table,
         tableHeader = "thead",
         tableBody = "tbody",
         tableFooter = "tfoot",
         tableRow = "tr",
         tableHead = "th",
         tableData = "td",

         blockQuote = "blockquote",
         code,

         text,
         reference,
         
         unknown
}
