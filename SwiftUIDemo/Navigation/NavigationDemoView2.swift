//
//  NavigationDemoView2.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/14.
//

import SwiftUI

struct NavigationDemoView2: View {
    @State private var showSheet = false
    
    var body: some View {
        VStack {
            Button("Show Sheet") {
                self.showSheet.toggle()
            }
            .padding()
            
            NavigationLink(destination: NDetailView()) {
                Text("Go to Detail View")
            }
        }
        .sheet(isPresented: $showSheet) {
            NSheetView()
        }
    }
}

struct NSheetView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("This is a sheet.")
                
                NavigationLink(destination: NDetailView()) {
                    Text("Go to Detail View")
                }
            }
            .navigationTitle("Sheet View")
        }
    }
}

struct NDetailView: View {
    var body: some View {
        Text("This is the detail view.")
    }
}

struct NavigationDemoView2_Previews: PreviewProvider {
    static var previews: some View {
        NavigationDemoView2()
    }
}
