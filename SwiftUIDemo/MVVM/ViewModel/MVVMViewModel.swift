//
//  MVVMViewModel.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/2/27.
//

import Foundation

// 定义ViewModel,封装数据和行为
class MVVMViewModel: ObservableObject {
    @Published var nameText = ""
}
