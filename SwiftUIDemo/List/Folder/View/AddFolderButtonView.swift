//
//  AddFolderButtonView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/16.
//

import SwiftUI

struct AddFolderButtonView: View {
    @StateObject var vm: FileFolderViewModel
    @State var showAddAlert: Bool = false
    
    var body: some View {
        Button {
            showAddAlert.toggle()
        } label: {
            Image(systemName: "folder.badge.plus")
        }
        .alert("创建目录", isPresented: $showAddAlert) {
            TextField("名称", text: $vm.createdFolderName)
            HStack {
                Button(role: .cancel) {
                    vm.createdFolderName = ""
                } label: {
                    Text("取消")
                }
                
                Button {
                    vm.addFolder()
                } label: {
                    Text("确定")
                }
            }
        }
    }
}

struct AddFolderButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddFolderButtonView(vm: FileFolderViewModel())
    }
}
