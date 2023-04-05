//
//  RoundedRectView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/3/11.
//

import SwiftUI

struct RoundedRectView: View {
    var body: some View {
        VStack {
            CircleShapeView()
        }
    }
}

struct RectShape2View: View {
    var body: some View {
        ZStack {
            RectShape2()
                .fill(.red)
                .frame(width: 300, height: 200)
        }
    }
}

struct RectangleView: View {
    var body: some View {
        ZStack {
            RectangleShape()
                .fill(.green)
                .frame(width: 300, height: 200)
        }
    }
}

struct RoundedRectShapeView: View {
    var body: some View {
        ZStack {
            RoundedRectShape()
                .fill(.orange)
                .frame(width: 300, height: 200)
        }
    }
}

struct CircleShapeView: View {
    var body: some View {
        ZStack {
            CircleShape()
                .fill(.blue)
                .frame(width: 300, height: 300)
                .border(.red, width: 1)
        }
    }
}

struct TriangleShapeView: View {
    var body: some View {
        ZStack {
            TriangleShape()
                .fill(.cyan)
                .frame(width: 300, height: 300)
        }
    }
}

struct RectangleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        return path
    }
}

struct RectShape2: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRect(CGRect(origin: CGPoint(x: rect.origin.x, y: rect.origin.y),
                            size: CGSize(width: rect.width, height: rect.height)))
        return path
    }
}

struct RoundedRectShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(in: CGRect(origin: CGPoint(x: rect.origin.x, y: rect.origin.y), size: CGSize(width: rect.width, height: rect.height)), cornerSize: CGSize(width: rect.width/8, height: rect.width/8))
        return path
    }
}


struct TriangleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
}

struct CircleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: min(rect.width, rect.height)/2, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
        return path
    }
}

struct RoundedRectView_Previews: PreviewProvider {
    static var previews: some View {
        RoundedRectView()
    }
}
