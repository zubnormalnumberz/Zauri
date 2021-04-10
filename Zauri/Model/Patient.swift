//
//  Patient.swift
//  Zauri
//
//  Created by Oihan Arroyo on 09/04/2021.
//

import Foundation

struct Patient: Codable {
    var patientID: Int
    var name: String
    var surname1: String
    var surname2: String
    var fullname: String
    var sex: Bool
    var dateBirth: Date
    var cic: String
    var phone: Int
}
