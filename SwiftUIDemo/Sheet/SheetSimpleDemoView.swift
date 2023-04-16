//
//  SheetSimpleDemoView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/5.
//

import SwiftUI

// 自适应高度的Sheet
struct SheetSimpleDemoView: View {
    @State var show = false
    var body: some View {
        VStack {
            Button("Pop Sheet") { show.toggle() }
        }
        .adaptiveSheet(isPresent: $show) { SheetView() }
    }
}

struct SheetView: View {
    var body: some View {
        Text("Hi")
            .frame(maxWidth: .infinity, minHeight: 250)
            .background(Color.orange.gradient,ignoresSafeAreaEdges: .bottom)
    }
}

extension View {
    func adaptiveSheet<Content: View>(isPresent: Binding<Bool>, @ViewBuilder sheetContent: () -> Content) -> some View {
        modifier(AdaptiveSheetModifier(isPresented: isPresent, sheetContent))
    }
}

struct AdaptiveSheetModifier<SheetContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    @State private var subHeight: CGFloat = 0
    var sheetContent: SheetContent

    init(isPresented: Binding<Bool>, @ViewBuilder _ content: () -> SheetContent) {
        self._isPresented = isPresented
        sheetContent = content()
    }

    func body(content: Content) -> some View {
        content
            .background(
                sheetContent // 在此获取尺寸，防止初次弹出抖动
                    .background(
                        GeometryReader { proxy in
                            Color.clear
                                .task { subHeight = proxy.size.height }
                        }
                    )
                    .hidden()
            )
            .sheet(isPresented: $isPresented) {
                sheetContent
                    .presentationDetents([.height(subHeight)])
            }
            .id(subHeight)
    }
}

struct SheetSimpleDemoView_Previews: PreviewProvider {
    static var previews: some View {
        SheetSimpleDemoView()
    }
}
