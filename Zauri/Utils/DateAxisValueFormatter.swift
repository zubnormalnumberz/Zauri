//
//  DateAxisValueFormatter.swift
//  Zauri
//
//  Created by Oihan Arroyo on 26/04/2021.
//

import Foundation
import Charts

class DateAxisValueFormatter : NSObject, AxisValueFormatter{
    let dateFormatter = DateFormatter()
    let secondsPerDay = 24.0 * 3600.0

    override init(){
        super.init()
        dateFormatter.dateFormat = "dd-MM-yyyy"
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String{
        let date = Date(timeIntervalSinceReferenceDate: value)
        return dateFormatter.string(from: date)
    }
}
