//
//  AlignmentDemoView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/3/1.
//

import SwiftUI

struct AlignmentDemoView: View {
    private let screenHeight = UIScreen.main.bounds.height
    @State var isShow: Bool = false
    @State var greenHeight: CGFloat = 0
    
    var body: some View {
        Color.clear
            .overlay(alignment: .bottom) {
                VStack(spacing: 0) {
                    VStack(spacing: 10) {
                        Text("SwiftUI布局示例")
                            .foregroundColor(.blue)
                            .font(.system(.largeTitle, design: .rounded))
                        Text("点击按钮看看效果")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    Rectangle()
                        .fill(.red)
                        .frame(height: screenHeight*2/3)
                    Rectangle()
                        .fill(.green)
                        .frame(height: greenHeight)
                }
                .animation(.default, value: isShow)
            }
            .overlay(alignment: .bottom) {
                VStack {
                    Button {
                        isShow.toggle()
                        self.greenHeight = isShow ? screenHeight*2/3 : 0
                    } label: {
                        Text("按钮")
                            .padding()
                            .frame(width: 100)
                            .foregroundColor(.white)
                            .background(.blue)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
            .ignoresSafeArea()
    }
}

struct AlignmentDemoView_Previews: PreviewProvider {
    static var previews: some View {
        AlignmentDemoView()
    }
}
