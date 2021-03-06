//
//  LoginViewModel.swift
//  Zauri
//
//  Created by Oihan Arroyo on 09/04/2021.
//

import Foundation
import Combine
import FirebaseAuth

class LoginViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var errorMsg: String = ""
    @Published var loading: Bool = false
    @Published var showingAlert = false
    
    let userService = UserService()
        
    func login() {
        self.loading = true
        let completeEmail = username + "@osakidetza.net"
        userService.signIn(email: completeEmail, password: password) { (result, err) in
            if err != nil {
                self.loading = false
                self.showingAlert = true
            }
        }
    }
}
