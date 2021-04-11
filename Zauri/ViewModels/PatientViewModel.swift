//
//  PatientViewModel.swift
//  Zauri
//
//  Created by Oihan Arroyo on 11/04/2021.
//

import Foundation
import FirebaseFirestore

class PatientViewModel: ObservableObject {
    
    @Published var wounds = [Wound]()
    
    private var db = Firestore.firestore()
    
    /*func fetchWoundsData() {
            db.collection("patients").addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                self.wounds = documents.map { (queryDocumentSnapshot) -> Wound in
                    
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
            }
        }*/
}
