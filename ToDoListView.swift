import SwiftUI

struct TodoListView: View {
    @Bindable var todoList: TodoList
    @State private var newTaskName = ""
    @State private var newTaskNote = ""
    @State private var newTaskDate = Date()
    @State private var creatingTask = false
    @State private var toggleDate = false
    @State private var toggleTime = false
    
    var body: some View {
        List {
            ForEach(todoList.tasks) { task in
                VStack {
                    HStack {
                        Text(task.name)
                        Spacer()
                        Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                            .onTapGesture {
                                toggleTaskCompletion(task)
                            }
                    }
                    Text(task.note)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                    Text(task.date, style: .date)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                    Text(task.date, style: .time)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
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
                Button(action: {
                    self.creatingTask = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .popover(isPresented: $creatingTask) {
            NavigationView {
                Form {
                    Section {
                        TextField("title", text: $newTaskName)
                        TextField("notes", text: $newTaskNote)
                    }
                    Section {
                        Toggle(isOn: $toggleDate) {
                            HStack {
                                Image(systemName: "calendar")
                                Text("Date")
                            }
                        }
                        .onChange(of: toggleDate) {
                            if toggleTime && !toggleDate {
                                toggleTime = false
                            }
                        }
                        if toggleDate {
                            DatePicker("Date", selection: $newTaskDate, displayedComponents: .date)
                                .datePickerStyle(GraphicalDatePickerStyle())
                        }
                        Toggle(isOn: $toggleTime) {
                            HStack {
                                Image(systemName: "clock")
                                Text("Time")
                            }
                        }
                        .onChange(of: toggleTime) {
                            if toggleTime && !toggleDate {
                                toggleDate = true
                            }
                        }
                        if toggleTime {
                            DatePicker("Time", selection: $newTaskDate, displayedComponents: .hourAndMinute)
                                .datePickerStyle(WheelDatePickerStyle())
                        }
                    }
                }
                .navigationBarTitle("New Task", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add Task") {
                            if !newTaskName.isEmpty {
                                let newTask = TaskItem(name: newTaskName, note: newTaskNote, date: newTaskDate)
                                todoList.tasks.append(newTask)
                                creatingTask = false
                                newTaskName = ""
                                newTaskNote = ""
                            }
                        } 
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Close") {
                            creatingTask = false
                            newTaskName = ""
                            newTaskNote = ""
                        }
                    }
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
}


