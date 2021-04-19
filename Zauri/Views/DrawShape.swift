//
//  DrawShape.swift
//  Zauri
//
//  Created by Oihan Arroyo on 19/04/2021.
//

import SwiftUI

struct DrawShape: Shape {

    var points: [CGPoint]

    func path(in rect: CGRect) -> Path {
        var path = Path()
        guard let firstPoint = points.first else { return path }

        path.move(to: firstPoint)
        for pointIndex in 1..<points.count {
            path.addLine(to: points[pointIndex])

        }
        return path
    }
}
