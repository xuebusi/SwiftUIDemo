//
//  ScrollView1.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/3.
//

import SwiftUI

struct ScrollViewLongTextView: View {
    // 随机生成一段长文本
    private let longText: String = {
        var content = ""
        for index in 0...100 {
            content += "\(index).\(UUID().uuidString)\n\n"
        }
        return content
    }()
    
    var body: some View {
        Group {
            VStack(alignment: .leading) {
                ScrollView {
                    Text(longText)
                        .font(.system(.caption))
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.cyan)
            .cornerRadius(15)
        }
        .padding()
    }
}

struct ScrollView1_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewLongTextView()
    }
}
