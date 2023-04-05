//
//  NavigationDemoView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/3/2.
//

import SwiftUI

struct NavigationDemoView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    SizeSettingsView()
                } label: {
                    Text("大小设置")
                }
                NavigationLink {
                    BorderSettingsView()
                } label: {
                    Text("边框设置")
                }
                NavigationLink {
                    ColorSettingsView()
                } label: {
                    Text("颜色设置")
                }
            }
            .navigationTitle("设置")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: AddButtonView())
            .navigationBarItems(leading: InfoButtonView())
        }
    }
}

struct SizeSettingsView: View {
    var body: some View {
        List {
            Text("大小设置")
            Text("大小设置")
            Text("大小设置")
        }
        .navigationTitle("大小设置")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: AddButtonView())
    }
}

struct BorderSettingsView: View {
    var body: some View {
        List {
            Text("边框设置")
            Text("边框设置")
            Text("边框设置")
        }
        .navigationTitle("边框设置")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: AddButtonView())
    }
}

struct ColorSettingsView: View {
    var body: some View {
        List {
            Text("颜色设置")
            Text("颜色设置")
            Text("颜色设置")
        }
        .navigationTitle("颜色设置")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: AddButtonView())
    }
}

struct AddButtonView: View {
    var body: some View {
        NavigationLink {
            AddPageView()
        } label: {
            Image(systemName: "plus")
        }
        
    }
}

struct InfoButtonView: View {
    var body: some View {
        NavigationLink {
            InfoPageView()
        } label: {
            Image(systemName: "info.circle")
        }

    }
}

struct InfoPageView: View {
    var body: some View {
        VStack {
            Text("信息页面")
        }
        .navigationTitle("信息页面")
    }
}

struct AddPageView: View {
    var body: some View {
        VStack {
            Text("新增页面")
        }
        .navigationTitle("新增页面")
    }
}

struct NavigationDemoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationDemoView()
    }
}
