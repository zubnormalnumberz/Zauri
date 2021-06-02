//
//  DrawShapeEnd.swift
//  Zauri
//
//  Created by Oihan Arroyo on 20/04/2021.
//

import SwiftUI

struct DrawShapeEnd: Shape {
    var points: [CGPoint]

    func path(in rect: CGRect) -> Path {
        var path = Path()
        guard let firstPoint = points.first else { return path }

        path.move(to: firstPoint)
        for pointIndex in 1..<points.count {
            path.addLine(to: points[pointIndex])
        }
        path.closeSubpath()
//        let xArray = points.map(\.x)
//        let yArray = points.map(\.y)
//        let minX = xArray.min() ?? 0.0
//        let maxX = xArray.max() ?? 0.0
//        let minY = yArray.min() ?? 0.0
//        let maxY = yArray.max() ?? 0.0
//        let XPointMin = points.filter{ $0.x == minX }.first ?? CGPoint(x: 0.0, y: 0.0)
//        let XPointMax = points.filter{ $0.x == maxX }.first ?? CGPoint(x: 0.0, y: 0.0)
//        let YPointMin = points.filter{ $0.y == minY }.first ?? CGPoint(x: 0.0, y: 0.0)
//        let YPointMax = points.filter{ $0.y == maxY }.first ?? CGPoint(x: 0.0, y: 0.0)
//        path.move(to: XPointMin)
//        path.addLine(to: XPointMax)
//        path.closeSubpath()
//        path.move(to: YPointMin)
//        path.addLine(to: YPointMax)
//        path.closeSubpath()
        return path
    }
}
