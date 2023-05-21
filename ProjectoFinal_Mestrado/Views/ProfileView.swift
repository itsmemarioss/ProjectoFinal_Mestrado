//
//  ProfileView.swift
//  ProjectoFinal_Mestrado
//
//  Created by Mario Santos Sousa on 18/05/2023.
//

import SwiftUI

struct ProfileView: View {
    
    @State var weight: Double = profile.getWeight()
    @State var useKmH: Bool = profile.useKmH()
    @State private var selectedOption = 0
    
    // Save data to UserDefaults
    func saveData() {
        profile.saveData(weight: weight, useKmH: useKmH)
    }
    
    var body: some View {
        
        VStack(alignment: .center) {
            
            HStack(alignment: .center, spacing: 16) {
                Text("Weight")
                TextField("Type your weight", value: $weight, formatter: NumberFormatters.twoFractionDigits)
            }
            
            
            Group {
                Toggle(isOn: Binding(
                    get: { self.useKmH == true },
                    set: { self.useKmH = $0 ? true : false }
                )) {
                    Text("Use Km/h")
                }
                
                Toggle(isOn: Binding(
                    get: { self.useKmH == false },
                    set: { self.useKmH = $0 ? false : true }
                )) {
                    Text("Use m/s")
                }
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
