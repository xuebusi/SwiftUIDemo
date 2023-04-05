//
//  ImageAdjustDemo.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/3/9.
//

import SwiftUI

struct ImageAdjustDemo: View {
    var body: some View {
        VStack {
            // 显示一张图片
            //            ImageAdjust1View()
            
            // 调整图片大小并保持长宽比
            //            ImageAdjust2View()
            
            // 调整图片大小并充满整个容器
            //            ImageAdjust3View()
            
            // 调整图片的透明度
            //            ImageAdjust4View()
            
            // 调整图片的亮度
            //            ImageAdjust5View()
            
            // 调整图片的对比度
            //            ImageAdjust6View()
            
            // 调整图片的饱和度
            //            ImageAdjust7View()
            
            // 调整图片的色相
            //            ImageAdjust8View()
            
            // 调整图片的模糊度
            //            ImageAdjust9View()
            
            //            ImageAdjust10View()
            ImageAdjust11View()
        }
    }
}

struct ImageAdjust1View: View {
    var body: some View {
        VStack {
            Image("TT")
                .resizable()
                .scaledToFill()
        }
    }
}

struct ImageAdjust2View: View {
    var body: some View {
        VStack {
            Image("TT")
                .resizable()
                .scaledToFit()
        }
    }
}

struct ImageAdjust3View: View {
    var body: some View {
        VStack {
            Image("TT")
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 200)
                .clipped()
        }
    }
}

struct ImageAdjust4View: View {
    var body: some View {
        VStack {
            Image("TT")
                .resizable()
                .scaledToFit()
                .opacity(0.5)
        }
    }
}

struct ImageAdjust5View: View {
    var body: some View {
        VStack {
            Image("TT")
                .resizable()
                .scaledToFit()
                .brightness(0.4)
        }
    }
}

struct ImageAdjust6View: View {
    var body: some View {
        VStack {
            Image("TT")
                .resizable()
                .scaledToFit()
                .contrast(1.4)
        }
    }
}

struct ImageAdjust7View: View {
    var body: some View {
        VStack {
            Image("TT")
                .resizable()
                .scaledToFit()
                .saturation(1.5)
        }
    }
}

struct ImageAdjust8View: View {
    var body: some View {
        VStack {
            Image("TT")
                .resizable()
                .scaledToFit()
                .padding()
                .hueRotation(Angle.degrees(30))
        }
    }
}

struct ImageAdjust9View: View {
    var body: some View {
        VStack {
            Image("TT")
                .resizable()
                .scaledToFit()
                .padding()
                .blur(radius: 5)
        }
    }
}

struct ImageAdjust10View: View {
    var body: some View {
        VStack {
            Image("TT")
                .resizable()
                .scaledToFit()
                .shadow(color: .black, radius: 5, x: 0, y: 0)
                .padding()
        }
    }
}

struct ImageAdjust11View: View {
    @State var blendMode: BlendMode = .hardLight
    @State var opacity: Double = 0.5
    
    var body: some View {
        VStack {
            //11. 使用渐变来修改图片颜色
            Image("TT")
                .resizable()
                .scaledToFit()
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [.blue, .purple]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .opacity(opacity)
                    .blendMode(blendMode)
                )
            
            Picker("使用渐变来修改图片颜色", selection: $blendMode) {
                Text("典型").tag(BlendMode.normal)
                Text("变暗").tag(BlendMode.darken)
                Text("柔光").tag(BlendMode.softLight)
                Text("强光").tag(BlendMode.hardLight)
                Text("差别").tag(BlendMode.difference)
                Text("排斥").tag(BlendMode.exclusion)
                Text("颜色").tag(BlendMode.hue)
                Text("饱和").tag(BlendMode.saturation)
                Text("更深").tag(BlendMode.plusDarker)
                Text("更亮").tag(BlendMode.plusLighter)
            }
            .onChange(of: blendMode) { newValue in
                self.blendMode = newValue
            }
            
            Slider(value: $opacity, in: 0...1)
        }
    }
}

struct ImageAdjustDemo_Previews: PreviewProvider {
    static var previews: some View {
        ImageAdjustDemo()
    }
}
