//
//  EditableOutlineGroupDemoView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/4.
//

import SwiftUI

// 可折叠的List示例
struct EditableOutlineGroupDemoView: View {
    var body: some View {
        NavigationView {
            List(DocNode.docNodes(), id: \.id, children: \.children) { node in
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

struct EditableOutlineGroupDemoView_Previews: PreviewProvider {
    static var previews: some View {
        EditableOutlineGroupDemoView()
    }
}
