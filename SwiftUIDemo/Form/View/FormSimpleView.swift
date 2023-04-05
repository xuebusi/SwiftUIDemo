//
//  FormSimpleView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/3/25.
//

import SwiftUI

struct FormSimpleView: View {
    @State private var name = ""
    @State private var age = 18
    @State private var gender = 0
    @State private var isSmoker = false
    @State private var birthdate = Date()
    @State private var selectedColor = 0
    @State private var sliderValue = 50.0
    
    let colors = ["Red", "Green", "Blue"]
    var genders = ["Male", "Female", "Other"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("Name", text: $name)
                    Stepper(value: $age, in: 0...150) {
                        Text("Age: \(age)")
                    }
                    Picker(selection: $gender, label: Text("Gender")) {
                        ForEach(0..<genders.count) {
                            Text(self.genders[$0])
                        }
                    }
                }
                Section(header: Text("Habits")) {
                    Toggle(isOn: $isSmoker) {
                        Text("Smoker")
                    }
                    DatePicker(selection: $birthdate, in: ...Date(), displayedComponents: .date) {
                        Text("Birthdate")
                    }
                }
                
                Slider(value: $sliderValue, in: 0...100) {
                    Text("Slider Value: \(sliderValue, specifier: "%.0f")")
                }
                .padding()
                
                Picker(selection: $selectedColor, label: Text("Favorite Color")) {
                    ForEach(0..<colors.count) {
                        Text(self.colors[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
            }
            .navigationBarTitle(Text("Personal Profile"))
        }
    }
}

struct FormSimpleView_Previews: PreviewProvider {
    static var previews: some View {
        FormSimpleView()
    }
}
