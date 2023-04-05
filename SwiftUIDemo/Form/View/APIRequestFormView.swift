//
//  APIRequestFormView.swift
//  LinkAPI
//
//  Created by shiyanjun on 2023/3/25.
//

import SwiftUI

struct APIRequestFormView: View {
    @StateObject var vm = APIFormViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                // 背景渐变
                LinearGradient(colors: [.white, .orange, .yellow, .green, .green, .orange, .yellow, .black],
                               startPoint: .topLeading, endPoint: .bottomTrailing)
                    .opacity(0.1)
                    .blur(radius: 50)
                    .ignoresSafeArea()
                
                // 表单页面
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 28) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("接口名称")
                                .padding(.leading, 5)
                                .font(.system(.callout))
                                .foregroundColor(.gray)
                            TextField("请输入接口名称", text: $vm.name)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("接口URL")
                                .padding(.leading, 5)
                                .font(.system(.callout))
                                .foregroundColor(.gray)
                            TextField("请输入接口URL", text: $vm.url)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("请求方式")
                                .padding(.leading, 5)
                                .font(.system(.callout))
                                .foregroundColor(.gray)
                            Picker("", selection: $vm.method) {
                                Text("GET").tag("GET")
                                Text("POST").tag("POST")
                                Text("PUT").tag("PUT")
                                Text("DELETE").tag("DELETE")
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("请求Body")
                                .padding(.leading, 5)
                                .font(.system(.callout))
                                .foregroundColor(.gray)
                            TextField("请输入Body", text: $vm.requestBody, axis: .vertical)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("路径参数")
                                .padding(.leading, 5)
                                .font(.system(.callout))
                                .foregroundColor(.gray)
                            ForEach(vm.params.indices, id: \.self) { index in
                                HStack {
                                    TextField("Key", text: self.$vm.params[index].key)
                                        .padding()
                                        .background(Color.gray.opacity(0.1))
                                        .cornerRadius(10)
                                    
                                    TextField("Value", text: self.$vm.params[index].value)
                                        .padding()
                                        .background(Color.gray.opacity(0.1))
                                        .cornerRadius(10)
                                    
                                    Button {
                                        vm.params.remove(at: index)
                                    } label: {
                                        Image(systemName: "minus.circle.fill")
                                            .foregroundColor(.red)
                                    }
                                    .foregroundColor(.red)
                                }
                                .padding(.bottom, 10)
                            }
                            
                            Button(action: {
                                vm.params.append(Param(key: "", value: ""))
                            }, label: {
                                Text("添加路径参数")
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue.opacity(0.1))
                                    .cornerRadius(10)
                                    .overlay {
                                        Image(systemName: "plus.circle.fill")
                                            .foregroundColor(.green)
                                            .offset(x: -65)
                                    }
                            })
                        }
                        VStack(alignment: .leading, spacing: 8) {
                            Text("请求头")
                                .padding(.leading, 5)
                                .font(.system(.callout))
                                .foregroundColor(.gray)
                            ForEach(vm.headers.indices, id: \.self) { index in
                                HStack {
                                    TextField("Key", text: self.$vm.headers[index].key)
                                        .padding()
                                        .background(Color.gray.opacity(0.1))
                                        .cornerRadius(10)
                                    
                                    TextField("Value", text: self.$vm.headers[index].value)
                                        .padding()
                                        .background(Color.gray.opacity(0.1))
                                        .cornerRadius(10)
                                    
                                    Button {
                                        vm.headers.remove(at: index)
                                    } label: {
                                        Image(systemName: "minus.circle.fill")
                                            .foregroundColor(.red)
                                    }
                                    .foregroundColor(.red)
                                }
                                .padding(.bottom, 10)
                            }
                            
                            Button(action: {
                                vm.headers.append(Header(key: "", value: ""))
                            }, label: {
                                Text("添加请求头")
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue.opacity(0.1))
                                    .cornerRadius(10)
                                    .overlay {
                                        Image(systemName: "plus.circle.fill")
                                            .foregroundColor(.green)
                                            .offset(x: -56)
                                    }
                            })
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("备注信息")
                                .padding(.leading, 5)
                                .font(.system(.callout))
                                .foregroundColor(.gray)
                            TextField("请输入备注信息", text: $vm.description, axis: .vertical)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            // 模拟接口响应
                            vm.apiResult = "{\"name\":\"张三\", \"age\":25}"
                        }, label: {
                            Text("发送请求")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(10)
                                .overlay {
                                    Image(systemName: "paperplane.circle.fill")
                                        .foregroundColor(.green)
                                        .offset(x: -50)
                                }
                        })
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("请求结果")
                                .padding(.leading, 5)
                                .font(.system(.callout))
                                .foregroundColor(.gray)
                            Text(vm.apiResult.isEmpty ? "此处显示接口返回的结果" : vm.apiResult)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .frame(height: 200)
                                .foregroundColor(.gray)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                        }
                        .padding(.bottom, 30)
                    }
                }
                .padding(.horizontal, 15)
                .fontWeight(.light)
                .navigationTitle("创建接口")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        // 解决在iPad上视图被折叠问题
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

class APIFormViewModel: ObservableObject {
    // 接口名称
    @Published var name = ""
    // 请求URL
    @Published var url = ""
    // 请求方式
    @Published var method = "GET"
    @Published var requestBody = ""
    // 接口备注
    @Published var description = ""
    // 路径参数
    @Published var params: [Param] = []
    // 请求头
    @Published var headers: [Header] = []
    // 接口响应
    @Published var apiResult = ""
}

struct Param: Identifiable, Hashable, Codable {
    var id = UUID()
    var key: String = ""
    var value: String = ""
    var description: String = ""
}

struct Header: Identifiable, Hashable, Codable {
    var id = UUID()
    var key: String = ""
    var value: String = ""
    var description: String = ""
}

struct APIRequestFormDemoView_Previews: PreviewProvider {
    static var previews: some View {
        APIRequestFormView()
    }
}
