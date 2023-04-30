//
//  FileFolderDatabaseView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/17.
//

import SwiftUI

struct FileFolderDatabaseView: View {
    @StateObject var vm = FileFolderViewModel()
    
    @State var folders: [FileFolder] = []
    
    var body: some View {
        List {
            ForEach(folders) { folder in
                VStack(alignment: .leading) {
                    Text(folder.parentId)
                        .foregroundColor(.red)
                    Text(folder.id)
                        .foregroundColor(.cyan)
                    Text(folder.text)
                        .foregroundColor(.gray)
                }
                .font(.system(.caption))
            }
        }
        .onAppear {
            folders = vm.getAllFolders()
        }
    }
}

struct FileFolderDatabaseView_Previews: PreviewProvider {
    static var previews: some View {
        FileFolderDatabaseView()
    }
}
