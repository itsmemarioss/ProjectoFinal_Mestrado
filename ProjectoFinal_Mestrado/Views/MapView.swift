

import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var l = location
    
    @State private var timer: Timer?
    @State var button = "play.fill"
    @State var color = Color.green
    @State var infoMessage = ""
    @State var strokeColor = Color(red: 70/255, green: 148/255, blue: 70/255)
    @State var progress : CGFloat = 0.0
    
    var body: some View {
        ZStack{
            
            CustomMapView(l: l).onAppear(perform: {
                l.askPermission()
            })
            Text(infoMessage).font(.custom("Montserrat-Italic", size: 52)).foregroundColor(.gray)
            Spacer()
            ZStack{
                HStack{
                    Image(systemName: button).font(.system(size: 42))
                }
                
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(strokeColor)
                
            }
            .frame(width: 75, height: 75, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(50.0)
            .position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height - 150.0)
            .onTapGesture(perform: {
                if(button == "play.fill"){
                
                    l.askPermission()
                    l.getLocation()
                    stats.startWorkout()
                    button = "pause.fill"
                    color = Color.yellow
                    infoMessage = "Start"
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (_) in
                        infoMessage = ""
                    })
                }
                else{
                    button = "play.fill"
                    color = Color.green
                    infoMessage = "Paused"
                    l.stopLocation()
                    stats.pauseWorkout()

                }
            })
            .onLongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity, pressing: handlePressing) {}
            
            
        }
    }
    
    func handlePressing(_ isPressed: Bool) {
        if(isPressed){
            if(button=="pause.fill"){
                button = "stop.fill"
                strokeColor = Color(red: 255/255, green: 0/255, blue: 0/255)
                timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (_) in
                    progress += 0.01
                })
            }
            
            
        }else{
            //MARK: - handle if unpressed
            print("Unpressed")
            
            if(progress >= 1){
                button = "stop.fill"
                color = Color.red
                infoMessage = "Finish"
                Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { (_) in
                    infoMessage = ""
                    color = Color.green
                    button = "play.fill"
                })
                strokeColor = Color(red: 255/255, green: 0/255, blue: 0/255)
                l.stopLocation()
                l.clearLocations()
                stats.stopWorkout()
            }
            progress = 0
            timer?.invalidate()
            
        }
    }
    
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
