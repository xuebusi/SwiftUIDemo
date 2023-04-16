//
//  FileFolderViewModel.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/16.
//

import Foundation

class FileFolderViewModel: ObservableObject {
    @Published var folders: [FileFolder] = [
        /**
         FileFolder(text: "浩德智链云单"),
         FileFolder(text: "浩德智链采融"),
         FileFolder(text: "浩德智链库融"),
         FileFolder(text: "浩德智链贸融"),
         */
    ]
    private let KEY: String = "Folders"
    @Published var selectedFolder: FileFolder?
    @Published var updateFolderName: String = ""
    @Published var createdFolderName: String = ""
    
    func loadFolders() {
        folders = UserDefManager.getObjectArray(key: KEY)
    }
    
    func addFolder() {
        if createdFolderName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return
        }
        folders.append(FileFolder(text: createdFolderName))
        UserDefManager.setObjectArray(key: KEY, objectArray: folders)
        createdFolderName = ""
    }
    
    func updateFolder() {
        if let selectedFolder = selectedFolder,
           let index = folders.firstIndex(of: selectedFolder) {
            if selectedFolder.text == updateFolderName {
                return
            }
            if updateFolderName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                return
            }
            folders.remove(at: index)
            folders.insert(FileFolder(text: updateFolderName), at: index)
            UserDefManager.setObjectArray(key: KEY, objectArray: folders)
            loadFolders()
            print("修改成功")
        }
        selectedFolder = nil
        updateFolderName = ""
    }
    
    func moveFolder(from: IndexSet, to: Int) {
        folders.move(fromOffsets: from, toOffset: to)
        UserDefManager.setObjectArray(key: KEY, objectArray: folders)
        print("移动成功")
    }
    
    func deleteFolder() {
        if let selectedItem = selectedFolder,
           let index = folders.firstIndex(of: selectedItem) {
            folders.remove(at: index)
            UserDefManager.setObjectArray(key: KEY, objectArray: folders)
            print("删除成功")
            loadFolders()
        }
        selectedFolder = nil
    }
}
