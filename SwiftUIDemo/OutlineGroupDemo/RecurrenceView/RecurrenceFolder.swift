//
//  RecurrenceFolder.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/8.
//

import Foundation

// 递归目录
struct RecurrenceFolder {
    let name: String
    var subfolders: [RecurrenceFolder] = []
}
