//
//  ConfirmDialogDemoView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/11.
//

import SwiftUI

struct ConfirmDialogDemoView: View {
    private let words: [String] = ["hello1", "hello2", "hello3"]
    @State var showDeleteDialog: Bool = false
    @State var showUpdateSheet: Bool = false
    @State var selectedWord: String?
    
    var body: some View {
        VStack {
            List {
                ForEach(words, id: \.self) { word in
                    Text(word)
                        .contextMenu {
                            Button(role: .destructive) {
                                showUpdateSheet.toggle()
                                self.selectedWord = word
                            } label: {
                                Label("修改", systemImage: "trash")
                            }
                            
                            Button(role: .destructive) {
                                showDeleteDialog.toggle()
                                self.selectedWord = word
                            } label: {
                                Label("删除", systemImage: "trash")
                            }
                        }
                        .confirmationDialog("", isPresented: $showDeleteDialog) {
                            Button(role: .destructive) {
                                print("已删除")
                            } label: {
                                Text("删除")
                            }

                            Button(role: .cancel) {
                                
                            } label: {
                                Text("取消")
                            }

                        } message: {
                            Text("确定删除该目录吗？")
                        }
                }
            }
        }
    }
}

struct ConfirmDialogDemoView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmDialogDemoView()
    }
}
