//
//  ImageBeautifyDemo.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/3/9.
//

import SwiftUI

struct ImageBeautifyDemo: View {
    var body: some View {
        ImageView_1()
    }
}

struct ImageView_1: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 30) {
                    VStack(spacing: 30) {
                        //1. 调整图片的大小
                        Image("MyImg")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                        
                        //2. 给图片添加阴影
                        Image("MyImg")
                            .shadow(color: .white, radius: 5, x: 0, y: 0)
                        
                        //3. 使用圆形剪辑裁剪图片
                        Image("MyImg")
                            .clipShape(Circle())
                        
                        //4. 使用圆角剪辑裁剪图片
                        Image("MyImg")
                            .frame(width: 200, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        //5. 使用渐变蒙版来遮罩图片
                        Image("MyImg")
    //                        .frame(width: 300, height: 300)
                            .mask(
                                LinearGradient(
                                    gradient: Gradient(colors: [.clear, .black]),
                                    startPoint: .topTrailing,
                                    endPoint: .bottomLeading
                                )
                            )
                    }
                    .padding()
                    VStack(spacing: 30) {
                        
                        //6. 旋转图片
                        Image("MyImg")
                            .rotationEffect(.degrees(15))
                        
                        //7. 使用深色效果来修改图片颜色
                        Image("MyImg")
                            .colorMultiply(.gray)
                        
                        //8. 添加边框
                        Image("MyImg")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 400, height: 400)
                            .border(Color.purple, width: 2)
                        
                        //9. 使用模糊效果
                        Image("MyImg")
                            .blur(radius: 5)
                        
                        //10. 使用渐变来修改图片颜色
                        Image("MyImg")
                            .overlay(
                                LinearGradient(
                                    gradient: Gradient(colors: [.blue, .purple]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                                .opacity(0.3)
                            )
                    }
                    .padding()
                    VStack(spacing: 30) {

                        //11. 添加简单的滤镜
                        Image("MyImg")
                            .colorInvert()

                        //12. 使用缩放效果
                        Image("MyImg")
                            .scaleEffect(CGSize(width: 2, height: 2))

                        //13. 旋转并缩放图片
                        Image("MyImg")
                            .rotationEffect(.degrees(45))
                            .scaleEffect(CGSize(width: 1.5, height: 1.5))

                        //14. 使用简单的遮罩
                        Image("MyImg")
                            .frame(width: 300, height: 300)
                            .mask(
                                RoundedRectangle(cornerRadius: 10)
                            )

                        //15. 调整图片的亮度和对比度
                        Image("MyImg")
                            .brightness(0.3)
                            .contrast(0.9)
                    }
                    .padding()
                }
            }
        }
    }
}

struct ImageBeautifyDemo_Previews: PreviewProvider {
    static var previews: some View {
        ImageBeautifyDemo()
    }
}
