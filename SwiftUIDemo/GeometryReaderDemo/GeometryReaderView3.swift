//
//  GeometryReaderView3.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/3/12.
//

import SwiftUI

struct GeometryReaderView3: View {
    var body: some View {
//        GeometryReader { geometry in
//            Rectangle()
//                .frame(width: geometry.size.width, height: geometry.size.height / 2, alignment: .top)
//                .foregroundColor(.red)
//        }
        
//        GeometryReader { geometry in
//            Rectangle()
//                .foregroundColor(.red)
//                .frame(width: geometry.size.width / 2, height: geometry.size.height / 2)
//                .position(x: geometry.size.width / 2 + cos(.pi / 4) * 100, y: geometry.size.height / 2 + sin(.pi / 4) * 100)
//        }
        
//        ActionButton(title: "Hello SwiftUI")
        
        PagerView(pageCount: 5) {
            Rectangle()
                .fill(LinearGradient(colors: [.red, .orange], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 400, height: 250)
                .cornerRadius(20)
                .padding()
        }
    }
}

struct ActionButton: View {
    var title: String
    var body: some View {
        GeometryReader { geometry in
            Text(title)
                .font(.headline)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(15)
                .frame(width: geometry.size.width, height: 40)
        }
    }
}

struct PagerView<Content: View>: View {
    var pageCount: Int
    var content: Content
    
    init(pageCount: Int, @ViewBuilder content: () -> Content) {
        self.pageCount = pageCount
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(0..<pageCount) { index in
                        self.content
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                }
            }
        }
    }
}

struct GeometryReaderView3_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderView3()
    }
}
