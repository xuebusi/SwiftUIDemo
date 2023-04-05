//
//  TodoDemoView2.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/3/11.
//

import SwiftUI


import SwiftUI
import Combine

struct TodoDemoView2: View {
    @State private var todoItems = [TodoItem]()
    private var autosave: AnyCancellable?

    init() {
//        self.autosave = UserDefaults.standard.todoItemsPublisher
//            .sink(receiveValue: { todos in
//                self.todoItems = todos
//            })
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("添加待办事项", text: $newItemTitle).textFieldStyle(
                        RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Button(action: {
                        self.addTodoItem()
                    }) {
                        Text("添加")
                            .padding()
                            .frame(height: 32)
                            .foregroundColor(.primary)
                            .background(.cyan)
                        
                    }
                    .padding(.trailing)
                }
                List {
                    ForEach(todoItems) { item in
                        HStack {
                            Button(action: {
                                self.toggleTodoItemStatus(item: item)
                            }) {
                                Text(item.isCompleted ? "✔️" : "◻️")
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            .padding(.leading, 8)
                            
                            TextField(item.title, text: self.binding(for: item))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .foregroundColor(item.isCompleted ? .gray : .primary)

                        }
                        .opacity(item.isCompleted ? 0.5 : 1.0)
                    }
                    .onDelete(perform: deleteTodoItem)
                }
            }
            .navigationTitle("待办事项")
        }
    }
    
    @State private var newItemTitle: String = ""
    
    func addTodoItem() {
        let newItem = TodoItem(title: newItemTitle.trimmingCharacters(in: .whitespacesAndNewlines))
        self.todoItems.append(newItem)
        self.newItemTitle = ""
    }
    
    func deleteTodoItem(at offsets: IndexSet) {
        self.todoItems.remove(atOffsets: offsets)
    }
    
    func toggleTodoItemStatus(item: TodoItem) {
        if let index = todoItems.firstIndex(where: { $0.id == item.id }) {
            todoItems[index].isCompleted.toggle()
        }
    }
    
    private func binding(for item: TodoItem) -> Binding<String> {
        guard let index = todoItems.firstIndex(where: { $0.id == item.id}) else {
            fatalError("Can't find item in array")
        }
        return $todoItems[index].title
    }
}


struct TodoItem: Identifiable, Codable {
    var id = UUID()
    var title: String
    var isCompleted = false
}

extension UserDefaults {
    static let shared = UserDefaults.standard
    
    private enum Keys {
        static let todoItems = "todoItems"
    }
    
//    var todoItemsPublisher: AnyPublisher<[TodoItem], Never> {
//        return self.publisher(for: .init(Keys.todoItems))
//            .decode(type: [TodoItem].self, decoder: JSONDecoder())
//            .replaceError(with: [])
//            .eraseToAnyPublisher()
//    }
    
    func setTodoItems(_ items: [TodoItem]) {
        let jsonEncoder = JSONEncoder()
        if let encodedData = try? jsonEncoder.encode(items) {
            self.set(encodedData, forKey: Keys.todoItems)
        }
    }
}


struct TodoDemoView2_Previews: PreviewProvider {
    static var previews: some View {
        TodoDemoView2()
    }
}
