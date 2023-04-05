//
//  GeometryReaderView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/3/12.
//

import SwiftUI

struct GeometryReaderView: View {
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                // 红色矩形，高度占屏幕高度的1/3
                Rectangle()
                    .fill(.red)
                    // 使用proxy获取VStack视图的高度
                    .frame(height: proxy.size.height/3)
                // 绿色矩形
                Rectangle()
                    .fill(.green)
            }
            .ignoresSafeArea()
        }
    }
}

struct GeometryReaderView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderView()
    }
}
