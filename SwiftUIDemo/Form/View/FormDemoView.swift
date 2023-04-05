//
//  HomeListView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/2/27.
//

import SwiftUI

struct FormDemoView: View {
    var body: some View {
        NavigationStack {
            NavigationLink {
                FormCreateView()
            } label: {
                Text("创建表单")
            }
            .navigationTitle("创建表单")
        }
    }
}

struct HomeListView_Previews: PreviewProvider {
    static var previews: some View {
        FormDemoView()
    }
}
