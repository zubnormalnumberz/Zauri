//
//  Patient.swift
//  Zauri
//
//  Created by Oihan Arroyo on 09/04/2021.
//

import Foundation

struct Patient: Codable {
    var patientID: String
    var name: String
    var surname1: String
    var surname2: String
    var sex: Bool
    var dateBirth: Date
    var cic: Int
    var phone: Int
    
    init(patientID: String, name: String, surname1: String, surname2: String, sex: Bool, dateBirth: Date, cic: Int, phone: Int) {
        self.patientID = patientID
        self.name = name
        self.surname1 = surname1
        self.surname2 = surname2
        self.sex = sex
        self.dateBirth = dateBirth
        self.cic = cic
        self.phone = phone
    }
    
    func getInitials() -> String {
        return String(self.name.prefix(1)+self.surname1.prefix(1)+self.surname2.prefix(1))
    }
    
    func dateToString() -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy/MM/dd"
        let now = df.string(from: self.dateBirth)
        return now
    }

    func getAge() -> Int {
        let now = Date()
        let diffs = Calendar.current.dateComponents([.year], from: self.dateBirth, to: now)
        return diffs.year ?? 0
    }
}
