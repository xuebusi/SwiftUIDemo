//
//  TextGradientViewDemo.swift
//  LinkAPI
//
//  Created by shiyanjun on 2023/3/27.
//

import SwiftUI

struct TextGradientViewDemo: View {
    @State var textContent: String = "Hello SwiftUI!"
    @State var colors: [Color] = [.red, .orange, .yellow, .green, .cyan, .blue, .purple]
    
    var body: some View {
        TextGradientView(textContent: textContent, colors: colors)
    }
}

struct TextGradientView: View {
    let textContent: String
    let colors: [Color]
    
    var body: some View {
        Canvas { context, size in
            let midPoint = CGPoint(x: size.width/2, y: size.height/2)
            let font = Font.custom("Arial Rounded MT Bold", size: 40)
            
            var resolved = context.resolve(Text(textContent).font(font))
            
            let start = CGPoint(x: (size.width - resolved.measure(in: size).width) / 2.0, y: 0)
            let end = CGPoint(x: size.width - start.x, y: 0)
            
            resolved.shading = .linearGradient(Gradient(colors: colors),
                                               startPoint: start,
                                               endPoint: end)
            
            context.draw(resolved, at: midPoint, anchor: .center)
        }
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextGradientViewDemo()
    }
}
