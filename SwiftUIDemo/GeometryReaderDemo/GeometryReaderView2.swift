//
//  GeometryReaderView2.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/3/12.
//

import SwiftUI

struct GeometryReaderView2: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<6) { index in
                    GeometryReader { proxy in
                        RoundedRectangle(cornerRadius: 20)
                            .fill(LinearGradient(colors: [.red, .orange], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .shadow(color: .black, radius: 3, x: 0, y: 2)
                            .rotation3DEffect(
                                Angle(degrees: getPercentage(proxy: proxy)*10),
                                axis: (x: 0.0, y: 1.0, z: 0.0))
                            .overlay {
                                Text("\(index)")
                                    .foregroundColor(.white)
                                    .font(.system(.largeTitle, design: .rounded))
                                    .scaleEffect(3)
                                    .shadow(color: .black, radius: 1, x: 2, y: 0)
                            }
                    }
                    .frame(width: 300, height: 250)
                    .padding()
                }
            }
        }
    }
    
    func getPercentage(proxy: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width/2
        let currentX = proxy.frame(in: .global).midX
        print(">>>> maxDistance:\(maxDistance),currentX:\(currentX)")
        return Double(1 - (currentX / maxDistance))
    }
}

struct GeometryReaderView2_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderView2()
    }
}
