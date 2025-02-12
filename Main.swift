import SwiftUI

struct Main: View {
    var body: some View {
        TabView {
            UebersichtView()
                .tabItem { 
                    Image(systemName: "calendar")
                    Text ("Übersicht")
                }
                .tag(1)
            
            SingleView()
                .tabItem { 
                    Image(systemName: "person.fill")
                    Text ("Single")
                }
                .tag(2)
            
            GroupView()
                .tabItem { 
                    Image(systemName: "person.3.fill")
                    Text ("Group")
                }
                .tag(3)
            
            SettingsView()
                .tabItem { 
                    Image(systemName: "gear")
                    Text ("Settings")
                }
                .tag(4)
        }
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
