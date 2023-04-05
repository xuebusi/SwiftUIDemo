//
//  MVVMDemoView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/2/27.
//

import SwiftUI

struct MVVMDemoView: View {
    @ObservedObject var vm = MVVMViewModel()
    
    var body: some View {
        VStack() {
            // 展示输入的文本
            Text("欢迎来到， \(self.vm.nameText)")
            
            // 定义一个输入框，将用户输入的文本绑定到ViewModel中的nameText属性
            TextField("输入一段文本", text: self.$vm.nameText)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding()
    }
}

struct MVVMDemoView_Previews: PreviewProvider {
    static var previews: some View {
        MVVMDemoView()
    }
}
