//
//  SendMessageView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/3.
//

import SwiftUI

struct SendMessageView: View {
    @StateObject var vm = SendMessageViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                ScrollView {
                    VStack {
                        ForEach(vm.messages) { message in
                            Text(message.content)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(.orange)
                                .cornerRadius(10)
                        }
                    }
                }
                .foregroundColor(.primary)
                HStack {
                    Button {
                        vm.appendLast()
                    } label: {
                        Text("模拟消息流")
                            .padding()
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity)
                            .background(.cyan)
                            .cornerRadius(10)
                    }
                    Button {
                        vm.appendLast()
                    } label: {
                        Text("流结束")
                            .padding()
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity)
                            .background(.cyan)
                            .cornerRadius(10)
                    }
                }
                Button {
                    vm.sendNewMessage()
                } label: {
                    Text("发送新消息")
                        .padding()
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity)
                        .background(.cyan)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .background(.gray.opacity(0.1))
    }
}

struct SendMessageView_Previews: PreviewProvider {
    static var previews: some View {
        SendMessageView()
    }
}

class SendMessageViewModel: ObservableObject {
    @Published var messages: [SendMessage] = [SendMessage(content: "")]
    
    func appendLast(text: String = "Hello ") {
        var originMessage = messages.last?.content
        originMessage! += text
        messages.removeLast()
        messages.append(SendMessage(content: originMessage ?? ""))
    }
    
    func markCompleted() {
        
    }
    
    func sendNewMessage(content: String = "SwiftUI! ") {
        messages.append(SendMessage(content: content))
    }
}

struct SendMessage: Identifiable, Hashable, Codable {
    var id = UUID()
    var content: String
    var status: MessageStatus = .waiting
}

enum MessageStatus: Codable {
    case waiting
    case sending
    case completed
}
