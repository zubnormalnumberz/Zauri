//
//  AsignPatientViewModel.swift
//  Zauri
//
//  Created by Oihan Arroyo on 09/05/2021.
//

import Foundation
import FirebaseFirestore

class AsignPatientViewModel: ObservableObject {
    var patients = [Patient]()
    @Published var searchText: String = ""
    @Published var searched: Bool = false
    @Published var searching: Bool = false
    
    @Published var pendingMeasurement = PendingMeasurements(measurementID: "String", userID: "String", width: 1, height: 1, area: 1, perimeter: 1, imageURL: "String", points: [], treatment: "String", dressingType: 1, creationDate: Date(), treatmentEdit: "String", editDate: Date())
    
    @Published var selectedWound: Wound = Wound(woundID: "", pacientID: "String", createdBy: "String", resolved: true, comment: "String", commentEdited: "String", creationDate: Date(), woundType: 1, bodyPart: 1, measurementQuantity: 1)
    @Published var selectedPatient: Patient = Patient(patientID: "String", name: "String", surname1: "String", surname2: "String", sex: true, dateBirth: Date(), cic: 1, phone: 1)
    
    var defaultWound: Wound = Wound(woundID: "", pacientID: "String", createdBy: "String", resolved: true, comment: "String", commentEdited: "String", creationDate: Date(), woundType: 1, bodyPart: 1, measurementQuantity: 1)
    var defaultPatient: Patient = Patient(patientID: "String", name: "String", surname1: "String", surname2: "String", sex: true, dateBirth: Date(), cic: 1, phone: 1)
    
    let db = Firestore.firestore()
    
    func fetchPatientsData() {
        self.searching = true
        patients.removeAll()
        db.collection("patients")
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                for document in documents {
                    let data = document.data()
                    let patientID = document.documentID
                    let name = data["name"] as? String ?? ""
                    let surname1 = data["surname1"] as? String ?? ""
                    let surname2 = data["surname2"] as? String ?? ""
                    let timestamp: Timestamp = data["dateBirth"] as! Timestamp
                    let date: Date = timestamp.dateValue()
                    let sex = data["sex"] as? Bool ?? false
                    let cic = data["cic"] as? Int ?? 0
                    let phone = data["phone"] as? Int ?? 0
                    
                    if name.contains(self.searchText) || surname1.contains(self.searchText) || String(cic).contains(self.searchText){
                        self.patients.append(Patient(patientID: patientID, name: name, surname1: surname1, surname2: surname2, sex: sex, dateBirth: date, cic: cic, phone: phone))
                    }
                }
                self.searched = true
                self.searching = false
        }
    }
    
    func saveMeasurementData() {
        
        var arrayPointsX = [Double]()
        var arrayPointsY = [Double]()
        
        for item in pendingMeasurement.points {
            arrayPointsX.append(Double(item.x))
            arrayPointsY.append(Double(item.y))
        }
        
        let docData: [String: Any] = [
            "patientId": selectedPatient.patientID,
            "woundId": selectedWound.woundID,
            "userId": pendingMeasurement.userID,
            "creationDate": Timestamp(date: pendingMeasurement.creationDate),
            "imageURL": pendingMeasurement.imageURL,
            "comment": pendingMeasurement.treatment,
            "dressingType": pendingMeasurement.dressingType,
            "area": pendingMeasurement.area,
            "perimeter": pendingMeasurement.perimeter,
            "drawX": arrayPointsX,
            "drawY": arrayPointsY
        ]
        
        db.collection("measurements").document(pendingMeasurement.measurementID).setData(docData) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                let woundRef = self.db.collection("wounds").document(self.selectedWound.woundID)
                let pendingMeasurementRef = self.db.collection("pendingMeasurements").document(self.pendingMeasurement.measurementID)
                woundRef.updateData([
                    "measurementQ": FieldValue.increment(Int64(1))
                ])
                pendingMeasurementRef.delete() { err in
                    if let err = err {
                        print("Error removing document: \(err)")
                    } else {
                        print("Document successfully removed!")
                    }
                }
            }
        }
    }
}
