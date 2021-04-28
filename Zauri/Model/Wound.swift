//
//  Wound.swift
//  Zauri
//
//  Created by Oihan Arroyo on 11/04/2021.
//

import Foundation

struct Wound: Codable {
    var woundID: String
    var pacientID: String
    var createdBy: String
    var resolved: Bool
    var comment: String
    var commentEdited: String
    var creationDate: Date
    var woundType: Int
    var bodyPart: Int
    var measurementQuantity: Int
    
    init(woundID: String, pacientID: String, createdBy: String, resolved: Bool, comment: String, commentEdited: String, creationDate: Date, woundType: Int, bodyPart: Int, measurementQuantity: Int) {
        self.woundID = woundID
        self.pacientID = pacientID
        self.createdBy = createdBy
        self.resolved = resolved
        self.comment = comment
        self.commentEdited = commentEdited
        self.creationDate = creationDate
        self.woundType = woundType
        self.bodyPart = bodyPart
        self.measurementQuantity = measurementQuantity
    }
    
    func getDateFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: creationDate)
    }
    
}
