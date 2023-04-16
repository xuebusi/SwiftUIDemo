//
//  TaskListView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/14.
//

import SwiftUI

class TaskListViewModel: ObservableObject {
    @Published var tasks = [TestTask]()

    func addTask(_ task: TestTask) {
        tasks.append(task)
    }

    func deleteTask(at index: Int) {
        tasks.remove(at: index)
    }
    
    func moveTask(from source: IndexSet, to destination: Int) {
        tasks.move(fromOffsets: source, toOffset: destination)
    }
}

struct TaskListView: View {
    @ObservedObject var viewModel: TaskListViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.tasks, id: \.self) { task in
                    Text(task.title)
                }
                .onDelete(perform: deleteTask)
                .onMove(perform: moveTask)
            }
            .navigationBarTitle("任务清单")
            .navigationBarItems(trailing:
                NavigationLink(destination: AddTaskView(viewModel: viewModel)) {
                    Text("添加")
                }
            )
        }
        .accentColor(.pink)
    }

    func deleteTask(at indexSet: IndexSet) {
        viewModel.deleteTask(at: indexSet.first!)
    }
    
    func moveTask(from source: IndexSet, to destination: Int) {
        viewModel.moveTask(from: source, to: destination)
    }
}

struct AddTaskView: View {
    @ObservedObject var viewModel: TaskListViewModel
    @State private var title = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Form {
            TextField("内容", text: $title)
            Button("确定") {
                if title.isEmpty {
                    return
                }
                viewModel.addTask(TestTask(title: title))
                presentationMode.wrappedValue.dismiss()
            }
        }
        .navigationBarTitle("添加任务")
    }
}

struct TestTask: Hashable {
    var title: String
}

struct MVVMDemo2_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView(viewModel: TaskListViewModel())
    }
}
