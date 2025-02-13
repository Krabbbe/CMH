import Foundation

@Observable
class TodoList: Identifiable {
    let id = UUID()
    var name: String
    var tasks: [TaskItem]
    
    init(name: String, tasks: [TaskItem] = []) {
        self.name = name
        self.tasks = tasks
    }
    
    func addTask(named name: String) {
        tasks.append(TaskItem(name: name))
    }
}

struct TaskItem: Identifiable {
    let id = UUID()
    var name: String
    var isCompleted: Bool = false
}
