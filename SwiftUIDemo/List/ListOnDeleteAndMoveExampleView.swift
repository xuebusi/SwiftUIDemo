//
//  ListOnDeleteAndMoveExampleView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/4.
//

import SwiftUI

struct ListOnDeleteAndMoveExampleView: View {
    @State private var itemList = [
        "item 1",
        "item 2",
        "item 3"
    ]
    @State private var showingAlert = false
    @State private var newListItem = ""
    var body: some View {

        NavigationView {
            
            List {
                ForEach(itemList, id: \.self) { contact in
                    Text(contact)
                }.onDelete { indexSet in
                    itemList.remove(atOffsets: indexSet)
                }
                .onMove { itemList.move(fromOffsets: $0, toOffset: $1)}
            }
            .toolbar {

                EditButton()
                Button("+") {
                    showingAlert.toggle()
                    print("Pressed")
                }
                .alert("Enter a list item", isPresented: $showingAlert) {
                    TextField("Enter list item", text: $newListItem)
                    Button("OK", action: submit)
                }
            }
        }
    }
    func submit() {
        print("You entered \(newListItem)")
        itemList.append(newListItem)
        
    }
}

struct ListOnDeleteAndMoveExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ListOnDeleteAndMoveExampleView()
    }
}
