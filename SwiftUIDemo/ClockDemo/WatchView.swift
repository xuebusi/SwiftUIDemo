//
//  WatchView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/3/8.
//

import SwiftUI

struct WatchView: View {
    @State var date:Date = Date()
    
    init() {
        let seconds = Calendar.current.component(.second, from: Date())
        let minutes = Calendar.current.component(.minute, from: Date())
        let hours = Calendar.current.component(.hour, from: Date())
        print(">>>> seconds:\(seconds)")
        print(">>>> minutes:\(minutes)")
        print(">>>> hours:\(hours)")
    }
    
    var body: some View {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.hour, .minute, .second], from: date)
        
        // Convert Date to angle
        var minuteAngle:Double = 0
        var hourAngle:Double = 0
        var secondAngle: Double = 0
        
        
        if let hour =  dateComponents.hour,
           let minute = dateComponents.minute,
           let second = dateComponents.second {
            
            let radianInOneHour = 2 * Double.pi / 12
            let radianInOneMinute = 2 * Double.pi / 60
            
            minuteAngle = Double(minute) * radianInOneMinute
            
            let actualHour = Double(hour) + (Double(minute)/60)
            
            hourAngle = actualHour * radianInOneHour
            
            secondAngle = Double(second) * radianInOneMinute
        }
        
        return ZStack {
            Circle()
                .fill(Color.white)
            Arc()
                .stroke(lineWidth: 8)
            
            Ticks()
            Numbers()
                .font(.system(.largeTitle, design: .rounded))
            
            // 黑色圆点
            Circle()
                .fill()
                .frame(width: 15, height: 15, alignment: .center)
            // 时针
            Hand(offSet: 50)
                .fill()
                .frame(width: 4, alignment: .center)
                .rotationEffect(.radians(hourAngle))
            
            // 分针
            Hand(offSet: 16)
                .fill()
                .frame(width: 3, alignment: .center)
                .rotationEffect(.radians(minuteAngle))
            
            // 秒针
            Hand(offSet: 10)
                .fill()
                .foregroundColor(.red)
                .frame(width: 2, alignment: .center)
                .rotationEffect(.radians(secondAngle))
            
            // 红色圆点
            Circle()
                .fill()
                .foregroundColor(.red)
                .frame(width: 7, height: 7, alignment: .center)
        }
        .frame(width: 300, height: 300, alignment: .center)
        .onAppear {
            start()
        }
    }
    
    func start() {
        Timer.scheduledTimer(withTimeInterval: 1 /*3*/, repeats: true) { _ in
            self.date = Date()
            
            //             withAnimation(.spring()) {
            //             self.date = Date()
            //             }
            
        }
    }
}

struct Arc: Shape {
    
    var startAngle: Angle = .radians(0)
    var endAngle: Angle = .radians(Double.pi * 2)
    var clockWise: Bool = true
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width/2, rect.height/2)
        
        path.addArc(center:  center, radius: radius , startAngle: startAngle, endAngle: endAngle, clockwise: clockWise)
        return path
    }
}

struct Circle:  Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addEllipse(in: rect)
        return path
    }
}

struct Hand: Shape {
    var offSet: CGFloat = 0
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(
            in: CGRect(origin: CGPoint(x: rect.origin.x, y: rect.origin.y + offSet),
                       size: CGSize(width: rect.width, height: rect.height/2 - offSet)),
            cornerSize: CGSize(width: rect.width/2, height: rect.width/2)
        )
        return path
    }
}

struct Ticks: View {
    var body: some View {
        ZStack {
            ForEach(0..<60) { position in
                Tick(isLong: position % 5 == 0)
                    .stroke(lineWidth: position % 5 == 0 ? 3 : 2)
                    .rotationEffect(.radians(Double.pi*2 / 60 * Double(position)))
                
            }
        }
    }
}

struct Tick: Shape {
    var isLong: Bool = false
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x:rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x:rect.midX, y: rect.minY + 6 + (isLong ? 8 : 2) ))
        return path
    }
}

struct Numbers: View {
    var body: some View {
        ZStack{
            ForEach(1..<13) { hour in
                Number(hour: hour)
            }
            
        }
    }
}

struct Number: View {
    var hour: Int
    var body: some View {
        VStack {
            Text("\(hour)").fontWeight(.bold)
                .rotationEffect(.radians(-(Double.pi*2 / 12 * Double(hour))))
            Spacer()
        }
        .padding()
        .rotationEffect(.radians( (Double.pi*2 / 12 * Double(hour))))
    }
}

struct WatchView_Previews: PreviewProvider {
    static var previews: some View {
        WatchView()
    }
}
