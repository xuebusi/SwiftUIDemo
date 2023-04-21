//
//  FileFolderHomeView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/17.
//

import SwiftUI

struct FileFolderHomeView: View {
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink {
                        FileFolderListView(parentFolder: FileFolder(parentId: "0", text: ""))
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
