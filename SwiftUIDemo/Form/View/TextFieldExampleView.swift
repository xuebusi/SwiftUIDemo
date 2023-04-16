//
//  TextFieldExampleView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/13.
//

import SwiftUI

struct TextFieldExampleView: View {
    let options = ["自定义", "GET", "POST", "PUT", "DELETE"]
    @State private var selectedOption = ""
    @State private var userInput = ""
    @State private var showPicker = true
    
    var body: some View {
        VStack {
            TextField("输入文本", text: $userInput)
                .frame(width: UIScreen.main.bounds.width/2)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .overlay(alignment: .trailing) {
                    if showPicker {
                        Picker("选择一个选项", selection: $selectedOption) {
                            ForEach(options, id: \.self) { item in
                                Text(item)
                                    .frame(width: 100)
                            }
                        }
                        .onChange(of: selectedOption) { _ in
                            userInput = selectedOption
                            showPicker = false
                        }
                    }
                }
            
            Text("您选择的是: \(selectedOption)")
                .padding()
        }
        .padding()
        .onTapGesture {
            showPicker = true
            selectedOption = ""
        }
    }
}

struct TextFieldExampleView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldExampleView()
    }
}
