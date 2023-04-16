//
//  PopoverExample.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/5.
//

import SwiftUI

struct PopoverExample: View {
    @State private var isShowingPopover = true

    var body: some View {
        Button("Show Popover") {
            self.isShowingPopover = true
        }
        .popover(isPresented: $isShowingPopover) {
            ZStack {
                Color.orange
                VStack(spacing: 0) {
                    HStack {
                        Rectangle()
                            .fill(.black.opacity(0.3))
                            .frame(width: 100, height: 5)
                            .cornerRadius(2.5)
                    }
                    .frame(height: 30)
                    .frame(maxWidth: .infinity)
                    VStack {
                        Text("Popover Content")
                            .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
    }
}

struct PopoverExample_Previews: PreviewProvider {
    static var previews: some View {
        PopoverExample()
    }
}
