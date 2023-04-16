//
//  Api.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/14.
//

import Foundation

struct Api: Identifiable, Codable {
    var id = UUID()
    var folder: String
    var name: String
    var url: String
    var method: String
}
