//
//  ClearableTextFieldView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/3/31.
//

import SwiftUI

struct ClearableTextFieldView: View {
    @State var text = ""

    var body: some View {
        VStack {
            ClearableTextField(text: $text)
        }
    }
}

struct ClearableTextField: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Input", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            if !text.isEmpty {
                Button(action: {
                    self.text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

struct ClearableTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        ClearableTextFieldView()
    }
}
