//
//  BodyPart.swift
//  Zauri
//
//  Created by Oihan Arroyo on 23/04/2021.
//

import Foundation

enum BodyPart: Int {
    case FaceFront = 0
    case NeckFront = 1
    case Torax = 2
    case Abdomen = 3
    case RightShoulderFront = 4
    case RightForearmFront = 5
    case RightHandFront = 6
    case LeftShoulderFront = 7
    case LeftForearmFront = 8
    case LeftHandFront = 9
    case Genitals = 10
    case RightThighFront = 11
    case LeftThighFront = 12
    case RightLegFront = 13
    case LeftLegFront = 14
    case RightFootFront = 15
    case LeftFootFront = 16
    case FaceBack = 17
    case Neckback = 18
    case UpperBack = 19
    case LowerBack = 20
    case RightShoulderBack = 21
    case RightForearmBack = 22
    case RightHandBack = 23
    case LeftShoulderBack = 24
    case LeftForearmBack = 25
    case LeftHandBack = 26
    case RightGlute = 27
    case LeftGlute = 28
    case RightThighBack = 29
    case LeftThighBack = 30
    case RightLegBack = 31
    case LeftLegBack = 32
    case RightFootBack = 33
    case LeftFootBack = 34

    static let mapper: [BodyPart: String] = [
        .FaceFront: "Cara anterior",
        .NeckFront: "Cuello anterior",
        .Torax : "Torax",
        .Abdomen : "Abdomen",
        .RightShoulderFront : "Hombro derecho anterior",
        .RightForearmFront : "Antebrazo derecho anterior",
        .RightHandFront : "Mano derecha anterior",
        .LeftShoulderFront : "Hombro izquierdo anterior",
        .LeftForearmFront : "Antebrazo izquierdo anterior",
        .LeftHandFront : "Mano izquierda anterior",
        .Genitals : "Genitales",
        .RightThighFront : "Muslo derecho anterior",
        .LeftThighFront : "Muslo izquierdo anterior",
        .RightLegFront : "Pierna derecha anterior",
        .LeftLegFront : "Pierna izquierda anterior",
        .RightFootFront : "Pie derecho anterior",
        .LeftFootFront : "Pie izquierdo anterior",
        .FaceBack : "Cara posterior",
        .Neckback : "Cuello posterior",
        .UpperBack : "Espalda superior",
        .LowerBack : "Espalda inferior",
        .RightShoulderBack : "Hombro derecho posterior",
        .RightForearmBack : "Antebrazo derecho posterior",
        .RightHandBack : "Mano derecha posterior",
        .LeftShoulderBack : "Hombro izquierdo posterior",
        .LeftForearmBack : "Antebrazo izquierdo posterior",
        .LeftHandBack : "Mano izquierda posterior",
        .RightGlute : "Gluteo derecho",
        .LeftGlute : "Gluteo izquierdo",
        .RightThighBack : "Muslo derecho posterior",
        .LeftThighBack : "Muslo izquierdo posterior",
        .RightLegBack : "Pierna derecha posterior",
        .LeftLegBack : "Pierna izquierda posterior",
        .RightFootBack : "Pie derecho posterior",
        .LeftFootBack : "Pie izquierdo posterior"
    ]
    var string: String {
        return BodyPart.mapper[self]!
    }
}
