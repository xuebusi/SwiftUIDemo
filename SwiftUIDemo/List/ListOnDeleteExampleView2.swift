//
//  ListOnDeleteExampleView2.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/15.
//

import SwiftUI

struct ListOnDeleteExampleView2: View {
    @State var items = ["Item 1", "Item 2", "Item 3"]
    @State var selectedItem: String?
    @State var isShowingDeleteConfirmation = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items, id: \.self) { item in
                    Text(item)
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("Items")
            .navigationBarItems(trailing: EditButton())
            .actionSheet(isPresented: $isShowingDeleteConfirmation, content: {
                ActionSheet(title: Text("Are you sure you want to delete this item?"), buttons: [
                    .destructive(Text("Delete"), action: {
                        deleteSelectedItem()
                    }),
                    .cancel()
                ])
            })
        }
    }
    
    func delete(at offsets: IndexSet) {
        selectedItem = items[offsets.first ?? 0]
        isShowingDeleteConfirmation = true
    }
    
    /**
    func deleteSelectedItem() {
        if let selectedItem = selectedItem, let index = items.firstIndex(of: selectedItem) {
            items.remove(at: index)
        }
        selectedItem = nil
    }
    */
    func deleteSelectedItem() {
        if let selectedItem = selectedItem, let index = items.firstIndex(of: selectedItem) {
            items.remove(at: index)
        }
        selectedItem = nil
        isShowingDeleteConfirmation = false
    }
}

struct ListOnDeleteExampleView2_Previews: PreviewProvider {
    static var previews: some View {
        ListOnDeleteExampleView2()
    }
}
