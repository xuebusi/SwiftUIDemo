//
//  ForEachDeleteView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/13.
//

import SwiftUI

struct ForEachDeleteView: View {
    @State var myArray: [Int] = [1, 2, 3, 4, 5]

        var body: some View {
            List {
                ForEach(myArray.indices, id: \.self) { index in
                    Text("\(myArray[index])")
                }
                .onDelete(perform: delete)
            }
        }

        func delete(at offsets: IndexSet) {
            myArray.remove(atOffsets: offsets)
        }
}

struct ForEachDeleteView_Previews: PreviewProvider {
    static var previews: some View {
        ForEachDeleteView()
    }
}
