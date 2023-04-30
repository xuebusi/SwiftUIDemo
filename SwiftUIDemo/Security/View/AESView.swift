//
//  AESView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/19.
//

import SwiftUI
import CryptoKit

struct AESView: View {
    // AES管理实例
    private let manager: AESManager = AESManager()
    // 输入文本
    @State var inputText: String = "Hello SwiftUI!"
    // 密文
    @State var cipherText: String = ""
    // 明文
    @State var plainText: String = ""
    
    var body: some View {
        List {
            Section {
                TextField("请输入要加密的字符串", text: $inputText, axis: .vertical)
            } header: {
                Text("原始字符串")
            } footer: {
                Text(inputText == "" ? "字符串不能为空" : "")
                    .foregroundColor(.red)
            }
            
            Section {
                Text(manager.key)
            } header: {
                Text("AES密钥")
            }
            
            Section {
                Button {
                    if inputText == "" { return }
                    // 加密
                    cipherText = manager.encrypt(string: inputText) ?? ""
                } label: {
                    Text("加密")
                }
                .buttonStyle(BorderedProminentButtonStyle())
                Text(cipherText)
            }
            
            Section {
                Button {
                    if inputText == "" { return }
                    // 解密
                    plainText = manager.decrypt(encryptedString: cipherText) ?? ""
                } label: {
                    Text("解密")
                }
                .buttonStyle(BorderedProminentButtonStyle())
                Text(plainText)
            }
        }
    }
}

// 效果预览
struct AESView_Previews: PreviewProvider {
    static var previews: some View {
        AESView()
    }
}
