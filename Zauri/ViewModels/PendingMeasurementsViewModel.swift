//
//  PendingMeasurementsViewModel.swift
//  Zauri
//
//  Created by Oihan Arroyo on 09/05/2021.
//

import Foundation
import FirebaseFirestore

class PendingMeasurementsViewModel: ObservableObject {
    
    @Published var downloading: Bool = false
    @Published var asigned: Bool = false
    @Published var measurements = [PendingMeasurements]()
    private var db = Firestore.firestore()
    
    func getPendingMeasurementsData(userId: String) {
        downloading = true
        db.collection("pendingMeasurements").whereField("userId", isEqualTo: userId).order(by: "creationDate", descending: false).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
                
            self.measurements = documents.map { (queryDocumentSnapshot) -> PendingMeasurements in
                    
                let data = queryDocumentSnapshot.data()
                let measurementID = queryDocumentSnapshot.documentID
                let userId = data["userId"] as? String ?? ""
                let treatment = data["comment"] as? String ?? ""
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
                    points.append(CGPoint(x: (xPoints[index]*0.75)+40, y: (yPoints[index]*0.75)+15))
                }

                return PendingMeasurements(measurementID: measurementID, userID: userId, width: 0, height: 0, area: area, perimeter: perimeter, imageURL: imageURL, points: points, treatment: treatment, dressingType: dressingType, creationDate: creationDate, treatmentEdit: "", editDate: Date())
            }
            self.downloading = false
        }
    }
    
}
