

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            StatsView().tabItem {
                Image(systemName: "figure.walk")
                Text("Stats")
            }
            MapView().tabItem {
                Image(systemName: "map")
                Text("Map")
            }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            ProfileView().tabItem {
                Image(systemName: "person")
                Text("Profile")
            }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
        }.background(Color.white.opacity(0.5))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
