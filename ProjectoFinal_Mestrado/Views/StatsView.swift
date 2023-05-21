import SwiftUI

struct StatsView: View {
    
    @ObservedObject var statsobs = stats
    @ObservedObject var profileobs = profile
    
    var body: some View {
        
        var unit = profileobs.useKmH() ? "km/h" : "m/s"
        var formatString = "%.2f \(unit)"
        
        ZStack(){
           
           Image("running-background") .resizable()
           
           VStack(alignment: .center, spacing: 10){
               
               HStack(spacing: 5) {
                   VStack(alignment: .center, spacing: 10){
                       Text(String(format: formatString, statsobs.speed)).font(.headline).colorInvert()
                       Text("Speed").font(.subheadline).colorInvert()
                   }
                   .padding()
                   .background(Color.gray.opacity(0.5))
                   
                   VStack(alignment: .center, spacing: 10){
                       Text(String(format: formatString, statsobs.avg_speed)).font(.headline).colorInvert()
                       Text("Avg. Speed").font(.subheadline).colorInvert()
                   }
                   .padding()
                   .background(Color.gray.opacity(0.5))
                   
                   
               }
               
               VStack(alignment: .center, spacing: 10){
                   Text("\(statsobs.duration)").font(.headline).colorInvert()
                   Text("Elapsed time").font(.subheadline).colorInvert()
               }
               .padding()
               .background(Color.gray.opacity(0.5))
               
               HStack(spacing: 10) {
                   VStack(alignment: .center, spacing: 10){
                       Text(String(format: "%.2f Km", statsobs.distance) ).font(.headline).colorInvert()
                       Text("Distance").font(.subheadline).colorInvert()
                   }
                   .padding()
                   .background(Color.gray.opacity(0.5))
                   
                   VStack(alignment: .center){
                       Text(String(format: "%.2f ",statsobs.calories)).font(.headline).colorInvert()
                       Text("cal").font(.headline).font(.subheadline).colorInvert()
                   }
                   .padding()
                   .background(Color.gray.opacity(0.5))
                   
               }
           }
           
       }.ignoresSafeArea()
            
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
