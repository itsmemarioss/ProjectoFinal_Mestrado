import SwiftUI

struct StatsView: View {
    
    @ObservedObject var statsobs = stats
    
    
    var body: some View {
        
       ZStack(){
           
           Image("running-background") .resizable()
           
           VStack(alignment: .center, spacing: 0){
               Text("Speed: \(statsobs.speed)")
               Text("Duration: \(statsobs.duration)")
               Text("Avg. Speed: \(statsobs.avg_speed)")
               Text("Distance: \(statsobs.distance)")
               Text("Calories: \(statsobs.calories)")
               
               
           }
           .background(Color.white)
           
           
       }.ignoresSafeArea()
            
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
