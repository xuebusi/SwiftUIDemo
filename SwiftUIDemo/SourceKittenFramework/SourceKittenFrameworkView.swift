//
//  SourceKittenFrameworkView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/3/29.
//

import SwiftUI
struct SourceKittenFrameworkView: View {
    var body: some View {
        HStack(alignment: .top) {
            Text("Hello SwiftUI!")
                .padding()
                .background(.cyan)
                .cornerRadius(10)
            DropdownMenuView {
                VStack {
                    Text("Option 1")
                    Text("Option 2")
                    Text("Option 3")
                }
                .padding()
            }
        }
    }
}

struct SourceKittenFrameworkView_Previews: PreviewProvider {
    static var previews: some View {
        SourceKittenFrameworkView()
    }
}


struct DropdownMenuView<Content: View>: View {
    var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    // 状态属性
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            HStack {
                Image(systemName: "chevron.down")
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 10)
//            .border(.red, width: 1)
            .onTapGesture {
                isExpanded.toggle()
            }
            
            // 下拉菜单
            ZStack(alignment: .bottom) {
                if isExpanded {
//                    VStack(spacing: 0) {
                        content
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(radius: 4)
//                    }
                    .onTapGesture {
                        isExpanded.toggle()
                    }
                }
            }
        }
    }
}
