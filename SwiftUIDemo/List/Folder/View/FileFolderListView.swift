//
//  FileFolderListView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/15.
//

import SwiftUI

struct FileFolderListView: View {
    @StateObject var vm = FileFolderViewModel()
    @State var parentFolder: FileFolder
    
    init(parentFolder: FileFolder) {
        self.parentFolder = parentFolder
    }
    
    var body: some View {
        List {
            ForEach(vm.folders) { folder in
                FileFolderItemView(vm: vm, folder: folder)
            }
            .onMove {
                vm.moveFolder(from: $0, to: $1)
            }
        }
        .onAppear {
            vm.loadFolders(parentFolder: self.parentFolder)
        }
        .navigationTitle(parentFolder.text.isEmpty ? "目录列表" : parentFolder.text)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: AddFolderButtonView(vm: vm))
    }
}

struct MessageListDeleteView_Previews: PreviewProvider {
    static var previews: some View {
        FileFolderListView(parentFolder: FileFolder(parentId: "0", text: ""))
    }
}
