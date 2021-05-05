//
//  PatientsViewModel.swift
//  Zauri
//
//  Created by Oihan Arroyo on 11/04/2021.
//

import Foundation
import FirebaseFirestore
import SwiftUI

class PatientsViewModel: ObservableObject {
    
    @Published var patients = [Patient]()
    @Published var downloading: Bool = false
    var woundsIDs = [String]()
    var patientsIDs = [String]()
    @Published var userId: String = ""
    private var db = Firestore.firestore()
    
    func getWoundsData() {
        downloading = true
        db.collection("measurements").whereField("userId", isEqualTo: userId).addSnapshotListener() { (querySnapshot, err) in
                
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                for document in documents {
                    let data = document.data()
                    let woundId = data["woundId"] as? String ?? ""
                    self.woundsIDs.append(woundId)
                }
                if self.woundsIDs.count != 0 {
                    self.getPatientsId()
                }else{
                    self.downloading = false
                }
        }
    }
    
    func getPatientsId() {
        db.collection("wounds").whereField(FirebaseFirestore.FieldPath.documentID(), in: woundsIDs).whereField("resolve", isEqualTo: false).addSnapshotListener() { (querySnapshot, err) in
            
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            for document in documents {
                let data = document.data()
                let patientId = data["patientId"] as? String ?? ""
                self.patientsIDs.append(patientId)
            }
            if self.patientsIDs.count != 0 {
                self.fetchPatientsData()
            }else{
                self.downloading = false
            }
        }
    }
    
    func fetchPatientsData() {
        db.collection("patients").whereField(FirebaseFirestore.FieldPath.documentID(), in: patientsIDs).addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                self.patients = documents.map { (queryDocumentSnapshot) -> Patient in
                    let data = queryDocumentSnapshot.data()
                    let patientID = queryDocumentSnapshot.documentID
                    let name = data["name"] as? String ?? ""
                    let surname1 = data["surname1"] as? String ?? ""
                    let surname2 = data["surname2"] as? String ?? ""
                    let timestamp: Timestamp = data["dateBirth"] as! Timestamp
                    let date: Date = timestamp.dateValue()
                    let sex = data["sex"] as? Bool ?? false
                    let cic = data["cic"] as? Int ?? 0
                    let phone = data["phone"] as? Int ?? 0
                    
                    return Patient(patientID: patientID, name: name, surname1: surname1, surname2: surname2, sex: sex, dateBirth: date, cic: cic, phone: phone)
                }
            self.downloading = false
            }
        }
    
}
