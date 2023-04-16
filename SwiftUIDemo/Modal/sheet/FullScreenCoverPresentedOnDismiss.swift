//
//  FullScreenCoverPresentedOnDismiss.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/6.
//

import SwiftUI

struct FullScreenCoverPresentedOnDismiss: View {
    @State private var isPresenting = false
    var body: some View {
        Button("点击全屏显示") {
            isPresenting.toggle()
        }
        .fullScreenCover(isPresented: $isPresenting, onDismiss: didDismiss) {
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Button {
                        isPresenting = false
                    } label: {
                        Image(systemName: "multiply.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.black)
                            .frame(width: 35, height: 35)
                    }
                }
                .padding()
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                
                VStack {
                    Text("全屏模态视图")
                        .font(.title)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.cyan)
            .ignoresSafeArea(edges: .all)
        }
    }
    
    func didDismiss() {
        // Handle the dismissing action.
    }
}

struct FullScreenCoverPresentedOnDismiss_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenCoverPresentedOnDismiss()
    }
}
