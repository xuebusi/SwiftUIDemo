//
//  WatchView2.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/3/12.
//

import SwiftUI

struct WatchView2: View {
    @State var currentTime = Date()
    
    // 设定时间刷新的定时器，每秒钟更新一次currentTime
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            // 绘制表盘和刻度线
            Circle()
                .stroke(lineWidth: 3)
                .foregroundColor(.black)
            ForEach(0..<60) { tick in
                Rectangle()
                    .fill(Color.black)
                    .frame(width: 1, height: 5)
                    .offset(y: 100)
                    .rotationEffect(.degrees(Double(tick) / 60.0 * 360.0))
            }
            // 绘制时针、分针和秒针
            ClockHand(rotationAngle: .degrees(Double(Calendar.current.component(.hour, from: currentTime)) / 12.0 * 360.0))
                .stroke(lineWidth: 6)
                .foregroundColor(.orange)
                .rotationEffect(.degrees(-90))  // 旋转手表初始方向为12点位置
                .rotationEffect(.degrees(Double(Calendar.current.component(.minute, from: currentTime))) / 60.0 * 360.0)
            ClockHand(rotationAngle: .degrees(Double(Calendar.current.component(.minute, from: currentTime)) / 60.0 * 360.0))
                .stroke(lineWidth: 3)
                .foregroundColor(.gray)
                .rotationEffect(.degrees(-90))
            ClockHand(rotationAngle: .degrees(Double(Calendar.current.component(.second, from: currentTime)) / 60.0 * 360.0))
                .stroke(lineWidth: 1)
                .foregroundColor(.red)
                .rotationEffect(.degrees(-90))
        }
        .padding(30)
        .frame(width: 270, height: 270, alignment: .center)
        .onReceive(timer) { input in  // 每秒更新currentTime值
            self.currentTime = input
        }
    }
}

struct ClockHand: Shape {
    var rotationAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let length = min(rect.width, rect.height) / 2 * 0.6
        let endPoint = CGPoint(x: center.x + length * cos(CGFloat(rotationAngle.radians)), y: center.y + length * sin(CGFloat(rotationAngle.radians)))
        var path = Path()
        path.move(to: center)
        path.addLine(to: endPoint)
        return path
    }
}

struct WatchView2_Previews: PreviewProvider {
    static var previews: some View {
        WatchView2()
    }
}
