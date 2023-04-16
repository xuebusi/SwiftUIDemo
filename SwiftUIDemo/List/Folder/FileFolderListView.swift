//
//  FileFolderListView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/15.
//

import SwiftUI

struct FileFolderListView: View {
    @StateObject var vm = FileFolderViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.folders) { folder in
                    FileFolderItemView(vm: vm, folder: folder)
                }
                .onMove {
                    vm.moveFolder(from: $0, to: $1)
                }
            }
            .onAppear {
                vm.loadFolders()
            }
            .navigationTitle("目录列表")
            .navigationBarItems(trailing: AddFolderButtonView(vm: vm))
        }
    }
}

struct MessageListDeleteView_Previews: PreviewProvider {
    static var previews: some View {
        FileFolderListView()
    }
}
