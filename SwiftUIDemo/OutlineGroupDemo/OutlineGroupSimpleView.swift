//
//  OutlineGroupSimpleView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/3/30.
//

import SwiftUI

struct OutlineGroupSimpleView: View {
    let treeData = Tree(name: "Root", children: [
        Tree(name: "Child 1"),
        Tree(name: "Child 2"),
        Tree(name: "Child 3", children: [
            Tree(name: "Grandchild 1"),
            Tree(name: "Grandchild 2")
        ])
    ])
    
    var body: some View {
        List {
            OutlineGroup(treeData, children: \.children) { tree in
                Text(tree.name)
            }
        }
    }
}

struct Tree: Identifiable {
    let id = UUID()
    let name: String
    var children: [Tree]? = []
    
    init(name: String, children: [Tree] = []) {
        self.name = name
        self.children = children
    }
}

struct OutlineGroupSimpleView_Previews: PreviewProvider {
    static var previews: some View {
        OutlineGroupSimpleView()
    }
}
