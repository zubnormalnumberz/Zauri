//
//  CaliberViewModel.swift
//  Zauri
//
//  Created by Oihan Arroyo on 20/04/2021.
//

import Foundation

class CaliberViewModel: ObservableObject {
    
    @Published var measureUnit: String = "cm"
    @Published var unit: Int = 1
    
    func getUnit() -> Int {
        return self.unit
    }
    
    func getMeasureUnit() -> String {
        return self.measureUnit
    }
}
