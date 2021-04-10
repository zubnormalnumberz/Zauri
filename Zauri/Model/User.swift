//
//  User.swift
//  Zauri
//
//  Created by Oihan Arroyo on 05/04/2021.
//

import Foundation

struct User: Codable {
    var userID: String
    var email: String?
    
    init(userID: String, email: String?) {
        self.userID = userID
        self.email = email
    }
}
