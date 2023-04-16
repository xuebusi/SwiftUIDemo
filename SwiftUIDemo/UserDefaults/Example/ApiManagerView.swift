//
//  DictOperationView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/14.
//

import SwiftUI

struct ApiManagerView: View {
    @StateObject var vm = ApiDictViewModel()
    @State var folder: String = "SwiftUI"
    @State var apiName: String = "A"
    @State var apiUrl: String = "http://baidu.com"
    @State var apiMethod: String = "GET"
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("接口名称", text: $apiName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("接口地址", text: $apiUrl)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("请求方式", text: $apiMethod)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button {
                    vm.saveApi(Api(folder: folder, name: apiName, url: apiUrl, method: apiMethod))
                } label: {
                    Text("保存")
                        .padding(10)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(BorderedButtonStyle())
                
                Divider()
                
                NavigationLink {
                    ApiDictListView()
                } label: {
                    Text("接口列表")
                        .padding(10)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding()
            .navigationTitle("字典操作")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct ApiDictListView: View {
    @StateObject var vm = ApiDictViewModel()
    
    var body: some View {
        List {
            ForEach(vm.apiList, id: \.id) { api in
                NavigationLink {
                    ApiDictDetailView(api: api)
                } label: {
                    Text("name:\(api.name)")
                }
            }
        }
        .onAppear {
            vm.loadApis()
        }
    }
}

struct ApiDictDetailView: View {
    @State var api: Api
    
    var body: some View {
        List {
            Text("id:\(api.id)")
            Text("folder:\(api.folder)")
            Text("name:\(api.name)")
            Text("method:\(api.method)")
            Text("url:\(api.url)")
        }
    }
}

struct DictOperationView_Previews: PreviewProvider {
    static var previews: some View {
        ApiManagerView()
    }
}
