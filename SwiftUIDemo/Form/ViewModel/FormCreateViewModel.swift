//
//  CompViewModel.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/2/27.
//

import Foundation

class FormCreateViewModel: ObservableObject {
    // 用户选择的表单，默认文章表单
    @Published var compType: FormType = .Arcticle
    // 文章表单
    @Published var articleForm = ArticleForm()
    // 图片表单
    @Published var photoForm = PhotoForm()
    // 图表表单
    @Published var chartForm = ChartForm()
}
