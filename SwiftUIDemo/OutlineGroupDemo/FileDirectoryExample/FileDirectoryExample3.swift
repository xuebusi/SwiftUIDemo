//
//  FileDirectoryExample3.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/9.
//

import SwiftUI

struct TreeNodeOperationView: View {
    @StateObject var vm = TreeDataViewModel()
    @State private var isShowingAddNodeSheet = false
    @State private var newNodeName = ""
    @State private var parentNodeName = ""
    
    var body: some View {
        NavigationView {
            List {
                OutlineGroup(vm.nodeList, children: \.children) { node in
                    Text(node.name)
                }
            }
            .navigationBarTitle("Nodes")
            .navigationBarItems(trailing:
                                    Button(action: {
                isShowingAddNodeSheet = true
            }) {
                Image(systemName: "plus")
            }
            )
            .sheet(isPresented: $isShowingAddNodeSheet) {
                let parentNode = vm.queryChildNode(in: vm.nodeList[0], with: "Node 1")
                let newNode = TreeNode0(name: newNodeName)
                if let parent = parentNode {
                    vm.addChildNode(to: parent, child: newNode)
                }
                isShowingAddNodeSheet = false
            } content: {
                VStack {
                    TextField("节点名称", text: $newNodeName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Picker("父节点", selection: $parentNodeName) {
                        ForEach(vm.nodeList, id: \.id) { node in
                            Text(node.name).tag(node.name)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    Button("保存") {
                        isShowingAddNodeSheet = false
                    }
                    .padding()
                }
            }
        }
    }
}

struct TreeNodeOperationView_Previews: PreviewProvider {
    static var previews: some View {
        TreeNodeOperationView()
    }
}

struct TreeNode0: Identifiable, Codable, Hashable, Equatable {
    var id: String = UUID().uuidString
    var name: String
    var children: [TreeNode0]?
    
    static func == (lhs: TreeNode0, rhs: TreeNode0) -> Bool {
        return lhs.id == rhs.id
    }
}

class TreeDataViewModel: ObservableObject {
    @Published var nodeList: [TreeNode0] = [
        TreeNode0(name: "Node 1", children: [
            TreeNode0(name: "Child 1"),
            TreeNode0(name: "Child 2")
        ]),
        TreeNode0(name: "Node 2", children: [
            TreeNode0(name: "Child 3"),
            TreeNode0(name: "Child 4")
        ])
    ]
    
    func addChildNode(to parent: TreeNode0, child: TreeNode0) {
        if let index = nodeList.firstIndex(of: parent) {
            nodeList[index].children?.append(child)
            if !nodeList.contains(parent) {
                nodeList.append(parent)
            }
            print(">>> parent: \(parent)")
            print(">>> child: \(child)")
        }
    }
    
    func queryChildNode(in parent: TreeNode0, with name: String) -> TreeNode0? {
        if let index = nodeList.firstIndex(of: parent) {
            return nodeList[index].children?.first(where: { $0.name == name })
        }
        return nil
    }
    
    func removeChildNode(from parent: TreeNode0, with name: String) {
        if let index = nodeList.firstIndex(of: parent) {
            nodeList[index].children?.removeAll(where: { $0.name == name })
        }
    }
}

