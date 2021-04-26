//
//  SearchPatientViewModel.swift
//  Zauri
//
//  Created by Oihan Arroyo on 23/04/2021.
//

import Foundation
import FirebaseFirestore

class SearchPatientViewModel: ObservableObject {
    
    @Published var patients = [Patient]()
    @Published var searchText: String = ""
    @Published var searched: Bool = false
    @Published var searching: Bool = false
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
}
