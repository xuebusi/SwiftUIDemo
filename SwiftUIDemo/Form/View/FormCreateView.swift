//
//  FormCreateView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/2/27.
//

import SwiftUI

struct FormCreateView: View {
    @StateObject var vm = FormCreateViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("表单类型", selection: $vm.compType) {
                        ForEach(FormType.allCases, id: \.self) { type in
                            Text(type.rawValue)
                        }
                    }
                    .onChange(of: vm.compType) { newValue in
                        vm.compType = newValue
                        print("你选择的表单类型：\(vm.compType.rawValue)")
                    }
                }
                
                // 根据选择的组件类型显示不同的表单字段
                switch vm.compType {
                case .Arcticle:
                    // 展示文章组件对应的表单字段
                    ArticleFormCreateView()
                case .Photo:
                    // 展示图片组件对应的表单字段
                    PhotoFormCreteView()
                case .Chart:
                    // 展示图表组件对应的表单字段
                    ChartFormCreateView()
                }
            }
            .navigationTitle("创建表单")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: FormSaveButtonView())
        }
        .environmentObject(vm)
    }
}

// 保存按钮
struct FormSaveButtonView: View {
    @EnvironmentObject var vm: FormCreateViewModel
    
    var body: some View {
        NavigationStack {
            NavigationLink {
                FormSaveSuccessView()
                    .environmentObject(vm)
            } label: {
                Text("保存")
            }
        }
    }
}

// 组件保存成功页面
struct FormSaveSuccessView: View {
    @EnvironmentObject var vm: FormCreateViewModel
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 20) {
                Text("创建成功！")
                    .padding()
                Divider()
                VStack(alignment: .leading, spacing: 10) {
                    // 不同的组件类型展示不同字段信息
                    switch vm.compType {
                    case .Arcticle:
                        Text("表单ID：\(vm.articleForm.id)")
                        Text("表单名称：\(vm.articleForm.name)")
                        Text("表单类型：\(vm.articleForm.type.rawValue)")
                        Text("文章标题：\(vm.articleForm.title)")
                    case .Photo:
                        Text("表单ID：\(vm.photoForm.id)")
                        Text("表单名称：\(vm.photoForm.name)")
                        Text("表单类型：\(vm.photoForm.type.rawValue)")
                        Text("图片URL：\(vm.photoForm.url)")
                    case .Chart:
                        Text("表单ID：\(vm.chartForm.id)")
                        Text("表单名称：\(vm.chartForm.name)")
                        Text("表单类型：\(vm.chartForm.type.rawValue)")
                        Text("图表x轴：\(vm.chartForm.x)")
                        Text("图表y轴：\(vm.chartForm.y)")
                    }
                }
                .padding()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .navigationTitle("表单信息")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// 创建文章组件子视图
struct ArticleFormCreateView: View {
    @EnvironmentObject var vm: FormCreateViewModel
    
    var body: some View {
        Section {
            TextField("", text: $vm.articleForm.name)
        } header: {
            Text("表单名称")
        }
        Section {
            TextField("", text: $vm.articleForm.title)
        } header: {
            Text("文章标题")
        }
    }
}

// 创建图片组件表单子视图
struct PhotoFormCreteView: View {
    @EnvironmentObject var vm: FormCreateViewModel
    
    var body: some View {
        Section {
            TextField("", text: $vm.photoForm.name)
        } header: {
            Text("表单名称")
        }
        Section {
            TextField("", text: $vm.photoForm.url)
        } header: {
            Text("图片URL")
        }
    }
}

// 创建图表组件子视图
struct ChartFormCreateView: View {
    @EnvironmentObject var vm: FormCreateViewModel
    
    var body: some View {
        Section {
            TextField("", text: $vm.chartForm.name)
        } header: {
            Text("表单名称")
        }
        Section {
            TextField("", text: $vm.chartForm.x)
        } header: {
            Text("x轴")
        }
        Section {
            TextField("", text: $vm.chartForm.y)
        } header: {
            Text("y轴")
        }
    }
}
struct FormCreateView_Previews: PreviewProvider {
    static var previews: some View {
        FormCreateView()
    }
}
