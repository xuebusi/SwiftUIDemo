//
//  FileDrectoryView2.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/8.
//


import SwiftUI

struct DirectoryNode: Identifiable {
    var id = UUID()
    var name: String
    var children: [DirectoryNode]?
}

struct FileDrectoryView2: View {
    @State var rootNode = DirectoryNode(name: "root", children: [
        DirectoryNode(name: "Documents", children: [
            DirectoryNode(name: "Notes"),
            DirectoryNode(name: "Receipts"),
            DirectoryNode(name: "Invoices")
        ]),
        DirectoryNode(name: "Downloads", children: [
            DirectoryNode(name: "Images"),
            DirectoryNode(name: "Music"),
            DirectoryNode(name: "Videos")
        ])
    ])
    
    @State private var selectedNode: DirectoryNode?
    
    var body: some View {
        VStack {
            HStack {
                Text("File Directory")
                    .font(.title)
                Spacer()
                Button(action: {
                    let newNode = DirectoryNode(name: "New Folder")
                    if var selectedNode = selectedNode {
                        if selectedNode.children == nil {
                            selectedNode.children = [newNode]
                        } else {
                            selectedNode.children?.append(newNode)
                        }
                    } else {
                        rootNode.children?.append(newNode)
                    }
                }, label: {
                    Image(systemName: "plus")
                })
            }
            .padding()
            
            TreeView2(node: rootNode, selectedNode: $selectedNode)
                .padding()
        }
    }
}

struct TreeView2: View {
    let node: DirectoryNode
    @Binding var selectedNode: DirectoryNode?
    
    var body: some View {
        VStack {
            ForEach(node.children ?? [], id: \.id) { childNode in
                DisclosureGroup(content: {
                    if childNode.children != nil {
                        TreeView2(node: childNode, selectedNode: $selectedNode)
                    } else {
                        Text(childNode.name)
                            .padding(.leading)
                            .onTapGesture {
                                selectedNode = childNode
                            }
                    }
                }, label: {
                    Text(childNode.name)
                        .padding(.leading)
                })
            }
        }
    }
}

struct FileDrectoryView2_Previews: PreviewProvider {
    static var previews: some View {
        FileDrectoryView2()
    }
}
