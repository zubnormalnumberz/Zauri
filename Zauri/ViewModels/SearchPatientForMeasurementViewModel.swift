//
//  SearchPatientForMeasurementViewModel.swift
//  Zauri
//
//  Created by Oihan Arroyo on 04/05/2021.
//

import Foundation
import FirebaseFirestore

class SearchPatientForMeasurementViewModel: ObservableObject {
    
    var patients = [Patient]()
    @Published var searchText: String = ""
    @Published var searched: Bool = false
    @Published var searching: Bool = false
    @Published var kaixo: String = "dsg"
    @Published private var selectedWound: Wound = Wound(woundID: "", pacientID: "String", createdBy: "String", resolved: true, comment: "String", commentEdited: "String", creationDate: Date(), woundType: 1, bodyPart: 1, measurementQuantity: 1)
    @Published private var selectedPatient: Patient = Patient(patientID: "String", name: "String", surname1: "String", surname2: "String", sex: true, dateBirth: Date(), cic: 1, phone: 1)
    
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
    
    func updateSelectedPatient(patient: Patient) {
        self.selectedPatient = patient
    }
    
    func updateSelectedWound(wound: Wound) {
        self.selectedWound = wound
    }
    
    func getSelectedPatient() -> Patient {
        return self.selectedPatient
    }
    
    func getSelectedWound() -> Wound {
        return self.selectedWound
    }
}
