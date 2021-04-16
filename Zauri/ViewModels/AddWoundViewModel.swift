//
//  AddWoundViewModel.swift
//  Zauri
//
//  Created by Oihan Arroyo on 13/04/2021.
//

import Foundation

class AddWoundViewModel: ObservableObject {
    
    @Published var bodyPartString: String = "Abdomen"
    @Published var bodyPartID: Int = 0
    @Published var selectedLanguageIndex = 0
    @Published var comment: String = ""
    @Published var woundTypes = ["Úlcera arterial", "Úlcera venosa", "Úlcera mixta", "Úlcera", "Pie diabética", "Úlcera de decúbito", "Mecánico", "Quemadura", "Otro"]
    
    func getBodyPart() -> String {
        return self.bodyPartString
    }
    
}
