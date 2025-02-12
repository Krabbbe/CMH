import SwiftUI

struct SingleView: View {
    @State private var rootFolder = Folder(name: "Folders", subfolders: [
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
