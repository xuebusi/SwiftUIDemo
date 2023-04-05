//
//  LazyVStackSimpleView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/1.
//

import SwiftUI

// 演示VStack和LazyVStack的区别
struct LazyVStackSimpleView: View {
    
    let items = 1...100
    
    var body: some View {
        VStack {
            // VStack
            Text("VStack with 100 items").font(.headline)
            ScrollView {
                VStack {
                    ForEach(items, id: \.self) { item in
                        Text("VStack \(item)")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.cyan)
                            .onAppear {
                                // 会一次性打印所有文本
                                print("VStack: \(item)")
                            }
                    }
                }
            }
            .border(Color.gray)
            // LazyVStack
            Text("LazyVStack with 100 items").font(.headline)
            ScrollView {
                LazyVStack(spacing: 5) {
                    ForEach(items, id: \.self) { item in
                        Text("LazyVStack \(item)")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.orange)
                            .onAppear {
                                // 只会打印出现在屏幕上的文本
                                print("LazyVStack：\(item)")
                            }
                    }
                }
            }
            .border(Color.gray)
        }
    }
}

// 预览
struct LazyVStackSimpleView_Previews: PreviewProvider {
    static var previews: some View {
        LazyVStackSimpleView()
    }
}
