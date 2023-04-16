//
//  FileNodeExampleView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/10.
//

import SwiftUI

struct FileNodeExampleView: View {
    @State var rootItem = FileItem0(name: "Root", children: [
        FileItem0(name: "Folder 1", children: [
            FileItem0(name: "Subfolder 1"),
            FileItem0(name: "Subfolder 2"),
        ]),
        FileItem0(name: "Folder 2", children: [
            FileItem0(name: "Subfolder 3", children: [
                FileItem0(name: "Sub-subfolder 1"),
            ]),
        ]),
    ])
    @State var selectedItem: FileItem0?

    var body: some View {
        List {
            OutlineGroup(rootItem, children: \.children) { item in
                Text(item.name)
                    .onTapGesture {
                    }
                    .contextMenu {
                        Button("Add Folder", action: {
                            self.selectedItem = item
                            print(">>> 选择：\(self.selectedItem?.name)")
                            self.selectedItem?.children?.append(FileItem0(name: "New Folder"))
                        })
                        Button("Add File", action: {
                            self.selectedItem = item
                            print(">>> 选择：\(self.selectedItem?.name)")
                            self.selectedItem?.children?.append(FileItem0(name: "New File"))
                        })
                        Button("Delete", action: {
                            self.selectedItem = item
                            print(">>> 选择：\(self.selectedItem?.name)")
                            if let index = self.selectedItem?.children?.firstIndex(where: { $0.id == self.selectedItem!.id }) {
                                self.selectedItem?.children?.remove(at: index)
                            } else {
                                self.rootItem = FileItem0(name: "Root", children: [])
                            }
                            self.selectedItem = nil
                        })
                    }
            }
        }
        .navigationBarItems(trailing: Button("Add Folder", action: {
            self.rootItem.children?.append(FileItem0(name: "New Folder"))
        }))
    }
}

struct FileItem0: Identifiable {
    let id = UUID()
    let name: String
    var children: [FileItem0]?
}

struct FileNodeExampleView_Previews: PreviewProvider {
    static var previews: some View {
        FileNodeExampleView()
    }
}
