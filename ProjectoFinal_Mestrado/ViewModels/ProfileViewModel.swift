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
    
    // Salva dados no UserDefaults
    func saveData(weight: Double, useKmH: Bool) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(weight, forKey: WEIGHT_KEY)
        userDefaults.set(useKmH, forKey: USE_KM_H_KEY)
        userDefaults.synchronize()
        
        //notifica os observers que os dados foram alterados
        objectWillChange.send()
    }
    
    func getWeight() -> Double {
        return UserDefaults.standard.double(forKey: WEIGHT_KEY)
    }
    
    func useKmH() -> Bool {
        return UserDefaults.standard.bool(forKey: USE_KM_H_KEY);
    }
    
    /**
        Essa função retorna a taxa de conversão para Km/h de acordo com as configurações do usuário.
        O GPS retorna os dados em m/s, se não for preciso converter mantem se o mesmo valor.
     */
    func getSpeedUnit() -> Double {
        return useKmH() ? 3.6 : 1
    }
    
    /**
        Função que retorna a string apropriada para apresentar os dados de forma uniforme.
        Essa função é utilizada nas views para apresentar dados formatados.
     */
    func stringFormat() -> String {
        let unit = useKmH() ? "km/h" : "m/s"
        return "%.2f \(unit)"
    }
    
}
