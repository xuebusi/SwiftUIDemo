//
//  AsyncThrowingStreamView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/3.
//

import SwiftUI

struct AsyncThrowingStreamView: View {
    let timer = Timer.publish(every: 0.3, on: .main, in: .default).autoconnect()
    @State var messageList: [String] = []
    
    var body: some View {
        ScrollView {
            ForEach(messageList, id: \.self) { message in
                Text(message)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(.caption))
                    .foregroundColor(.primary)
                    .background(.cyan)
                    .cornerRadius(10)
            }
        }
        .padding()
        .task {
            do {
                let stream = generateData()
                for try await value in stream  {
                    messageList.append(String(value))
                }
            } catch {
                print(error)
            }
        }
    }
    
    // 模拟数据流
    func generateData() -> AsyncThrowingStream<String, Error> {
        AsyncThrowingStream { continuation in
            Task {
                for _ in 0..<15 {
                    continuation.yield(UUID().uuidString)
                }
                continuation.finish()
            }
        }
    }
    
    
}

struct AsyncThrowingStreamView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncThrowingStreamView()
    }
}
