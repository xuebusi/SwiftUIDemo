//
//  AESView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/19.
//

import SwiftUI

struct AESView: View {
    @State var inputText: String = "Hello"
    @State var ciphertext: String = ""
    @State var plaintext: String = ""
    
    var body: some View {
        List {
            Section {
                TextField("请输入一段文字", text: $inputText, axis: .vertical)
            } header: {
                Text("原始字符串")
            }
            
            Section {
                Button {
                    ciphertext = AESManager.encryptString(string: inputText) ?? ""
                    print(">>> 密文:\(ciphertext)")
                } label: {
                    Text("加密")
                }
                Text(ciphertext)
            }
            
            Section {
                Button {
                    plaintext = AESManager.decryptString(encryptedString: ciphertext) ?? ""
                    print(">>> 明文:\(plaintext)")
                } label: {
                    Text("解密")
                }
                Text(plaintext)
            }
        }
        .onAppear {
            print(">>> \(AESManager.AES_KEY)")
        }
    }
}

struct AESView_Previews: PreviewProvider {
    static var previews: some View {
        AESView()
    }
}
