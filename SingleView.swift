import SwiftUI

struct SingleView: View {
    @State private var rootSingle = Folder(name: "Folders", subfolders: [
        Folder(name: "Documents"),
        Folder(name: "Pictures"),
        Folder(name: "Downloads")
    ], todoLists: [
        TodoList(name: "1")
    ])
    
    var body: some View {
        NavigationStack {
            FolderView (folder: rootSingle)
        }
    }
}
