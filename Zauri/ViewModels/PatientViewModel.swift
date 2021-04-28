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
    @Published var downloading = false
    
    private var db = Firestore.firestore()
    
    func fetchWoundsData(patient: Patient) {
        downloading = true
        db.collection("wounds").whereField("patientId", isEqualTo: patient.patientID).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
                
            self.wounds = documents.map { (queryDocumentSnapshot) -> Wound in
                    
                let data = queryDocumentSnapshot.data()
                let woundID = queryDocumentSnapshot.documentID
                let patientId = data["patientId"] as? String ?? ""
                let comment = data["comment"] as? String ?? ""
                let commentEdited = ""
                let timestamp: Timestamp = data["creationDate"] as! Timestamp
                let creationDate: Date = timestamp.dateValue()
                let resolved = data["resolve"] as? Bool ?? false
                let createdBy = data["createdBy"] as? String ?? ""
                let bodyPart = data["bodyPart"] as? Int ?? 0
                let woundType = data["wountType"] as? Int ?? 0
                let commentIntroDate = Date()
                    
                return Wound(woundID: woundID, pacientID: patientId, createdBy: createdBy, resolved: resolved, comment: comment, commentEdited: commentEdited, creationDate: creationDate, woundType: woundType, bodyPart: bodyPart, commentIntroDate: commentIntroDate)
            }
            self.downloading = false
        }
    }
}
