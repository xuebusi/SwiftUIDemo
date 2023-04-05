//
//  DocNode.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/4.
//

import Foundation

// 文档节点
struct DocNode: Identifiable {
    var id = UUID()
    var name: String
    // 子目录
    var children: [DocNode]?
}

extension DocNode {
    // 模拟数据
    static func docNodes() -> [DocNode] {
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
        return nodes
    }
}
