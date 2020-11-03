//
//  DefaultRender.swift
//  ContentstackUtilsTests
//
//  Created by Uttam Ukkoji on 02/11/20.
//

import Foundation
@testable import ContentstackUtils

class DefaultRender: Option {
    var entry: EntryEmbedable
    init(entry: EntryEmbedable) {
        self.entry = entry
    }
}
