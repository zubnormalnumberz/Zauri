//
//  SettingsViewModel.swift
//  Zauri
//
//  Created by Oihan Arroyo on 11/04/2021.
//

import Foundation

class SettingsViewModel: ObservableObject {
    
    @Published var userFullName: String = ""
    
    let userService = UserService()
        
    
}
