//
//  DocDetailView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/4.
//

import SwiftUI

// 文档详情视图
struct DocDetailView: View {
    let node: DocNode
    
    var body: some View {
        VStack {
            Text("\(node.name)文档详情")
        }
        .navigationTitle(node.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DocDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DocDetailView(node: DocNode(name: "Hello"))
    }
}
