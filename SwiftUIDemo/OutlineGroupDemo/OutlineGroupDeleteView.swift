//
//  OutlineGroupDeleteView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/5.
//

import SwiftUI

struct OutlineGroupDeleteView: View {
    let data =
    FileItem(name: "users", children:
                [FileItem(name: "user1234", children:
                            [FileItem(name: "Photos", children:
                                        [FileItem(name: "photo001.jpg"),
                                         FileItem(name: "photo002.jpg")]),
                             FileItem(name: "Movies", children:
                                        [FileItem(name: "movie001.mp4")]),
                             FileItem(name: "Documents", children: [])
                            ]),
                 FileItem(name: "newuser", children:
                            [FileItem(name: "Documents", children: [])
                            ])
                ])
    
    var body: some View {
        List {
            OutlineGroup(data, id: \.id, children: \.children) { item in
                Text("\(item.description)")
            }
        }
    }
}

struct FileItem: Hashable, Identifiable, CustomStringConvertible {
    var id = UUID()
    var name: String
    var children: [FileItem]? = nil
    var description: String {
        switch children {
        case nil:
            return "📄 \(name)"
        case .some(let children):
            return children.isEmpty ? "📂 \(name)" : "📁 \(name)"
        }
    }
}

struct OutlineGroupDeleteView_Previews: PreviewProvider {
    static var previews: some View {
        OutlineGroupDeleteView()
    }
}
