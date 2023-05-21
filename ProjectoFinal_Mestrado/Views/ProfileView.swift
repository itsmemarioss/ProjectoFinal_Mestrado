//
//  ProfileView.swift
//  ProjectoFinal_Mestrado
//
//  Created by Mario Santos Sousa on 18/05/2023.
//

import SwiftUI

struct ProfileView: View {
    
    @State var weight: Double = profile.getWeight()
    @State var speed: String = profile.getSpeedUnit()
    @State var distance: String = profile.getDistanceUnit()
    
    // Save data to UserDefaults
    func saveData() {
        profile.saveData(weight: weight, speedUnit: speed, distanceUnit: distance)
    }
    
    var body: some View {
        
        VStack(alignment: .center) {
            
            HStack(alignment: .center, spacing: 16) {
                Text("Weight")
                TextField("Type your weight", value: $weight, formatter: NumberFormatters.twoFractionDigits)
            }
            
            HStack(alignment: .center, spacing: 16) {
                Text("Distance unit")
                TextField("Chose distance", text: $distance)
            }
         
            HStack(alignment: .center, spacing: 16) {
                Text("Speed unit")
                TextField("Chose speed", text: $speed)
            }
            
            Button("Save"){
                saveData()
            }
        }.padding()
            
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

struct NumberFormatters {
    static var twoFractionDigits: Formatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.maximumFractionDigits = 2
        return formatter
    }
}
