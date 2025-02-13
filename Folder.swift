import Foundation

@Observable
class Folder: Identifiable {
    let id = UUID()
    var name: String
    var subfolders: [Folder]
    var todoLists: [TodoList] // Each folder can contain multiple to-do lists
    
    init(name: String, subfolders: [Folder] = [], todoLists: [TodoList] = []) {
        self.name = name
        self.subfolders = subfolders
        self.todoLists = todoLists
    }
    
    func addSubfolder(named name: String) {
        subfolders.append(Folder(name: name))
    }
    
    func addTodoList(named name: String) {
        todoLists.append(TodoList(name: name))
    }
}
