//
//  Measurement.swift
//  Zauri
//
//  Created by Oihan Arroyo on 02/05/2021.
//

import Foundation
import UIKit

struct WoundMeasurement: Codable {
    var measurementID: String
    var woundID: String
    var patientID: String
    var userID: String
    var width: Double
    var height: Double
    var area: Double
    var perimeter: Double
    var imageURL: String
    var points_small: [CGPoint]
    var points: [CGPoint]
    var treatment: String
    var dressingType: Int
    var creationDate: Date
    var treatmentEdit: String
    var editDate: Date
    
    init(measurementID: String, woundID: String, patientID: String, userID: String, width: Double, height: Double, area: Double, perimeter: Double, imageURL: String, points_small: [CGPoint], points: [CGPoint], treatment: String, dressingType: Int, creationDate: Date, treatmentEdit: String, editDate: Date) {
        self.measurementID = measurementID
        self.woundID = woundID
        self.patientID = patientID
        self.userID = userID
        self.width = width
        self.height = height
        self.area = area
        self.perimeter = perimeter
        self.imageURL = imageURL
        self.points_small = points_small
        self.points = points
        self.treatment = treatment
        self.dressingType = dressingType
        self.creationDate = creationDate
        self.treatmentEdit = treatmentEdit
        self.editDate = editDate
    }
    
    func getDateFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: creationDate)
    }
    
    func getTimeFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: creationDate)
    }
    
    func getDateLongFormat() -> String {
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy HH:mm"
        let now = df.string(from: self.creationDate)
        return now

    }
    
    func calculateDateDifference() -> Bool {
        let now = Date()
        let numberOfHours = Calendar.current.dateComponents([.hour], from: creationDate, to: now)
        return numberOfHours.hour! > 24
    }
    
    func getImageURLFormatted() -> String {
        let basePath = "https://firebasestorage.googleapis.com/v0/b/zauri-e0160.appspot.com/o/"
        let path = imageURL.replacingOccurrences(of: basePath, with: "")
        let components = path.components(separatedBy: "?")
        var text = components[0]
        text = text.replacingOccurrences(of: "%2F", with: "/")
        return text
    }
}
