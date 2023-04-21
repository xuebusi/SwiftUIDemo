//
//  ShowLicenseAgreement.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/5.
//

import SwiftUI

struct ShowLicenseAgreement: View {
    @State private var isShowingSheet = false
    var body: some View {
        Button(action: {
            isShowingSheet.toggle()
        }) {
            Text("Show License Agreement")
        }
        .sheet(isPresented: $isShowingSheet, onDismiss: didDismiss) {
            VStack {
                Text("License Agreement")
                    .font(.title)
                    .padding(50)
                Text("Terms and conditions go here.")
                    .padding(50)
                Button("Dismiss") {
                    isShowingSheet.toggle()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.orange)
            // .presentationDetents([.medium]) // 中等高度
            // .presentationDetents([.large])
             .presentationDetents([.height(350)]) // 自定义高度
        }
    }
    
    func didDismiss() {
        // Handle the dismissing action.
    }
}

struct ShowLicenseAgreement_Previews: PreviewProvider {
    static var previews: some View {
        ShowLicenseAgreement()
    }
}
