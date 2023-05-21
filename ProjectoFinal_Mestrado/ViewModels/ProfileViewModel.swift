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
    public let USE_KM_H_KEY = "useKmHKey"
    
    // Save data to UserDefaults
    func saveData(weight: Double, useKmH: Bool) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(weight, forKey: WEIGHT_KEY)
        userDefaults.set(useKmH, forKey: USE_KM_H_KEY)
        userDefaults.synchronize()
    }
    
    func getWeight() -> Double {
        return UserDefaults.standard.double(forKey: WEIGHT_KEY)
    }
    
    func useKmH() -> Bool {
        return UserDefaults.standard.bool(forKey: USE_KM_H_KEY);
    }
    
}

