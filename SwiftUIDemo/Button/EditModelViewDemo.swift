//
//  EditModelViewDemo.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/15.
//

import SwiftUI

struct EditModelViewDemo: View {
    @Environment(\.editMode) private var editMode
    @State var items = ["吃饭", "睡觉", "看电视"]
    @State var isEditing = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items, id: \.self) { item in
                    Text(item)
                }
                .onDelete(perform: delete)
                .onMove(perform: onmove)
            }
            .navigationTitle("任务列表")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        withAnimation {
                            isEditing.toggle()
                        }
                    }) {
                        if isEditing {
                            Text("完成")
                        } else {
                            Text("编辑")
                        }
                    }
                }
            }
            .environment(\.editMode, isEditing ? .constant(.active) : .constant(.inactive))
        }
    }
    
    func delete(offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    func onmove(from: IndexSet,  to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
}

struct EditModelViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        EditModelViewDemo()
    }
}
