//
//  DragGestureSimpleDemo.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/1.
//

import SwiftUI

struct DragGestureSimpleDemo: View {
    // 是否获得了焦点
    @FocusState var isTextFieldFocused: Bool
    @State var showText: String = "弹出键盘后试着拖动此区域"
    @State var inputText: String = ""
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    Text(showText)
                        .frame(maxWidth: .infinity)
                        .frame(height: UIScreen.main.bounds.height/2) // 屏幕高度的一半
                        .font(.system(.headline))
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: UIScreen.main.bounds.height/2) // 屏幕高度的一半
            .background(.cyan)
            .cornerRadius(30)
            .gesture(
                DragGesture()
                    .onChanged({ gesture in
                        // 计算手势拖动的方向
                        let dragType = detectDrag(end: gesture.predictedEndLocation, start: gesture.location)
                        // 上下拖动手势则失去焦点
                        if dragType == .TopToBottom || dragType == .BottomToTop {
                            isTextFieldFocused = false
                        }
                    })
            )
            .onTapGesture {
                // 点击手势则失去焦点
                isTextFieldFocused = false
            }
            
            TextField("请输入文字", text: $inputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .focused($isTextFieldFocused) // 绑定焦点状态
            
            Spacer()
        }
        .padding()
    }
    
    // 检测拖动手势
    // start：拖动事件起始点坐标，
    // end：拖动事件结束点坐标
    func detectDrag(end: CGPoint, start: CGPoint) -> DragGestureType {
        // 水平拖动的距离
        let horizontalMovement = end.x - start.x
        // 垂直拖动的距离
        let verticalMovement = end.y - start.y
        // 根据拖动距离的绝对值判断水平和垂直拖动距离的大小
        if abs(horizontalMovement) > abs(verticalMovement) {
            // 检测水平拖动手势
            if horizontalMovement > 0 {
                self.showText = "检测到从左到右滑动"
                return .LeftToRight
            } else {
                self.showText = "检测到从右到左滑动"
                return .RightToLeft
            }
        } else {
            // 检测垂直拖动手势
            if verticalMovement > 0 {
                self.showText = "检测到从上到下滑动"
                return .TopToBottom
            } else {
                self.showText = "检测到从下到上滑动"
                return .BottomToTop
            }
        }
    }
}

// 手势枚举
enum DragGestureType {
    case None
    case LeftToRight
    case RightToLeft
    case TopToBottom
    case BottomToTop
}

// 预览
struct DragGestureSimpleDemo_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureSimpleDemo()
    }
}
