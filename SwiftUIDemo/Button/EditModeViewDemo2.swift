//
//  EditModeViewDemo2.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/15.
//

import SwiftUI

struct EditModeViewDemo2: View {
    @State var items = ["苹果", "香蕉", "桔子"]
    @Environment(\.editMode) var editMode
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items, id: \.self) { item in
                    NavigationLink {
                        Text(item)
                            .navigationTitle(item)
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        Text(item)
                    }

                }
                .onDelete(perform: delete)
                .onMove(perform: move)
            }
            .navigationTitle("水果")
            .navigationBarItems(trailing: EditButton())
            .environment(\.editMode, editMode)
        }
    }
    
    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    func move(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
}

struct EditModeViewDemo2_Previews: PreviewProvider {
    static var previews: some View {
        EditModeViewDemo2()
    }
}
