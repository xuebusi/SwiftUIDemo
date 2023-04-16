//
//  AlertDemo1.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/16.
//

import SwiftUI

struct SaveDetails: Identifiable {
    let name: String
    let error: String
    let id = UUID()
}

struct Login: View {
    @State private var didFail = false
    let alertTitle: String = "登录失败"

    var body: some View {
        LoginForm(didFail: $didFail)
            .alert(
                alertTitle,
                isPresented: $didFail
            ) {
                Button("OK") {
                    // Handle the acknowledgement.
                }
            } message: {
                Text("请检查您的凭据，然后重试。")
            }
    }
}

struct LoginForm: View {
    @Binding var didFail: Bool
    
    var body: some View {
        Button {
            didFail.toggle()
        } label: {
            Text("登录")
        }

    }
}

struct AlertDemo1_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
