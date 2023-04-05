//
//  ClockDemoView2.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/3/13.
//

import SwiftUI

struct ClockDemoView2: View {
    var body: some View {
        ZStack {
            // 黑色背景
            Color.black.ignoresSafeArea()
            HStack {
                ClockView()
                Spacer()
            }
            .frame(width: 300)
        }
    }
}

struct ClockView: View {
    // 当前时间
    @State private var currentTime = Date()
    // 启动一个定时器，每秒执行一次
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    // 时期格式化对象
    let formatter = DateFormatter()
    
    var body: some View {
        Text(currentTimeString())
            .font(.system(size: 70, design: .rounded))
            .foregroundColor(.orange)
            .onReceive(timer) { _ in
                // 使用定时器更新当前时间
                self.currentTime = Date()
            }
    }
    
    // 将日期格式化为HH:mm:ss
    func currentTimeString() -> String {
        formatter.dateFormat = "HH:mm:ss"
        // 使用北京时区
        formatter.timeZone = TimeZone(identifier: "Asia/Shanghai")
        return formatter.string(from: self.currentTime)
    }
}

struct ClockDemoView2_Previews: PreviewProvider {
    static var previews: some View {
        ClockDemoView2()
    }
}
