

import SwiftUI

struct ContentView: View {
    
    private var statusVM: StatsViewModel
    private var locationVM: LocationViewModel
    
    init(statusVM: StatsViewModel) {
        self.statusVM = statusVM
        self.locationVM = LocationViewModel(stats: statusVM)
    }
    
    var body: some View {
        
        TabView{
            
            StatsView(statsobs: statusVM).tabItem {
                Image(systemName: "figure.walk")
                Text("Stats")
            }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            MapView(locationVM: locationVM, stats: statusVM).tabItem {
                Image(systemName: "map")
                Text("Map")
            }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            ProfileView().tabItem {
                Image(systemName: "person")
                Text("Profile")
            }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            RunsView().tabItem {
                Image(systemName: "list.dash")
                Text("Runs")
            }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
            
        }
        .accentColor(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(statusVM: StatsViewModel(context: PersistenceController.preview.container.viewContext))
            
    }
}
