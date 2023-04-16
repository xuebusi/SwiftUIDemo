//
//  FullScreenCoverItemOnDismissContent.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/6.
//

import SwiftUI

struct FullScreenCoverItemOnDismissContent: View {
    @State private var coverData: CoverData?
    
    var body: some View {
        Button("带数据的全屏显示") {
            coverData = CoverData(body: "自定义数据")
        }
        .fullScreenCover(item: $coverData, onDismiss: didDismiss) { details in
            VStack(spacing: 20) {
                Text("\(details.body)")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.orange)
            .onTapGesture {
                coverData = nil
            }
        }
    }
    
    func didDismiss() {
        // Handle the dismissing action.
    }
    
}

struct CoverData: Identifiable {
    var id: String {
        return body
    }
    let body: String
}

struct FullScreenCoverItemOnDismissContent_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenCoverItemOnDismissContent()
    }
}
