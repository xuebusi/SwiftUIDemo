//
//  FileFolderItemView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/16.
//

import SwiftUI

struct FileFolderItemView: View {
    @StateObject var vm: FileFolderViewModel
    @State var folder: FileFolder
    @State private var showDeleteSheet = false
    @State private var showUpdateAlert = false
    
    var body: some View {
        HStack {
            Image(systemName: "folder.fill")
                .foregroundColor(.cyan)
            NavigationLink {
                FileFolderListView(parentFolder: folder)
            } label: {
                swipeActionView()
            }
        }
        .alert("修改目录名称", isPresented: $showUpdateAlert) {
            updateAlertView()
        }
        .actionSheet(
            isPresented: $showDeleteSheet,
            content: {
                ActionSheet(title: Text("确认删除该目录吗？"), buttons: [
                    .destructive(Text("删除"), action: {
                        vm.deleteFolder()
                    }),
                    .cancel(Text("取消"))
                ])
            }
        )
    }
}

extension FileFolderItemView {
    // 滑动手势操作按钮
    func swipeActionView() -> some View {
        Text(folder.text)
            .lineLimit(1)
            .swipeActions(allowsFullSwipe: false) {
                Button(role: .destructive) {
                    vm.selectedFolder = folder
                    showDeleteSheet.toggle()
                } label: {
                    Text("删除")
                }
                
                Button {
                    vm.selectedFolder = folder
                    vm.updateFolderName = folder.text
                    showUpdateAlert.toggle()
                } label: {
                    Text("修改")
                }
                .tint(.green)
            }
    }
    
    // 修改目录名称弹框
    func updateAlertView() -> some View {
        Group {
            TextField("名称", text: $vm.updateFolderName)
            HStack {
                Button(role: .cancel) {
                    
                } label: {
                    Text("取消")
                }
                
                Button {
                    vm.updateFolder()
                } label: {
                    Text("确定")
                }
            }
        }
    }
}

struct FileFolderItemView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FileFolderItemView(vm: FileFolderViewModel(), folder: FileFolder(parentId: "0", text: "A"))
        }
    }
}
