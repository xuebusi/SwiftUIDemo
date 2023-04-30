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
    @Published var allFolders: [FileFolder] = []
    private let KEY: String = "Folders"
    private var parentFolder: FileFolder = FileFolder(id: "0", parentId: "-1", text: "")
    @Published var selectedFolder: FileFolder?
    @Published var updateFolderName: String = ""
    @Published var createdFolderName: String = ""
    
    func getKey() -> String {
        return "\(KEY):\(parentFolder.id)"
    }
    
    func loadFolders(parentFolder: FileFolder) {
        self.parentFolder = parentFolder
        folders = UserDefManager.getObjectArray(key: "\(KEY):\(self.parentFolder.id)")
        
        print("\n")
        for folder in folders {
            print(" 目录名称：\(folder.text)，id：\(folder.id)，父ID：\(folder.parentId)")
        }
        print("\n")
    }
    
    func getAllFolders() -> [FileFolder] {
        allFolders = getAllFileFolders([])
        return allFolders
    }
    
    private func getAllFileFolders(_ folders: [FileFolder], parentId: String = "0") -> [FileFolder] {
        var folders = folders
        var result: [FileFolder] = []
        folders = UserDefManager.getObjectArray(key: "\(KEY):\(parentId)")
        for folder in folders where folder.parentId == parentId {
            result.append(folder)
            result += getAllFileFolders(folders, parentId: folder.id)
        }
        
        return result
    }
    
    func addFolder() {
        if createdFolderName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return
        }
        folders.append(FileFolder(parentId: self.parentFolder.id, text: createdFolderName))
        UserDefManager.setObjectArray(key: getKey(), objectArray: folders)
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
            folders.insert(FileFolder(id: selectedFolder.id, parentId: selectedFolder.parentId, text: updateFolderName), at: index)
            UserDefManager.setObjectArray(key: getKey(), objectArray: folders)
            loadFolders(parentFolder: self.parentFolder)
            print("修改成功")
        }
        selectedFolder = nil
        updateFolderName = ""
    }
    
    func moveFolder(from: IndexSet, to: Int) {
        folders.move(fromOffsets: from, toOffset: to)
        UserDefManager.setObjectArray(key: getKey(), objectArray: folders)
        print("移动成功")
    }
    
    func deleteFolder() {
        if let selectedItem = selectedFolder,
           let index = folders.firstIndex(of: selectedItem) {
            folders.remove(at: index)
            UserDefManager.setObjectArray(key: getKey(), objectArray: folders)
            print("删除成功")
            loadFolders(parentFolder: self.parentFolder)
        }
        selectedFolder = nil
    }
}
