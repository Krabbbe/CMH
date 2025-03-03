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
    
    func addTask(named name: String, note: String, date: Date) {
        tasks.append(TaskItem(name: name, note: note, date: date))
    }
}

struct TaskItem: Identifiable {
    let id = UUID()
    var name: String
    var note: String
    var date: Date
    var isCompleted: Bool = false
    var dueDate: Date?
}
