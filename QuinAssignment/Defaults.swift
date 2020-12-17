//
//  Defaults.swift
//  QuinAssignment
//
//  Created by Praveen Kumar on 16/12/20.
//

import Foundation

class Defaults {
    
    static var isLoggedIn : Bool {
        set {
            UserDefaults.standard.setValue(newValue, forKey: "isLoggedIn")
        }
        get {
            guard let value = UserDefaults.standard.value(forKey: "isLoggedIn") as? Bool else { return false }
            return value
        }
    }
    
}

class Auth : ObservableObject {
    @Published var loggedIn : Bool = Defaults.isLoggedIn
}
