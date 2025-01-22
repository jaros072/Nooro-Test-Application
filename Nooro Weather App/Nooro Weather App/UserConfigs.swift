//
//  UserConfigs.swift
//  Nooro Weather App
//
//  Created by William Jaros on 1/22/25.
//

import Foundation

//Stores and retrieves the currently selected city from userdefaults.
class UserConfigs {
    static func storeCurrentCity(cityName: String) {
        UserDefaults.standard.setValue(cityName, forKey: Constants.currentlySelectedCityKey)
    }
    
    static func getCurrentCity() -> String? {
        return UserDefaults.standard.string(forKey: Constants.currentlySelectedCityKey)
    }
}
