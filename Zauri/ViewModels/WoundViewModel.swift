//
//  WoundViewModel.swift
//  Zauri
//
//  Created by Oihan Arroyo on 02/05/2021.
//

import Foundation
import FirebaseFirestore
import SwiftUI
import FirebaseStorage

class WoundViewModel: ObservableObject{
    @Published var measurements = [WoundMeasurement]()
    @Published var downloading: Bool = false
    private var db = Firestore.firestore()
    private let storage = Storage.storage().reference()
    
    
    func fetchMeasurementsData(wound: Wound) {
        downloading = true
        db.collection("measurements").whereField("woundId", isEqualTo: wound.woundID).order(by: "creationDate", descending: false).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
                
            self.measurements = documents.map { (queryDocumentSnapshot) -> WoundMeasurement in
                    
                let data = queryDocumentSnapshot.data()
                let measurementID = queryDocumentSnapshot.documentID
                let patientId = data["patientId"] as? String ?? ""
                let userId = data["userId"] as? String ?? ""
                let woundId = data["woundId"] as? String ?? ""
                let treatment = data["treatment"] as? String ?? ""
                let timestamp: Timestamp = data["creationDate"] as! Timestamp
                let creationDate: Date = timestamp.dateValue()
                let imageURL = data["imageURL"] as? String ?? ""
                let area = data["area"] as? Double ?? 0
                let perimeter = data["perimeter"] as? Double ?? 0
                let dressingType = data["dressingType"] as? Int ?? 0
                let xPoints = data["drawX"] as? [Double] ?? [0]
                let yPoints = data["drawY"] as? [Double] ?? [0]
                var points = [CGPoint]()
                for (index, _) in xPoints.enumerated(){
                    points.append(CGPoint(x: xPoints[index], y: yPoints[index]))
                }

                return WoundMeasurement(measurementID: measurementID, woundID: woundId, patientID: patientId, userID: userId, width: 0, height: 0, area: area, perimeter: perimeter, imageURL: imageURL, points: points, treatment: treatment, dressingType: dressingType, creationDate: creationDate, treatmentEdit: "", editDate: Date())
            }
            self.downloading = false
        }
    }
}
