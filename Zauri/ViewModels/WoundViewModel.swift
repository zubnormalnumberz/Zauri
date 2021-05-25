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
import Combine

class WoundViewModel: ObservableObject{
    @Published var measurements = [WoundMeasurement]()
    @Published var dates = [Double]()
    @Published var areas = [Double]()
    @Published var userId: String = ""
    @Published var currentIndex: Int = 0
    @Published var downloading: Bool = false
    @Published var showDeleteMsgToast: Bool = false
    private var db = Firestore.firestore()
    private let storage = Storage.storage().reference()
    
    var viewDismissalModePublisher = PassthroughSubject<Bool, Never>()
    private var shouldDismissView = false {
        didSet {
            viewDismissalModePublisher.send(shouldDismissView)
        }
    }
    
    
    func fetchMeasurementsData(wound: Wound) {
        print("WOUND: \(wound.woundID)")
        downloading = true
        db.collection("measurements").whereField("woundId", isEqualTo: wound.woundID).order(by: "creationDate", descending: false).getDocuments() { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
                
            self.measurements = documents.map { (queryDocumentSnapshot) -> WoundMeasurement in
                let data = queryDocumentSnapshot.data()
                let measurementID = queryDocumentSnapshot.documentID
                print("Measurement: \(measurementID)")
                let patientId = data["patientId"] as? String ?? ""
                let userId = data["userId"] as? String ?? ""
                let woundId = data["woundId"] as? String ?? ""
                let treatment = data["comment"] as? String ?? ""
                let timestamp: Timestamp = data["creationDate"] as! Timestamp
                let creationDate: Date = timestamp.dateValue()
                let imageURL = data["imageURL"] as? String ?? ""
                let area = data["area"] as? Double ?? 0
                let perimeter = data["perimeter"] as? Double ?? 0
                let dressingType = data["dressingType"] as? Int ?? 0
                let xPoints = data["drawX"] as? [Double] ?? [0]
                let yPoints = data["drawY"] as? [Double] ?? [0]
                var points_small = [CGPoint]()
                var points = [CGPoint]()
                for (index, _) in xPoints.enumerated(){
                    points_small.append(CGPoint(x: (xPoints[index]*0.75)+40, y: (yPoints[index]*0.75)+15))
                    points.append(CGPoint(x: xPoints[index], y: yPoints[index]))
                }

                return WoundMeasurement(measurementID: measurementID, woundID: woundId, patientID: patientId, userID: userId, width: 0, height: 0, area: area, perimeter: perimeter, imageURL: imageURL, points_small: points_small, points: points, treatment: treatment, dressingType: dressingType, creationDate: creationDate, treatmentEdit: "", editDate: Date())
            }
            self.getCreatorName()
            self.downloading = false
            self.getChartDateData()
            self.getChartAreaData()
        }
    }
    
    func getCreatorName() {
        for (index, item) in self.measurements.enumerated() {
            let docRef = db.collection("users").document(item.userID)
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let data = document.data()
                    let name = data?["name"] as? String ?? ""
                    let surname = data?["surname"] as? String ?? ""
                    self.measurements[index].userID = "\(name) \(surname)"
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
    
    func getChartDateData() {
        for item in self.measurements {
            self.dates.append(item.creationDate.timeIntervalSinceReferenceDate)
        }
    }
    
    func deleteMeasurement() {
        let imageRef = storage.child(measurements[self.currentIndex].getImageURLFormatted())
        let woundRef = self.db.collection("wounds").document(measurements[self.currentIndex].woundID)
        let measurementRef = self.db.collection("measurements").document(measurements[self.currentIndex].measurementID)
        imageRef.delete { error in
            if error != nil {
          } else {
            measurementRef.delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    woundRef.updateData([
                        "measurementQ": FieldValue.increment(Int64(-1))
                    ])
                    self.shouldDismissView = true
                }
            }
          }
        }
    }
    
    func getChartAreaData() {
        for item in self.measurements {
            self.areas.append(item.area)
        }
    }
}
