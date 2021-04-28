//
//  WoundType.swift
//  Zauri
//
//  Created by Oihan Arroyo on 28/04/2021.
//

import Foundation

enum WoundType: Int, CaseIterable, Hashable, Identifiable {
    case ArterialUlcer
    case VenousUlcer
    case MixedUlcer
    case Ulcer
    case DiabeticFoot
    case DecubitusUlcer
    case Mechanical
    case Burn
    case Other

    static let mapper: [WoundType: String] = [
        .ArterialUlcer: "Úlcera arterial",
        .VenousUlcer: "Úlcera venosa",
        .MixedUlcer: "Úlcera mixta",
        .Ulcer: "Úlcera",
        .DiabeticFoot: "Pie diabético",
        .DecubitusUlcer: "Úlcera de decubito",
        .Mechanical: "Mecánico",
        .Burn: "Quemadura",
        .Other: "Otro"
    ]
    
    var id: Int { self.rawValue }
    
    var string: String {
        return WoundType.mapper[self]!
    }
}
