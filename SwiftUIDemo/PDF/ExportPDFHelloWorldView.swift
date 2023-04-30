//
//  ExportPDFHelloWorldView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/22.
//

import SwiftUI

struct ExportPDFHelloWorldView: View {
    @State var PDFUrl: URL?
    @State var showShareSheet: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Button {
                    exportPDF {
                        self
                    } completion: { status, url in
                        if let url = url, status {
                            self.PDFUrl = url
                            self.showShareSheet.toggle()
                        } else {
                            print("生成PDF失败")
                        }
                    }

                } label: {
                    Image(systemName: "square.and.arrow.up.fill")
                }

            }
            .padding()
            Spacer()
            ScrollView {
                Text("使用swiftUI如何导出PDF文档？")
                    .padding()
                Divider()
                Text("""
                在 SwiftUI 中，你可以使用 `PDFKit` 框架来生成和导出 PDF 文档。
                """)
                .frame(alignment: .leading)
            }
        }
        .padding()
        .sheet(isPresented: $showShareSheet) {
            if let PDFUrl = PDFUrl {
                ShareSheet(urls: [PDFUrl])
            }
        }
    }
}

struct ExportPDFHelloWorldView_Previews: PreviewProvider {
    static var previews: some View {
        ExportPDFHelloWorldView()
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    
    var urls: [Any]
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = UIActivityViewController(activityItems: urls, applicationActivities: nil)
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
