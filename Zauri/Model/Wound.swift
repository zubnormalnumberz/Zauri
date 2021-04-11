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
    var woundType: String
    var bodyPart: String
    var commentIntroDate: Date
    
    init(woundID: String, pacientID: String, createdBy: String, resolved: Bool, comment: String, commentEdited: String, creationDate: Date, woundType: String, bodyPart: String, commentIntroDate: Date) {
        self.woundID = woundID
        self.pacientID = pacientID
        self.createdBy = createdBy
        self.resolved = resolved
        self.comment = comment
        self.commentEdited = commentEdited
        self.creationDate = creationDate
        self.woundType = woundType
        self.bodyPart = bodyPart
        self.commentIntroDate = commentIntroDate
    }
    
}
