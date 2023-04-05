//
//  TodoList.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/3/11.
//

//import SwiftUI
//
//struct TodoDemoView: View {
//    var body: some View {
//        TodoList()
//    }
//}
//
//struct TodoList: View {
//    @State var todoItems: [TodoItem] = []
//    @AppStorage("todoItems") var savedTodoItems: Data?
//    
//    var body: some View {
//        NavigationView {
//            List(todoItems) { item in
//                HStack {
//                    Text(item.title)
//                        .font(.headline)
//                    Spacer()
//                    Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
//                        .foregroundColor(item.isCompleted ? .green : .gray)
//                        .onTapGesture {
//                            self.updateTodoItem(for: item)
//                        }
//                }
//            }
//            .navigationBarTitle("待办事项")
//            .navigationBarItems(
//                trailing:
//                    Button(action: {
//                        self.addTodoItem()
//                    }) {
//                        Image(systemName: "plus.circle.fill")
//                    }
//            )
//            .onAppear() {
//                self.loadData()
//            }.onDisappear() {
//                self.saveData()
//            }
//        }
//        
//        
//    }
//    
//    func addTodoItem() {
//        let newTodoItem = TodoItem(title: "New Todo Item")
//        self.todoItems.append(newTodoItem)
//        self.saveData()
//    }
//    
//    func updateTodoItem(for item: TodoItem) {
//        if let index = todoItems.firstIndex(where: { $0.id == item.id }) {
//            self.todoItems[index].isCompleted.toggle()
//            self.saveData()
//        }
//    }
//    
//    func loadData() {
//        if let data = savedTodoItems,
//           let savedTodoItems = try? JSONDecoder().decode([TodoItem].self, from: data) {
//            self.todoItems = savedTodoItems
//        }
//    }
//    
//    func saveData() {
//        if let data = try? JSONEncoder().encode(self.todoItems) {
//            savedTodoItems = data
//        }
//    }
//}
//
//struct TodoItem: Identifiable, Codable {
//    var id = UUID()
//    let title: String
//    var isCompleted: Bool = false
//}
//
//struct TodoList_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoList()
//    }
//}
