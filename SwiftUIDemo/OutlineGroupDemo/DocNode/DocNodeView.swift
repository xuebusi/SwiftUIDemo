//
//  DocNodeView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/4.
//

import SwiftUI

// 文档节点视图
struct DocNodeView: View {
    var node: DocNode
    var body: some View {
        Text(node.name)
    }
}

struct DocNodeView_Previews: PreviewProvider {
    static var previews: some View {
        DocNodeView(node: DocNode(name: "Hello"))
    }
}
