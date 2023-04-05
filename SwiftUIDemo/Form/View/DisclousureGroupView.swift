//
//  DisclousureGroupView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/4.
//

import SwiftUI

struct DisclousureGroupView: View {
    // 是否展开
    @State var isProfileSectionExpanded = true
    
    var body: some View {
        Form {
            Section {
                DisclosureGroup(isExpanded: $isProfileSectionExpanded) {
                    TextField("First Name", text: .constant(""))
                    TextField("Last Name", text: .constant(""))
                    TextField("Email", text: .constant(""))
                    DatePicker("Birthdate", selection: .constant(Date()))
                } label: {
                    HStack {
                        Image(systemName: "person.circle")
                        Text("Personal Information")
                    }
                }
            }
            
            Section {
                DisclosureGroup {
                    Toggle("Push", isOn: .constant(true))
                    Toggle("SMS", isOn: .constant(true))
                    Toggle("Email", isOn: .constant(true))
                } label: {
                    HStack {
                        Image(systemName: "ellipsis.bubble")
                        Text("Notification Preferences")
                    }
                }

            }
        }
    }
}

struct DisclousureGroupView_Previews: PreviewProvider {
    static var previews: some View {
        DisclousureGroupView()
    }
}
