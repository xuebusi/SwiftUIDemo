//
//  DictViewModel.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/14.
//

import Foundation

class ApiDictViewModel: ObservableObject {
    @Published var apiList: [Api] = []
    
    private let API_LIST_KEY: String = "apiDict"
    private let ud = DictManager<[Api]>()
    
    func saveApi(_ api: Api) {
        // 查询API字典
        var dict: [String: [Api]] = ud.getDictionary(forKey: API_LIST_KEY) ?? [:]
        
        // 从字段中查询API目录
        var folderApis: [Api] = dict[api.folder] ?? []
        folderApis.append(api)
        
        // 放回字典
        dict[api.folder] = folderApis
        
        // 保存字典
        ud.setDictionary(dict, forKey: API_LIST_KEY)
        
        loadApis()
    }
    
    func loadApis() {
        guard let dict: [String: [Api]] = ud.getDictionary(forKey: API_LIST_KEY) else {
            return
        }
        
        var folderApis: [Api] = []
        for (_,v) in dict {
            for api in v {
                folderApis.append(api)
            }
        }
        apiList = folderApis
    }
}
