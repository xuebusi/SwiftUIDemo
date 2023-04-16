//
//  DictManager.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/14.
//

import Foundation

struct DictManager<T> {
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    // 从UserDefaults中获取字典
    func getDictionary<T:Decodable>(forKey key: String) -> [String: T]? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [:] }
        do {
            return try JSONDecoder().decode([String: T].self, from: data)
        } catch {
            print(error)
        }
        return [:]
    }
    
    // 将字典保存到UserDefaults中
    func setDictionary<T:Encodable>(_ dictionary: [String: T], forKey key: String) {
        do {
            let data = try JSONEncoder().encode(dictionary)
            userDefaults.set(data, forKey: key)
            userDefaults.synchronize()
        } catch {
            print(error)
        }
    }
    
    // 从UserDefaults中删除字典
    func removeDictionary(forKey key: String) {
        userDefaults.removeObject(forKey: key)
        userDefaults.synchronize()
    }
    
    // 从字典中获取值
    func getValue(forKey key: String, fromDictionary dictionary: [String: T]) -> T? {
        return dictionary[key]
    }
    
    // 在字典中设置值
    func setValue(_ value: T, forKey key: String, inDictionary dictionary: inout [String: T]) {
        dictionary[key] = value
    }
}
