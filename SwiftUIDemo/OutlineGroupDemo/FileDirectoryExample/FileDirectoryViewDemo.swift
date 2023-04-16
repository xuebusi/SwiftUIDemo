//
//  FileDirectoryViewDemo.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/8.
//

import SwiftUI

struct Directory: Identifiable {
    let id = UUID()
    let name: String
    let isDirectory: Bool
    var subdirectories: [Directory] = []
}

struct DirectoryView: View {
    @StateObject var vm = FileDirectoryViewModel()
    @State var rootDirectory = Directory(name: "根目录", isDirectory: true)
    
    var body: some View {
        NavigationView {
            DirectoryList(directory: rootDirectory)
        }
        .environmentObject(vm)
    }
}

struct DirectoryList: View {
    @EnvironmentObject var vm: FileDirectoryViewModel
    @State var directory: Directory
    
    var body: some View {
        List(vm.querySubdirectories(directory: directory)) { subdirectory in
            NavigationLink(destination: DirectoryList(directory: subdirectory)) {
                HStack {
                    Image(systemName: subdirectory.isDirectory ? "folder.fill" : "doc.fill")
                    Text(subdirectory.name)
                }
            }
        }
        .listStyle(SidebarListStyle())
        .navigationBarTitle(Text(directory.name), displayMode: .inline)
        .navigationBarItems(
            trailing: HStack {
                if directory.isDirectory {
                    CreateDirectoryButton(directory: $directory)
                    CreateFileButton(directory: $directory)
                }
            }
        )
    }
}

struct CreateDirectoryButton: View {
    @Binding var directory: Directory
    
    var body: some View {
        Button {
            let newDirectory = Directory(name: "新目录", isDirectory: true)
            self.directory.subdirectories.append(newDirectory)
        } label: {
            Image(systemName: "folder.badge.plus")
        }
        
    }
}

struct CreateFileButton: View {
    @Binding var directory: Directory
    
    var body: some View {
        Button {
            let newDirectory = Directory(name: "新文件", isDirectory: false)
            self.directory.subdirectories.append(newDirectory)
        } label: {
            Image(systemName: "doc.badge.plus")
        }
        
    }
}

class FileDirectoryViewModel: ObservableObject {
    @Published var directories: [Directory] = []
    
    func querySubdirectories(directory: Directory) -> [Directory] {
        var subdirectories: [Directory] = []
        if !directory.subdirectories.isEmpty {
            for _directory in directory.subdirectories {
                subdirectories.append(_directory)
            }
        }
        return subdirectories
    }
}

struct FileDirectoryViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        DirectoryView()
    }
}
