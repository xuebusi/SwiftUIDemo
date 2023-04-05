//
//  ErrorMessageView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/3/30.
//

import SwiftUI

struct ErrorView: View {
    @Binding var isPresented: Bool // 控制提示框是否显示
    let title: String
    let message: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
            Text(message)
                .font(.subheadline)
                .padding(.top, 8)
            Spacer()
        }
        .padding(16)
        .background(Color.red)
        .cornerRadius(8)
        .foregroundColor(.white)
        .opacity(isPresented ? 1 : 0) // 控制透明度
        .animation(.easeInOut(duration: 0.3)) // 添加动画效果
        .onAppear {
            // 设置3秒后自动消失
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    isPresented = false
                }
            }
        }
    }
}

// 在其他视图中使用该组件
struct ErrorMessageView: View {
    @State var showError = false
    
    var body: some View {
        VStack {
            if showError {
                ErrorView(isPresented: $showError, title: "Error", message: "Something went wrong.")
                    .transition(.move(edge: .top)) // 添加一个进入动画
            }
            Button("Show Error") {
                showError = true
            }
        }
    }
}


struct ErrorMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorMessageView()
    }
}
