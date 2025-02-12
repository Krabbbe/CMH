import SwiftUI

struct TodoListView: View {
    @Bindable var todoList: TodoList
    @State private var newTaskName = ""
    
    var body: some View {
        List {
            ForEach(todoList.tasks) { task in
                HStack {
                    Text(task.name)
                    Spacer()
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                        .onTapGesture {
                            toggleTaskCompletion(task)
                        }
                }
            }
            .onDelete(perform: deleteTask) // Enable swipe to delete
            .onMove(perform: moveTask)     // Enable drag-to-reorder
        }
        .navigationTitle(todoList.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                EditButton() // Enables reordering mode
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: showAddTaskAlert) {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    // MARK: - Move Function
    private func moveTask(from source: IndexSet, to destination: Int) {
        todoList.tasks.move(fromOffsets: source, toOffset: destination)
    }
    
    private func deleteTask(at offsets: IndexSet) {
        todoList.tasks.remove(atOffsets: offsets)
    }
    
    /// Toggle task completion
    private func toggleTaskCompletion(_ task: TaskItem) {
        if let index = todoList.tasks.firstIndex(where: { $0.id == task.id }) {
            todoList.tasks[index].isCompleted.toggle()
        }
    }
    
    /// Show Alert for Adding a New Task
    private func showAddTaskAlert() {
        let alert = UIAlertController(title: "New Task", message: "Enter task name", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Task Name"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Add", style: .default) { _ in
            if let taskName = alert.textFields?.first?.text, !taskName.isEmpty {
                todoList.addTask(named: taskName)
            }
        })
        
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = scene.windows.first?.rootViewController {
            rootViewController.present(alert, animated: true)
        }
    }
}
