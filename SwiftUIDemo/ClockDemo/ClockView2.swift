//
//  ClockView2.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/3/15.
//

import SwiftUI
import AVFoundation

struct ClockView2: View {
    // 记录当前时间
    @State var time: Date = Date()
    // 当前小时数
    @State var hour = Calendar.current.component(.hour, from: Date())
    // 当前分钟数
    @State var minute = Calendar.current.component(.minute, from: Date())
    // 当前秒数
    @State var second = Calendar.current.component(.second, from: Date())
    // 日期格式化器
    let formatter = DateFormatter()
    // 定时器，每秒执行一次
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    
    let shadowColor: Color = .gray
    
    // 播放器实例
    @State private var player: AVAudioPlayer?
    @State private var isOpened: Bool = false
    
    var body: some View {
        // 计算时针、分针和秒针的旋转角度
        let secondAngle = Angle.degrees(Double(second)*6)
        let minuteAngle = Angle.degrees(Double(minute)*6 + Double(second)*0.1)
        let hourAngle = Angle.degrees(Double(hour)*30 + Double(minute)*0.5 + Double(second)*0.0083)
        
        ZStack {
            // 黑色背景
            Color.black.ignoresSafeArea()
            VStack {
                ZStack {
                    // 钟表圆盘
                    Circle()
                        .fill(Color.white)
                        .overlay {
                            Circle().stroke(.orange, lineWidth: 6)
                        }
                        .overlay {
                            Text(currentTimeString())
                                .foregroundColor(Color.black)
                                .font(.system(.headline))
                                .position(x: 150, y: 220)
                                .shadow(color: shadowColor, radius: 1, x: 1, y: 1)
                        }
                    // 数字
                    ClockNumbers()
                        .foregroundColor(Color.black)
                        .font(.system(.title, design: .rounded))
                        .shadow(color: shadowColor, radius: 1, x: 2, y: 1)
                    // 时针
                    MyHand(offSet: -75)
                        .fill(Color.black)
                        .frame(width: 6, height: 50)
                        .rotationEffect(hourAngle)
                        .shadow(color: shadowColor, radius: 1, x: 2, y: 2)
                    // 分针
                    MyHand(offSet: -85)
                        .fill(Color.black)
                        .frame(width: 4, height: 70)
                        .rotationEffect(minuteAngle)
                        .shadow(color: shadowColor, radius: 1, x: 2, y: 2)
                    // 秒针
                    MyHand(offSet: -95)
                        .fill(Color.red)
                        .frame(width: 1, height: 80)
                        .rotationEffect(secondAngle)
                        .shadow(color: shadowColor, radius: 1, x: 2, y: 2)
                    // 中心点
                    Circle()
                        .fill(Color.red)
                        .frame(width: 10, height: 10)
                }
                .onAppear {
                    // 加载本地音频
                    guard let url = Bundle.main.url(forResource: "clock", withExtension: "mp3") else { return }
                    // 初始化AVAudioPlayer
                    player = try? AVAudioPlayer(contentsOf: url)
                }
                .onReceive(timer) { _ in
                    // 使用定时器刷新时间
                    self.time = Date()
                    self.hour = Calendar.current.component(.hour, from: time)
                    self.minute = Calendar.current.component(.minute, from: time)
                    self.second = Calendar.current.component(.second, from: time)
                    
                    // 播放
                    if isOpened {
                        player?.play()
                    }
                }
                .frame(width: 300, height: 300)
                
                HStack {
                    Spacer()
                    // 小喇叭按钮
                    Button {
                        isOpened.toggle()
                        if isOpened {
                            player?.play()
                        } else {
                            player?.stop()
                        }
                    } label: {
                        // 小喇叭图标
                        Image(systemName: isOpened ? "speaker.wave.2.circle.fill" : "speaker.slash.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color.white)
                            .frame(width: 20)
                            .opacity(0.5)
                    }

                }
                .frame(width: 300)
            }
        }
    }
    
    // 时间格式化
    func currentTimeString() -> String {
        formatter.dateFormat = "HH:mm:ss"
        formatter.timeZone = TimeZone(identifier: "Asia/Shanghai")
        return formatter.string(from: self.time)
    }
}

// 绘制钟表表针
struct MyHand: Shape {
    var offSet: CGFloat = 0
    func path(in rect: CGRect) -> Path {
        var path = Path()
        // 使用圆角矩形绘制表针
        path.addRoundedRect(
            in: CGRect(origin: CGPoint(x: rect.origin.x, y: rect.origin.y + offSet),
                       size: CGSize(width: rect.width, height: rect.height/2 - offSet)),
            cornerSize: CGSize(width: rect.width/2, height: rect.width/2)
        )
        return path
    }
}

// 钟表上的12个数字
struct ClockNumbers: View {
    var body: some View {
        ZStack{
            ForEach(1..<13) { hour in
                ClockNumber(hour: hour)
            }
        }
    }
}

struct ClockNumber: View {
    var hour: Int
    var body: some View {
        VStack {
            Text("\(hour)")
                // 将倾斜的数字取负值进行摆正
                .rotationEffect(.radians(-(Double.pi*2 / 12 * Double(hour))))
            Spacer()
        }
        .padding()
        // 设置数字的旋转弧度，此时所有数字的尾部都会指向钟表的圆心
        .rotationEffect(.radians( (Double.pi*2 / 12 * Double(hour))))
    }
}

struct ClockView2_Previews: PreviewProvider {
    static var previews: some View {
        ClockView2()
    }
}
