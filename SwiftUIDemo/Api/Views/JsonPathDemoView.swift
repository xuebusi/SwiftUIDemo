//
//  JsonPathView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/3/5.
//

import SwiftUI

let jsonString = """
{
    "code":"200",
    "message":"ok",
    "data":{
        "version":"1.0",
        "users":[
            {
                "photos":[
                    {
                        "img":"http://xxx.png"
                    }
                ],
                "profiles":[
                    {
                        "name":"张三",
                        "orders":[
                            {
                                "no":"No1"
                            }
                        ]
                    },
                    {
                        "name":"李四",
                        "orders":[
                            {
                                "no":"No3"
                            }
                        ]
                    }
                ],
                "platform":"web",
                "loginType":"mobile"
            }
        ],
        "news":[
            {
                "title":"aaaa",
                "date":"2023-01-02",
                "content":"djslfjksdljf"
            },
            {
                "title":"bbbb",
                "date":"2019-10-12",
                "content":"djslfjksdljf"
            }
        ]
    }
}
"""

struct JsonPathDemoView: View {
    @State var arrayPaths: [String] = []
    
    var body: some View {
        VStack {
            List {
                ForEach(arrayPaths, id: \.self) { path in
                    Text(path)
                }
            }
        }
        .onAppear {
            arrayPaths = getLeafNodePaths(from: jsonString)
            print(arrayPaths)
        }
    }
}

/// ------------- 方法1 ------------

func getLeafNodePaths(from jsonString: String) -> [String] {
    guard let jsonData = jsonString.data(using: .utf8) else {
        return []
    }
    let json = try! JSON(data: jsonData)
    var leafPaths: [String] = []
    findLeafNodes(in: json, with: "$", result: &leafPaths)
    return leafPaths.sorted()
}

func findLeafNodes(in json: JSON, with path: String, result: inout [String]) {
    switch json.type {
        case .dictionary:
            for (key, subJson) in json {
                let currentPath = path.isEmpty ? key : "\(path).\(key)"
                findLeafNodes(in: subJson, with: currentPath, result: &result)
            }
        case .array:
            if json.count > 0 {
                let subJson = json[0]
                var path = path
                if path.contains("[*]") {
                    path.replace("[*]", with: "[0]")
                }
                let currentPath = path.isEmpty ? "[*]" : "\(path).[*]"
                findLeafNodes(in: subJson, with: currentPath, result: &result)
            }
        default:
            result.append(path)
    }
}

/// ------------- 方法2 ------------

//func getLeafNodePaths(from: String) -> [String] {
//    guard let jsonData = from.data(using: .utf8) else {
//        return []
//    }
//
//    let json = try! JSON(data: jsonData)
//    var paths = [String]()
//
//    getLeafNodePathsHelper(json: json, prefix: "$", paths: &paths)
//
//    return paths.sorted()
//}
//
//private func getLeafNodePathsHelper(json: JSON, prefix: String, paths: inout [String]) {
//    if json.type == .dictionary {
//        for (key, value) in json {
//            getLeafNodePathsHelper(json: value, prefix: "\(prefix).\(key)", paths: &paths)
//        }
//    } else if json.type == .array {
//        if let value = json.arrayValue.first {
//            getLeafNodePathsHelper(json: value, prefix: "\(prefix)[*]", paths: &paths)
//        }
//    } else {
//        paths.append(prefix)
//    }
//}

struct JsonPathDemoView_Previews: PreviewProvider {
    static var previews: some View {
        JsonPathDemoView()
    }
}
