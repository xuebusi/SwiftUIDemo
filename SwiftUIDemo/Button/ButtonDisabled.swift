//
//  ButtonDisabled.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/1.
//

import SwiftUI

struct ButtonDisabled: View {
    @State var disabled: Bool = true
    
    var body: some View {
        VStack {
            Button {
                
            } label: {
                Text("保存")
                    .cornerRadius(10)
            }
            .buttonStyle(BorderedButtonStyle())
            .disabled(disabled)
            
            Button {
                
            } label: {
                Text("保存")
                    .cornerRadius(10)
            }
            .buttonStyle(BorderedButtonStyle())
            .disabled(!disabled)
        }
        .padding()
    }
}

struct ButtonDisabled_Previews: PreviewProvider {
    static var previews: some View {
        ButtonDisabled()
    }
}
