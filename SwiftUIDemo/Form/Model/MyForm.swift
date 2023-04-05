//
//  Comp.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/2/27.
//

import Foundation

enum FormType: String, Codable, CaseIterable {
    case Arcticle = "文章表单"
    case Photo = "图片表单"
    case Chart = "图表表单"
}

struct ArticleForm {
    var id = UUID().uuidString
    var name: String = ""
    var type: FormType = .Arcticle
    
    var title: String = ""
}

struct PhotoForm {
    var id = UUID().uuidString
    var name: String = ""
    var type: FormType = .Photo
    
    var url: String = ""
}

struct ChartForm {
    var id = UUID().uuidString
    var name: String = ""
    var type: FormType = .Chart
    
    var x: String = ""
    var y: String = ""
}
