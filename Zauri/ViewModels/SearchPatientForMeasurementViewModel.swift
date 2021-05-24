//
//  SearchPatientForMeasurementViewModel.swift
//  Zauri
//
//  Created by Oihan Arroyo on 04/05/2021.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import Combine

class SearchPatientForMeasurementViewModel: ObservableObject {
    
    var patients = [Patient]()
    @Published var searchText: String = ""
    @Published var searched: Bool = false
    @Published var searching: Bool = false
    
    @Published var image: UIImage? = UIImage(named: "arm")
    @Published var points: [CGPoint] = []
    @Published var scale: Scale = Scale(unit: 1, measureUnit: "cm", scale: [])
    @Published var userID: String = ""
    @Published var treatment: String = ""
    @Published var dressingType: Int = 0
    
    @Published private var selectedWound: Wound = Wound(woundID: "", pacientID: "String", createdBy: "String", resolved: true, comment: "String", commentEdited: "String", creationDate: Date(), woundType: 1, bodyPart: 1, measurementQuantity: 1)
    @Published private var selectedPatient: Patient = Patient(patientID: "String", name: "String", surname1: "String", surname2: "String", sex: true, dateBirth: Date(), cic: 1, phone: 1)
    
    var defaultWound: Wound = Wound(woundID: "", pacientID: "String", createdBy: "String", resolved: true, comment: "String", commentEdited: "String", creationDate: Date(), woundType: 1, bodyPart: 1, measurementQuantity: 1)
    var defaultPatient: Patient = Patient(patientID: "String", name: "String", surname1: "String", surname2: "String", sex: true, dateBirth: Date(), cic: 1, phone: 1)
    
    var viewDismissalModePublisher = PassthroughSubject<Bool, Never>()
    private var shouldDismissView = false {
        didSet {
            viewDismissalModePublisher.send(shouldDismissView)
        }
    }
    
    let db = Firestore.firestore()
    private let storage = Storage.storage().reference()
    
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
    
    func saveMeasurement(flagIsPendingMeasurement: Bool) {
        
        let uuid = UUID().uuidString
        let imageRef = storage.child("images/\(uuid).png");
        imageRef.putData((image?.jpegData(compressionQuality: 1))!, metadata: nil) { (storageMetadata, error) in
            guard error == nil else{
                print("Failed to upload")
                return
            }
            
            imageRef.downloadURL { (url, error) in
                guard let url = url, error == nil else{
                    print("Failed to upload")
                    return
                }
                
                let imageURL = url.absoluteString
                flagIsPendingMeasurement ? self.savePendingMeasurementData(imageURL: imageURL) : self.saveMeasurementData(imageURL: imageURL)
            }
        }
    }
    
    func saveMeasurementData(imageURL: String) {
        
        var arrayPointsX = [Double]()
        var arrayPointsY = [Double]()
        
        for item in points {
            arrayPointsX.append(Double(item.x))
            arrayPointsY.append(Double(item.y))
        }
        
        let docData: [String: Any] = [
            "woundId": selectedWound.woundID,
            "patientId": selectedPatient.patientID,
            "userId": userID,
            "creationDate": Timestamp(date: Date()),
            "imageURL": imageURL,
            "comment": treatment,
            "dressingType": dressingType,
            "area": Double(scale.getArea(points: points)) ?? 0,
            "perimeter": Double(scale.getPerimeter(points: points)) ?? 0,
            "drawX": arrayPointsX,
            "drawY": arrayPointsY
        ]
        
        var ref: DocumentReference? = nil
        ref = db.collection("measurements").addDocument(data: docData) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                let woundRef = self.db.collection("wounds").document(self.selectedWound.woundID)
                woundRef.updateData([
                    "measurementQ": FieldValue.increment(Int64(1))
                ])
            }
        }
        self.shouldDismissView = true
    }
    
    func savePendingMeasurementData(imageURL: String) {
        
        var arrayPointsX = [Double]()
        var arrayPointsY = [Double]()
        
        for item in points {
            arrayPointsX.append(Double(item.x))
            arrayPointsY.append(Double(item.y))
        }
        
        let docData: [String: Any] = [
            "userId": userID,
            "creationDate": Timestamp(date: Date()),
            "imageURL": imageURL,
            "comment": treatment,
            "dressingType": dressingType,
            "area": Double(scale.getArea(points: points)) ?? 0,
            "perimeter": Double(scale.getPerimeter(points: points)) ?? 0,
            "drawX": arrayPointsX,
            "drawY": arrayPointsY
        ]
        
        var ref: DocumentReference? = nil
        ref = db.collection("pendingMeasurements").addDocument(data: docData) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        self.shouldDismissView = true
    }
}
