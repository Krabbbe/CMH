import SwiftUI

struct FolderView: View {
    @Bindable var folder: Folder
    @State private var newFolderName = ""
    @State private var newTodoListName = ""
    
    var body: some View {
        List {
            // Show Folders
            Section {
                ForEach(folder.subfolders) { subfolder in
                    NavigationLink(destination: FolderView(folder: subfolder)) {
                        Image(systemName:"folder")
                        Text(subfolder.name)
                    }
                }
                .onDelete(perform: deleteFolder)
                .onMove(perform: moveFolder)
            }
            
            // Show To-Do Lists
            Section {
                ForEach(folder.todoLists) { todoList in
                    NavigationLink(destination: TodoListView(todoList: todoList)) {
                        Image(systemName:"checklist")
                        Text(todoList.name)
                    }
                }
                .onDelete(perform: deleteTodoList)
                .onMove(perform: moveTodoList)
            }
        }
        .navigationTitle(folder.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
            }
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button("New Folder", action: showAddFolderAlert)
                    Button("New To-Do List", action: showAddTodoListAlert)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    // MARK: - Move Functions
    private func moveFolder(from source: IndexSet, to destination: Int) {
        folder.subfolders.move(fromOffsets: source, toOffset: destination)
    }
    
    private func moveTodoList(from source: IndexSet, to destination: Int) {
        folder.todoLists.move(fromOffsets: source, toOffset: destination)
    }
    
    // MARK: - Delete Functions
    private func deleteFolder(at offsets: IndexSet) {
        folder.subfolders.remove(atOffsets: offsets)
    }
    
    private func deleteTodoList(at offsets: IndexSet) {
        folder.todoLists.remove(atOffsets: offsets)
    }
    
    /// Show Alert for Adding New Folder
    private func showAddFolderAlert() {
        let alert = UIAlertController(title: "New Folder", message: "Enter folder name", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Folder Name"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Create", style: .default) { _ in
            if let folderName = alert.textFields?.first?.text, !folderName.isEmpty {
                folder.addSubfolder(named: folderName)
            }
        })
        
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = scene.windows.first?.rootViewController {
            rootViewController.present(alert, animated: true)
        }
    }
    
    /// Show Alert for Adding New To-Do List
    private func showAddTodoListAlert() {
        let alert = UIAlertController(title: "New To-Do List", message: "Enter list name", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "List Name"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Create", style: .default) { _ in
            if let listName = alert.textFields?.first?.text, !listName.isEmpty {
                folder.addTodoList(named: listName)
            }
        })
        
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = scene.windows.first?.rootViewController {
            rootViewController.present(alert, animated: true)
        }
    }
}
