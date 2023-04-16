//
//  FileDirectoryExample2.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/9.
//

import SwiftUI

struct Directory2: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var children: [Directory2]?
}

struct FileDirectoryExample2: View {
    @State private var directories: [Directory2] = [
        Directory2(name: "Documents", children: [
            Directory2(name: "Work", children: [
                Directory2(name: "Project A"),
                Directory2(name: "Project B")
            ]),
            Directory2(name: "Personal", children: [
                Directory2(name: "Vacation Photos"),
                Directory2(name: "Taxes")
            ])
        ]),
        Directory2(name: "Downloads", children: [
            Directory2(name: "Images"),
            Directory2(name: "Music"),
            Directory2(name: "Videos")
        ]),
        Directory2(name: "Applications")
    ]
    
    @State private var showingSheet = false
    @State private var newDirectoryName = ""
    @State private var selectedParentDirectory: Directory2?
    
    var body: some View {
        NavigationView {
            List {
                OutlineGroup(directories, children: \.children) { directory in
                    Text(directory.name)
                }
            }
            .navigationBarTitle("目录列表")
            .navigationBarItems(trailing:
                                    Button(action: {
                self.showingSheet = true
            }) {
                Image(systemName: "folder.badge.plus")
            }
            )
            .sheet(isPresented: $showingSheet) {
                DirectorySheet(directories: self.$directories,
                               newDirectoryName: self.$newDirectoryName,
                               selectedParentDirectory: self.$selectedParentDirectory,
                               showingSheet: self.$showingSheet)
            }
        }
    }
}

struct DirectorySheet: View {
    @Binding var directories: [Directory2]
    @Binding var newDirectoryName: String
    @Binding var selectedParentDirectory: Directory2?
    @Binding var showingSheet: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("新目录名称")) {
                    TextField("名称", text: $newDirectoryName)
                }
                
                Section(header: Text("上级目录")) {
                    Picker(selection: $selectedParentDirectory, label: Text("上级目录")) {
                        Text("None").tag(nil as Directory2?)
                        ForEach(directories, id: \.id) { directory in
                            DirectoryPickerRow(directory: directory)
                        }
                    }
                }
                
                Section {
                    Button(action: {
                        let newDirectory = Directory2(name: self.newDirectoryName, children: nil)
                        var parent: Directory2? // move the definition of parent outside of the if block
                        if let selectedParentDirectory = self.selectedParentDirectory {
                            parent = selectedParentDirectory
                            if parent!.children == nil {
                                parent!.children = []
                            }
                            parent!.children?.append(newDirectory)
                        } else {
                            self.directories.append(newDirectory)
                        }
                        
                        // 更新 directories 数组
                        self.directories = self.directories.map { directory in
                            if directory.id == self.selectedParentDirectory?.id {
                                return parent!
                            } else {
                                return directory
                            }
                        }
                        
                        self.showingSheet = false
                    }) {
                        Text("保存")
                    }
                }
            }
            .navigationBarTitle("新建目录")
        }
    }
}

struct DirectoryPickerRow: View {
    var directory: Directory2
    
    var body: some View {
        Text(directory.name).tag(directory as Directory2?)
    }
}

struct FileDirectoryExample2_Previews: PreviewProvider {
    static var previews: some View {
        FileDirectoryExample2()
    }
}
