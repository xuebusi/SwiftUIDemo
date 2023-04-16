//
//  TreeNodeTView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/10.
//

import SwiftUI

struct TreeNodeTView: View {
    @State var tree = TreeT("A")
    @State private var values: [String] = []
    
    var body: some View {
        VStack {
            OutlineGroup(tree.root, children: \.children) { node in
                Text(node.value)
                ForEach(node.children ?? [], id: \.value) { child in
                    Text(child.value)
                }
            }
        }
        .onAppear {
            let b = TreeNodeT("B")
            let c = TreeNodeT("C")
            let d = TreeNodeT("D")
            let e = TreeNodeT("E")
            let f = TreeNodeT("F")
            
            tree.root.addChild(b)
            tree.root.addChild(c)
            b.addChild(d)
            b.addChild(e)
            c.addChild(f)
            
            tree.traverseDepthFirst { node in
                values.append(node.value)
            }
        }
    }
}

struct TreeViewCom: View {
    let node: TreeNodeT<String>
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(node.value)
                .font(.headline)
            ForEach(node.children ?? [], id: \.value) { child in
                TreeViewCom(node: child)
            }
        }
        .padding(.leading)
    }
}



struct TreeNodeTView_Previews: PreviewProvider {
    static var previews: some View {
        TreeNodeTView()
    }
}

class TreeNodeT<T: Codable>: Identifiable, Codable {
    var id: String = UUID().uuidString
    var value: T
    var children: [TreeNodeT]?
    
    init(_ value: T) {
        self.value = value
    }
    
    func addChild(_ node: TreeNodeT) {
        children?.append(node)
    }
}

class TreeT<T: Codable>: Codable {
    var root: TreeNodeT<T>
    
    init(_ value: T) {
        self.root = TreeNodeT(value)
    }
    
    func traverseDepthFirst(_ block: (TreeNodeT<T>) -> Void) {
        func traverse(_ node: TreeNodeT<T>, _ block: (TreeNodeT<T>) -> Void) {
            block(node)
            for child in node.children ?? [] {
                traverse(child, block)
            }
        }
        traverse(root, block)
    }
    
    func traverseBreadthFirst(_ block: (TreeNodeT<T>) -> Void) {
        var queue = [root]
        while !queue.isEmpty {
            let node = queue.removeFirst()
            block(node)
            queue += node.children ?? []
        }
    }
}
