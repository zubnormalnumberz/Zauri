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
    var name: String
    var surname: String
    
    init(userID: String, email: String?, name: String, surname: String) {
        self.userID = userID
        self.email = email
        self.name = name
        self.surname = surname
    }
    
    func getFullName() -> String {
        "\(name) \(surname)"
    }
}
