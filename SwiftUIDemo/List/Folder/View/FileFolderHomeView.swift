//
//  FileFolderHomeView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/17.
//

import SwiftUI

struct FileFolderHomeView: View {
    private let rootFolder: FileFolder = FileFolder(id: "0", parentId: "-1", text: "")
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink {
                        FileFolderListView(parentFolder: rootFolder)
                    } label: {
                        Text("目录列表")
                    }
                }
                
                Section {
                    NavigationLink {
                        FileFolderDatabaseView()
                    } label: {
                        Text("目录数据库")
                    }

                }
            }
            .navigationTitle("首页")
        }
    }
}

struct FileFolderHomeView_Previews: PreviewProvider {
    static var previews: some View {
        FileFolderHomeView()
    }
}
