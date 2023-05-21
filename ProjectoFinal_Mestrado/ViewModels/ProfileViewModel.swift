//
//  ProfileViewModel.swift
//  ProjectoFinal_Mestrado
//
//  Created by Mario Santos Sousa on 19/05/2023.
//

import Foundation

var profile = ProfileViewModel()

class ProfileViewModel: ObservableObject  {
    
    public let WEIGHT_KEY = "weightKey"
    public let SPEED_KEY = "speedKey"
    public let DISTANCE_KEY = "distanceKey"
    
    // Save data to UserDefaults
    func saveData(weight: Double, speedUnit: String, distanceUnit: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(weight, forKey: WEIGHT_KEY)
        userDefaults.set(speedUnit, forKey: SPEED_KEY)
        userDefaults.set(distanceUnit, forKey: DISTANCE_KEY)
        userDefaults.synchronize()
    }
    
    func getWeight() -> Double {
        return UserDefaults.standard.double(forKey: WEIGHT_KEY)
    }
    
    func getSpeedUnit() -> String {
        return UserDefaults.standard.string(forKey: SPEED_KEY) ?? "Km"
    }
    
    func getDistanceUnit() -> String {
        return UserDefaults.standard.string(forKey: DISTANCE_KEY) ?? "Km/h"
    }
}

