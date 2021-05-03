//
//  DressingType.swift
//  Zauri
//
//  Created by Oihan Arroyo on 02/05/2021.
//

import Foundation

enum DressingType: Int, CaseIterable, Hashable, Identifiable {
    case GauzeDressing
    case Hydrocolloid
    case Hydrocellular
    case Polyurethane
    case Hydrodetersive

    static let mapper: [DressingType: String] = [
        .GauzeDressing: "Apósito de gasa",
        .Hydrocolloid: "Hidrocoloide",
        .Hydrocellular: "Hidrocelular",
        .Polyurethane: "Poliuretano",
        .Hydrodetersive: "Hidrodetersivo"
    ]
    
    var id: Int { self.rawValue }
    
    var string: String {
        return DressingType.mapper[self]!
    }
}
