//
//  Scale.swift
//  Zauri
//
//  Created by Oihan Arroyo on 20/04/2021.
//

import Foundation
import SwiftUI

struct Scale: Codable {
    var unit: Int
    var measureUnit: String
    var scale: [CGPoint]
    
    init(unit: Int, measureUnit: String, scale: [CGPoint]) {
        self.unit = unit
        self.measureUnit = measureUnit
        self.scale = scale
    }
    
    func CGPointDistanceSquared(from: CGPoint, to: CGPoint) -> CGFloat {
        return (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)
    }

    func CGPointDistance(from: CGPoint, to: CGPoint) -> CGFloat {
        return sqrt(CGPointDistanceSquared(from: from, to: to))
    }
    
    func getArea(points: [CGPoint]) -> String {
        var area: Double = 0
        let N: Int = points.count;
        for i in 0..<N {
            let term = (points[i].x * points[(i+1) % N].y) - (points[(i+1) % N].x * points[i].y);
            print("Term: \(term)")
            area += Double(term)
        }
        print("Area: \(area)")
        let scaledArea = 0.5*abs(area)*pow(Double(unit), Double(2))/pow(Double(CGPointDistance(from: scale[0], to: scale[1])), Double(2))
        return String(format: "%.2f", (measureUnit == "cm" ? scaledArea : scaledArea/1000))
    }
    
    func getPerimeter(points: [CGPoint]) -> String {
        var perimeter: Double = 0
        for i in 0..<points.count - 1 {
            perimeter += Double(CGPointDistance(from: points[i], to: points[i+1]))
        }
        perimeter += Double(CGPointDistance(from: points[points.count-1], to: points[0]))
        let scaledPerimeter = perimeter*Double(unit)/Double(CGPointDistance(from: scale[0], to: scale[1]))
        return String(format: "%.2f", (measureUnit == "cm" ? scaledPerimeter : scaledPerimeter/1000))
    }
}
