//
//  MVVMTodoListDemo.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/15.
//

import SwiftUI

struct MVVMTodoListDemo: View {
    @ObservedObject var vm: MVVMTodoListViewModel
    @State private var newTodoTitle = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(vm.todoItems) { item in
                    MVVMTodoItemView(item: item, toggleCompletion: vm.toggleCompletion)
                }
                .onDelete(perform: vm.deleteTodoItem)

                TextField("输入标题", text: $newTodoTitle, onCommit: {
                    vm.addTodoItem(title: newTodoTitle)
                    newTodoTitle = ""
                })
            }
            .navigationTitle("待办事项")
            .toolbar {
                EditButton()
            }
        }
    }
}

struct MVVMTodoItemView: View {
    var item: MVVMTodoItem
    var toggleCompletion: (MVVMTodoItem) -> Void

    var body: some View {
        Button(action: {
            toggleCompletion(item)
        }) {
            HStack {
                Text(item.title)
                    .strikethrough(item.isCompleted)
                Spacer()
                if item.isCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                }
            }
        }
    }
}

class MVVMTodoListViewModel: ObservableObject {
    @Published var todoItems: [MVVMTodoItem] = []

    func addTodoItem(title: String) {
        let newItem = MVVMTodoItem(title: title, isCompleted: false)
        todoItems.append(newItem)
    }

    func toggleCompletion(for item: MVVMTodoItem) {
        guard let index = todoItems.firstIndex(where: { $0.id == item.id }) else { return }
        todoItems[index].isCompleted.toggle()
    }

    func deleteTodoItem(at indexSet: IndexSet) {
        todoItems.remove(atOffsets: indexSet)
    }
}

struct MVVMTodoItem: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool
}

struct MVVMTodoListDemo_Previews: PreviewProvider {
    static var previews: some View {
        MVVMTodoListDemo(vm: MVVMTodoListViewModel())
    }
}
