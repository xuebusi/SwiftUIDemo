//
//  NotepadExampleView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/4.
//

import SwiftUI

// Put functions above the struct

struct DefaultsKeys {
    static let keyOne = "firstStringKey" //This sets up saves for configs
    static let keyTwo = "secondStringKey" // Do one for each item.
}

struct NotepadExampleView: View {
    @State var Mytext = UserDefaults.standard.string(forKey: DefaultsKeys.keyOne) ?? "You can edit text"
    @State var Freq_text = UserDefaults.standard.string(forKey: DefaultsKeys.keyTwo) ?? "Frequent Text"
    @State var CountColor: Color = .black
    @State var CountMax: Float = 280
    //Restores last saved version. Uses State for variables inside content views
        var body: some View {
            VStack{
                Text("**Notepad**") //Heading - Notice support for markdown
                    .font(.system(.largeTitle, design: .monospaced)) //Font choice
            TextEditor(text: $Mytext)
                    .font(.system(.body, design: .monospaced))
                    .border(.mint) // border color
                    .padding() // Padding on edges
                    .onChange(of: Mytext) {
                        newValue in
                        if Mytext.count > Int(CountMax) {
                            CountColor = .red}
                        else {CountColor = .black}
                    }
                HStack{
                
                    TextField("Frequent Text",text: $Freq_text)
                        .font(.system(.body, design: .monospaced))
                        .border(.mint) // border color
                        .padding() // Padding on edges
                    
                    Button("Append"){
                        Mytext+=Freq_text
                    }
                    .padding()
                    
                }
                HStack{
                    Text("Chars:  \(Mytext.count)") //Give the length
                        .foregroundColor(CountColor)
                Button("Save") {
                    let defaults = UserDefaults.standard
                    defaults.set(Mytext, forKey: DefaultsKeys.keyOne)
                    defaults.set(Freq_text, forKey: DefaultsKeys.keyTwo)
                } // Save button. Saves a dictionary
                    .padding()
                    Slider(value: $CountMax, in: 0...400, step:10)
                    Text("\(Int(CountMax))")
                        .padding()
                }
            }
            
        }
}

struct NotepadExampleView_Previews: PreviewProvider {
    static var previews: some View {
        NotepadExampleView()
    }
}
