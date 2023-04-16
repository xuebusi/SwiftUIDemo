//
//  RecurrenceFolderView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/8.
//

import SwiftUI

// 递归目录视图
struct RecurrenceFolderView: View {
    let folder: RecurrenceFolder
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(folder.name)
            if !folder.subfolders.isEmpty {
                ForEach(folder.subfolders, id: \.name) { subfolder in
                    RecurrenceFolderView(folder: subfolder)
                        .padding(.leading)
                }
            }
        }
    }
}


struct FolderView_Previews: PreviewProvider {
    static var previews: some View {
        RecurrenceFolderView(folder: RecurrenceFolder(
            name: "A",
            subfolders: [
                RecurrenceFolder(name: "A1", subfolders: [RecurrenceFolder(name: "A1-1"), RecurrenceFolder(name: "A1-2")]),
                RecurrenceFolder(name: "A2", subfolders: [RecurrenceFolder(name: "A2-1"), RecurrenceFolder(name: "A2-2")])
            ]
        ))
    }
}
