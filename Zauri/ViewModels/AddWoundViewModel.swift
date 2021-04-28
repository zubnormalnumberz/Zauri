//
//  AddWoundViewModel.swift
//  Zauri
//
//  Created by Oihan Arroyo on 13/04/2021.
//

import Foundation
import Combine
import FirebaseFirestore

class AddWoundViewModel: ObservableObject {
    
    @Published var bodyPartString: String = BodyPart(rawValue: 0)!.string
    @Published var bodyPartID: Int = 0
    @Published var selectedWoundTypeIndex = WoundType.ArterialUlcer.rawValue
    @Published var comment: String = ""
    @Published var patientId: String = ""
    @Published var userId: String = ""
    
    private var db = Firestore.firestore()
    
    var viewDismissalModePublisher = PassthroughSubject<Bool, Never>()
    private var shouldDismissView = false {
        didSet {
            viewDismissalModePublisher.send(shouldDismissView)
        }
    }
    
    func saveWound() {
        let docData: [String: Any] = [
            "patientId": patientId,
            "bodyPart": bodyPartID,
            "comment": comment,
            "createdBy": userId,
            "resolve": false,
            "woundType": selectedWoundTypeIndex,
            "creationDate": Timestamp(date: Date()),
            "measuremenetQuantity": 0
        ]
        
        var ref: DocumentReference? = nil
        ref = db.collection("wounds").addDocument(data: docData) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        self.shouldDismissView = true
    }
    
    func getBodyPart() -> Int {
        return self.bodyPartID
    }
}
