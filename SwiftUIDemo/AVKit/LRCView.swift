//
//  LRCView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/3/17.
//

import SwiftUI

struct LRCView: View {
    let lrcs: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    @State var currentNumber = 0
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            VStack(spacing: 10) {
                ForEach(lrcs, id: \.self) { lrc in
                    Text("\(lrc)")
                        .foregroundColor(self.currentNumber == lrc ? .red : .black)
                }
            }
        }
        .onReceive(timer) { _ in
            if currentNumber != lrcs.count {
                currentNumber += 1
            } else {
                currentNumber = 1
            }
        }
    }
}

struct LRCView_Previews: PreviewProvider {
    static var previews: some View {
        LRCView()
    }
}
