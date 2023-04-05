//
//  ExpandingListView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/4.
//

import SwiftUI

// 树形目录示例演示
struct ExpandingListView: View {
    // 模拟数据
    let nodes: [DocNode] = [
        DocNode(
            name: "A",
            children: [
                DocNode(
                    name: "A3",
                    children: [
                        DocNode(name: "A3-1", children: nil),
                        DocNode(name: "A3-2", children: nil),
                        DocNode(name: "A3-3", children: nil),
                    ]
                ),
                DocNode(name: "A1", children: nil),
                DocNode(name: "A2", children: nil),
            ]
        ),
        DocNode(
            name: "B",
            children: [
                DocNode(name: "B1", children: nil),
                DocNode(name: "B2", children: nil),
            ]
        )
    ]
    
    var body: some View {
        NavigationView {
            List(nodes, id: \.id, children: \.children) { node in
                // 目录图标
                Image(systemName: node.children != nil ? "folder.fill" : "doc.text.fill")
                    .foregroundColor(node.children != nil ? .cyan : .orange)
                // 如果是目录
                if node.children != nil {
                    DocNodeView(node: node)
                } else {
                    // 如果是文档
                    NavigationLink(node.name) {
                        // 文档详情视图
                        DocDetailView(node: node)
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("文档目录")
            .navigationBarTitleDisplayMode(.inline)
        }
        // 解决在iPad上视图被折叠问题
        .navigationViewStyle(StackNavigationViewStyle())
    }
}



struct ExpandingListView_Previews: PreviewProvider {
    static var previews: some View {
        ExpandingListView()
    }
}
