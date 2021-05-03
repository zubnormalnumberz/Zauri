//
//  TreatmentViewModel.swift
//  Zauri
//
//  Created by Oihan Arroyo on 03/05/2021.
//

import Foundation
import SwiftUI
import Combine
import FirebaseFirestore
import FirebaseStorage

class TreatmentViewModel: ObservableObject {
    
    @Published var selectedDressingType = DressingType.GauzeDressing.rawValue
    @Published var comment: String = ""
    
    @Published var image: UIImage? = UIImage(named: "arm")
    @Published var points: [CGPoint] = []
    @Published var woundID: String = ""
    @Published var patientID: String = ""
    @Published var userID: String = ""
    @Published var scale: Scale = Scale(unit: 1, measureUnit: "cm", scale: [])
    
    private var db = Firestore.firestore()
    private let storage = Storage.storage().reference()
    
    var viewDismissalModePublisher = PassthroughSubject<Bool, Never>()
    private var shouldDismissView = false {
        didSet {
            viewDismissalModePublisher.send(shouldDismissView)
        }
    }
    
    func saveMeasurement() {
        
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
                self.saveMeasurementData(imageURL: imageURL)
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
            "patientId": patientID,
            "woundId": woundID,
            "userId": userID,
            "creationDate": Timestamp(date: Date()),
            "imageURL": imageURL,
            "comment": comment,
            "dressingType": selectedDressingType,
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
                let woundRef = self.db.collection("wounds").document(self.woundID)
                woundRef.updateData([
                    "measurementQ": FieldValue.increment(Int64(1))
                ])
            }
        }
        self.shouldDismissView = true
    }
    
}
