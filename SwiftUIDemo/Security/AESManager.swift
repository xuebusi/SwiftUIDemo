//
//  AESManager.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/19.
//

import Foundation
import CryptoKit

class AESManager {
    // AES密钥
    var key: String = ""
    
    init() {
        // 初始化对称密钥
        self.key = generateKey()
    }
    
    // 随机生成对称密钥
    func generateKey() -> String {
        let key = SymmetricKey(size: .bits256)
        let base64EncodedKey = key.withUnsafeBytes {
            Data($0).base64EncodedString()
        }
        print("生成随机密钥: \(base64EncodedKey)")
        return base64EncodedKey
    }
    
    // 加密：输入明文，返回密文
    func encrypt(string: String?) -> String? {
        guard let data = string?.data(using: .utf8) else {
            return nil
        }
        guard let keyBytes = Data(base64Encoded: key) else {
            return nil
        }
        let key = SymmetricKey(data: keyBytes)
        guard let sealedBox = try? AES.GCM.seal(data, using: key) else {
            return nil
        }
        guard let encryptedData = sealedBox.combined else {
            return nil
        }
        return encryptedData.base64EncodedString()
    }
    
    // 解密：输入密文，返回明文
    func decrypt(encryptedString: String?) -> String? {
        guard let encryptedData = Data(base64Encoded: encryptedString ?? "") else {
            return nil
        }
        guard let sealedBox = try? AES.GCM.SealedBox(combined: encryptedData) else {
            return nil
        }
        guard let keyBytes = Data(base64Encoded: key) else {
            return nil
        }
        let key = SymmetricKey(data: keyBytes)
        guard let decryptedData = try? AES.GCM.open(sealedBox, using: key) else {
            return nil
        }
        let decryptedString = String(data: decryptedData, encoding: .utf8)!
        return decryptedString
    }
}
