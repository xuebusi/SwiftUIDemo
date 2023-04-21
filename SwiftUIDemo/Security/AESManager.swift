//
//  AESManager.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/19.
//

import Foundation
import CryptoKit

class AESManager {
    public static let AES_KEY = generateAESKey()
    
    private init() {
        
    }
    
    // 生成密钥函数
    private static func generateAESKey() -> String {
        let key = SymmetricKey(size: .bits256)
        let base64EncodedKey = key.withUnsafeBytes {
            Data($0).base64EncodedString()
        }
        print("Base64 encoded key: \(base64EncodedKey)")
        return base64EncodedKey
    }
    
    // 加密字符串函数
    static func encryptString(string: String?) -> String? {
        guard let data = string?.data(using: .utf8) else {
            return nil
        }
        guard let keyBytes = Data(base64Encoded: AES_KEY) else {
            return nil
        }
        print(">>> AES_KEY:\(AES_KEY)")
        let key = SymmetricKey(data: keyBytes)
        guard let sealedBox = try? AES.GCM.seal(data, using: key) else {
            return nil
        }
        guard let encryptedData = sealedBox.combined else {
            return nil
        }
        return encryptedData.base64EncodedString()
    }
    
    // 解密字符串函数
    static func decryptString(encryptedString: String?) -> String? {
        guard let encryptedData = Data(base64Encoded: encryptedString ?? "") else {
            return nil
        }
        guard let sealedBox = try? AES.GCM.SealedBox(combined: encryptedData) else {
            return nil
        }
        guard let keyBytes = Data(base64Encoded: AES_KEY) else {
            return nil
        }
        print(">>> AES_KEY:\(AES_KEY)")
        let key = SymmetricKey(data: keyBytes)
        guard let decryptedData = try? AES.GCM.open(sealedBox, using: key) else {
            return nil
        }
        let decryptedString = String(data: decryptedData, encoding: .utf8)!
        return decryptedString
    }
}
