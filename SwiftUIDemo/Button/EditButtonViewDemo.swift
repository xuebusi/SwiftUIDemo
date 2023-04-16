//
//  EditButtonViewDemo.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/15.
//

import SwiftUI

struct EditButtonViewDemo: View {
    @State private var fruits = [
        "Apple",
        "Banana",
        "Papaya",
        "Mango"
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach(fruits, id: \.self) { fruit in
                    Text(fruit)
                }
                .onDelete {
                    fruits.remove(atOffsets: $0)
                }
                .onMove {
                    fruits.move(fromOffsets: $0, toOffset: $1)
                }
            }
            .navigationTitle("Fruits")
            .toolbar {
                EditButton()
            }
        }
    }
}

struct EditButtonViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        EditButtonViewDemo()
    }
}
