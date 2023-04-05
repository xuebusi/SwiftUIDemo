//
//  ClockDemoView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/3/8.
//

import SwiftUI

struct ClockDemoView: View {
    @State private var currentTime = Date()
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Text("当前时间是：")
            Text(currentTime, style: .time)
                .font(.largeTitle)
        }
        .onReceive(timer) { _ in
            updateTime()
        }
    }

    func updateTime() {
        currentTime = Date()
    }
}

struct ClockDemoView_Previews: PreviewProvider {
    static var previews: some View {
        ClockDemoView()
    }
}
