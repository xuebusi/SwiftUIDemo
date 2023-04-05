//
//  AsyncImageViwe.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/2/27.
//

import SwiftUI

struct AsyncImageViwe: View {
    let url = URL(string: "https://picsum.photos/300")
    
    var body: some View {
        VStack {
            // 异步加载图片
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .cornerRadius(150)
                        .overlay {
                            Circle()
                                .stroke(lineWidth: 4)
                                .foregroundColor(.white)
                        }
                        .shadow(color: .black.opacity(0.2), radius: 2, x: 2, y: 2)
                case .failure:
                    Image(systemName: "questionmark")
                        .font(.headline)
                default:
                    Image(systemName: "questionmark")
                        .font(.headline)
                }
            }
        }
    }
}

struct AsyncImageViwe_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageViwe()
    }
}
