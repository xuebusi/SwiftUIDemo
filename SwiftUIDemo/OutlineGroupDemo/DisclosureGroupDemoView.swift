//
//  DisclosureGroupDemoView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/5.
//

import SwiftUI

struct DisclosureGroupDemoView: View {
    @State private var toggleStates = ToggleStates()
    @State private var topExpanded: Bool = true
    
    var body: some View {
        List {
            DisclosureGroup("Items", isExpanded: $topExpanded) {
                Toggle("Toggle 1", isOn: $toggleStates.oneIsOn)
                Toggle("Toggle 2", isOn: $toggleStates.twoIsOn)
                DisclosureGroup("Sub-items") {
                    Text("Sub-item 1")
                }
            }
        }
    }
}

struct ToggleStates {
    var oneIsOn: Bool = false
    var twoIsOn: Bool = true
}

struct DisclosureGroupDemoView_Previews: PreviewProvider {
    static var previews: some View {
        DisclosureGroupDemoView()
    }
}
