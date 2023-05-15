

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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
