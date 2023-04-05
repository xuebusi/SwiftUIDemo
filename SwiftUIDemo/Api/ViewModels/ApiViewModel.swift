//
//  MockDataViewModel.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/2/26.
//

import Foundation

class ApiViewModel: ObservableObject {
    @Published var asyncString: String = ""
    @Published var words: [String] = []
    
    // 模拟异步调用API加载数据
    func getAsyncData() {
        // 模拟请求时间为2秒钟
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.asyncString = "Talk is cheap, show me the code!"
            self.splitWord()
        })
        
    }
    
    // 模拟对数据进行业务处理
    func splitWord() {
        let splits = self.asyncString.split(separator: " ")
        for s in splits {
            self.words.append(String(s))
        }
    }
}
