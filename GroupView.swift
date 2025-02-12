import SwiftUI

struct GroupView: View {
    @State private var rootFolder = Folder(name: "Groups", subfolders: [
        Folder(name: "Documents"),
        Folder(name: "Pictures"),
        Folder(name: "Downloads")
    ])
    
    var body: some View {
        NavigationStack {
            FolderView(folder: rootFolder)
        }
    }
}
