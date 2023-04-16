//
//  RecurrenceFolderViewExample.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/8.
//

import SwiftUI

// 通过递归函数生成视图的示例
struct RecurrenceFolderViewExample: View {
    let folders: [RecurrenceFolder] = [
        RecurrenceFolder(name: "文档", subfolders: [
            RecurrenceFolder(name: "项目", subfolders: [
                RecurrenceFolder(name: "SwiftUI"),
                RecurrenceFolder(name: "UIKit")
            ]),
            RecurrenceFolder(name: "照片")
        ]),
        RecurrenceFolder(name: "下载")
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(folders, id: \.name) { folder in
                    RecurrenceFolderView(folder: folder)
                }
            }
            .navigationTitle("Folders")
        }
    }
}


struct FolderExample_Previews: PreviewProvider {
    static var previews: some View {
        RecurrenceFolderViewExample()
    }
}
