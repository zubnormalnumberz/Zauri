//
//  ScaleUnitTest.swift
//  ZauriTests
//
//  Created by Oihan Arroyo on 12/05/2021.
//

import XCTest
@testable import Zauri

class ScaleUnitTest: XCTestCase {

    var scale: Scale!
    
    override func setUpWithError() throws {
        self.scale = Scale(unit: 1, measureUnit: "cm", scale: [CGPoint(x: 0.0, y: 0.0), CGPoint(x: 1.0, y: 0.0)])
    }

    func testPerimeter() throws {
        let resultPerimeter = scale.getPerimeter(points: [CGPoint(x: -2, y: -3), CGPoint(x: -1, y: 3), CGPoint(x: 5, y: -4)])
        XCTAssertEqual(Double(resultPerimeter), 22.37)
    }
    
    func testArea() throws {
        let resultArea = scale.getArea(points: [CGPoint(x: 3, y: 4), CGPoint(x: 5, y: 11), CGPoint(x: 12, y: 8), CGPoint(x: 9, y: 5), CGPoint(x: 5, y: 6)])
        XCTAssertEqual(Double(resultArea), 30.0)
    }
    
    func testArea2() throws {
        let resultArea = scale.getArea(points: [CGPoint(x: -3, y: -1), CGPoint(x: -2, y: 6), CGPoint(x: 5, y: -4)])
        XCTAssertEqual(Double(resultArea), 29.5)
    }
    
    func testArea3() throws {
        let resultArea = scale.getArea(points: [CGPoint(x: -5, y: -5), CGPoint(x: 1, y: 3), CGPoint(x: 4, y: -6)])
        XCTAssertEqual(Double(resultArea), 39)
    }
    
}
