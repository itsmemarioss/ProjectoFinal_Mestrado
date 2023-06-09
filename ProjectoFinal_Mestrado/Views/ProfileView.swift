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
    
   // @ObservedObject var input = NumbersOnly()
    
    // Save data to UserDefaults
    func saveData() {
        profile.saveData(weight: weight, useKmH: useKmH)
    }
    
    var body: some View {
    
        
        ZStack(){
           
           Image("running-background2") .resizable()
           
           
            VStack(alignment: .center) {
                
                
                HStack(alignment: .center){
                    
                    Text("CONFIGURATIONS")
                        .foregroundColor(Color.white)
                        .bold()
                }
              
               
               
                HStack(alignment: .center, spacing: 16) {
                    
                    Text("Weight (Kg)").foregroundColor(Color.white).bold()
                    
                    TextField("Type your weight",
                        value: $weight, formatter:NumberFormatters.twoFractionDigits)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(Color.black)
                        
                    
                }
                
                Group {
                    
                    Toggle(isOn: Binding(
                        get: { self.useKmH == true },
                        set: { self.useKmH = $0 ? true : false }
                    ))
                    {
                        Text("Use Km/h").bold()
                    }
                    
                    Toggle(isOn: Binding(
                        get: { self.useKmH == false },
                        set: { self.useKmH = $0 ? false : true }
                    )) {
                        Text("Use m/s").bold()
                        
                    }
                }.foregroundColor(Color.white)
                
                
                Button(action: {saveData()} )
                {
                    Text("Save")
                    .padding()
                    .background(Color.white)
                    .foregroundColor(Color.black)
                }
                .buttonStyle(ThreeD())
                .frame(width: 80, height: 40)
               
            }
            .padding(50)
            .background(Color.black.opacity(0.6))
            
              
           
       }.ignoresSafeArea()
        
        
        
            
    }
}

struct ThreeD: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        
        ZStack{
            
            let offset : CGFloat = 5
            
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(Color.green)
                .offset(y: offset)
            
            
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(Color.white)
                .offset(y: configuration.isPressed ? offset : 0)
            
            
            configuration.label.offset(y: configuration.isPressed ? offset : 0)
            
        }
        .compositingGroup()
        .shadow(radius: 5 , y: 5)
        
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

