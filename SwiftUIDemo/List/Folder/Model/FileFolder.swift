//
//  FileFolder.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/16.
//

import Foundation

struct FileFolder: Identifiable, Equatable, Codable {
    var id: String = UUID().uuidString
    var parentId: String
    var text: String
}
