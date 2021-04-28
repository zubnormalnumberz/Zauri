//
//  BodyPartView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 15/04/2021.
//

import SwiftUI

struct ScaledBezier: Shape {
    let bezierPath: UIBezierPath
    let pathBounds: CGRect
    func path(in rect: CGRect) -> Path {
        
        let pointScale = (rect.width >= rect.height) ? max(pathBounds.height, pathBounds.width) : min(pathBounds.height, pathBounds.width)
        let pointTransform = CGAffineTransform(scaleX: 1/(pointScale), y: 1/pointScale)
        let path = Path(bezierPath.cgPath).applying(pointTransform)
        let center = CGPoint(x:pathBounds.midX, y:pathBounds.midY)
        let multiplier = min(rect.width, rect.height)
        let toOrigin = CGAffineTransform(translationX: -center.x, y: -center.y)
        let fromOrigin = CGAffineTransform(translationX: center.x, y: center.y)
        let rotation = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        let transform = CGAffineTransform(scaleX: multiplier, y: multiplier)
        return path.applying(transform).applying(toOrigin).applying(rotation).applying(fromOrigin)
    }
}

struct BodyPartView: View {
    
    @ObservedObject var addWoundViewModel: AddWoundViewModel
        
    @State private var elementSelected: Int = 0
    
    let pathBoundsFaceFront = UIBezierPath.calculateBounds(paths: [.face_front])
    let pathBoundsNeckFront = UIBezierPath.calculateBounds(paths: [.neck_front])
    let pathBoundsTorax = UIBezierPath.calculateBounds(paths: [.torax])
    let pathBoundsAbdomen = UIBezierPath.calculateBounds(paths: [.abdomen])
    let pathBoundsGenitals = UIBezierPath.calculateBounds(paths: [.genitals])
    let pathBoundsRightThighFront = UIBezierPath.calculateBounds(paths: [.right_thigh_front])
    let pathBoundsLeftThighFront = UIBezierPath.calculateBounds(paths: [.left_thigh_front])
    let pathBoundsLeftLegFront = UIBezierPath.calculateBounds(paths: [.left_leg_front])
    let pathBoundsRightLegFront = UIBezierPath.calculateBounds(paths: [.right_leg_front])
    let pathBoundsRightFootFront = UIBezierPath.calculateBounds(paths: [.right_foot_front])
    let pathBoundsLeftFootFront = UIBezierPath.calculateBounds(paths: [.left_foot_front])
    let pathBoundsLeftShoulderFront = UIBezierPath.calculateBounds(paths: [.left_shoulder_front])
    let pathBoundsRightShoulderFront = UIBezierPath.calculateBounds(paths: [.right_shoulder_front])
    let pathBoundsRightForearmFrontal = UIBezierPath.calculateBounds(paths: [.right_forearm_front])
    let pathBoundsLeftForearmFrontal = UIBezierPath.calculateBounds(paths: [.left_forearm_front])
    let pathBoundsLeftHandFrontal = UIBezierPath.calculateBounds(paths: [.left_hand_front])
    let pathBoundsRightHandFrontal = UIBezierPath.calculateBounds(paths: [.right_hand_front])
    
    let pathBoundsFaceBack = UIBezierPath.calculateBounds(paths: [.face_back])
    let pathBoundsNeckBack = UIBezierPath.calculateBounds(paths: [.neck_back])
    let pathBoundsRightShoulderBack = UIBezierPath.calculateBounds(paths: [.right_shoulder_back])
    let pathBoundsLeftShoulderBack = UIBezierPath.calculateBounds(paths: [.left_shoulder_back])
    let pathBoundsUpperBack = UIBezierPath.calculateBounds(paths: [.upper_back])
    
    let pathBoundsLeftForearmBack = UIBezierPath.calculateBounds(paths: [.left_forearm_back])
    let pathBoundsLowerBack = UIBezierPath.calculateBounds(paths: [.lower_back])
    let pathBoundsRightForearmBack = UIBezierPath.calculateBounds(paths: [.right_forearm_back])
    
    let pathBoundsLeftGluteus = UIBezierPath.calculateBounds(paths: [.left_gluteus])
    let pathBoundsRightGluteus = UIBezierPath.calculateBounds(paths: [.right_gluteus])
    
    let pathBoundsLeftHandBack = UIBezierPath.calculateBounds(paths: [.left_hand_back])
    let pathBoundsRightHandBack = UIBezierPath.calculateBounds(paths: [.right_hand_back])
    let pathBoundsLeftThighBack = UIBezierPath.calculateBounds(paths: [.left_thigh_back])
    let pathBoundsRightThighBack = UIBezierPath.calculateBounds(paths: [.right_thigh_back])
    
    let pathBoundsRightLegBack = UIBezierPath.calculateBounds(paths: [.right_leg_back])
    let pathBoundsLeftLegBack = UIBezierPath.calculateBounds(paths: [.left_leg_back])
    let pathBoundsRightFootBack = UIBezierPath.calculateBounds(paths: [.right_foot_back])
    let pathBoundsLeftFootBack = UIBezierPath.calculateBounds(paths: [.left_foot_back])
    
    var body: some View {
        
        ScrollView {
            //LazyHStack {
                TabView {
                    
                    // BODY FRONT START
                    ZStack {
                        VStack{
                            ScaledBezier(bezierPath: .face_front, pathBounds: pathBoundsFaceFront)
                                .fill(elementSelected == 0 ? Color.red : Color.blue)
                                .frame(width: pathBoundsFaceFront.width, height: pathBoundsFaceFront.height)
                                .onTapGesture() {
                                    addWoundViewModel.bodyPartID = 0
                                    addWoundViewModel.bodyPartString = BodyPart(rawValue: 0)!.string
                                    elementSelected = 0
                                }
                            ScaledBezier(bezierPath: .neck_front, pathBounds: pathBoundsNeckFront)
                                .fill(self.elementSelected == 1 ? Color.red : Color.blue)
                                .frame(width: pathBoundsNeckFront.width, height: pathBoundsNeckFront.height*2.3)
                                .padding(.top, -10)
                                .onTapGesture() {
                                    addWoundViewModel.bodyPartID = 1
                                    addWoundViewModel.bodyPartString = BodyPart(rawValue: 1)!.string
                                    elementSelected = 1
                                }
                            HStack() {
                                ScaledBezier(bezierPath: .right_shoulder_front, pathBounds: pathBoundsRightShoulderFront)
                                    .fill(self.elementSelected == 4 ? Color.red : Color.blue)
                                    .frame(width: pathBoundsRightShoulderFront.width, height: pathBoundsRightShoulderFront.height)
                                    .padding(.trailing, -20)
                                    .padding(.top, 15)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartID = 4
                                        addWoundViewModel.bodyPartString = BodyPart(rawValue: 4)!.string
                                        elementSelected = 4
                                    }
                                ScaledBezier(bezierPath: .torax, pathBounds: pathBoundsTorax)
                                    .fill(self.elementSelected == 2 ? Color.red : Color.blue)
                                    .frame(width: pathBoundsTorax.width, height: pathBoundsTorax.height)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartID = 2
                                        addWoundViewModel.bodyPartString = BodyPart(rawValue: 2)!.string
                                        elementSelected = 2
                                    }
                                ScaledBezier(bezierPath: .left_shoulder_front, pathBounds: pathBoundsLeftShoulderFront)
                                    .fill(self.elementSelected == 7 ? Color.red : Color.blue)
                                    .frame(width: pathBoundsLeftShoulderFront.width, height: pathBoundsLeftShoulderFront.height)
                                    .padding(.leading, -20)
                                    .padding(.top, 15)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartID = 7
                                        addWoundViewModel.bodyPartString = BodyPart(rawValue: 7)!.string
                                        elementSelected = 7
                                    }
                            }.padding(.top, -80)
                            HStack(alignment: .top, spacing: 0) {
                                ScaledBezier(bezierPath: .right_forearm_front, pathBounds: pathBoundsRightForearmFrontal)
                                    .fill(self.elementSelected == 5 ? Color.red : Color.blue)
                                    .frame(width: pathBoundsRightForearmFrontal.width, height: pathBoundsRightForearmFrontal.height)
                                    .padding(.top, -35)
                                    .padding(.trailing, 30)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartID = 5
                                        addWoundViewModel.bodyPartString = BodyPart(rawValue: 5)!.string
                                        elementSelected = 5
                                    }
                                ScaledBezier(bezierPath: .abdomen, pathBounds: pathBoundsAbdomen)
                                    .fill(self.elementSelected == 3 ? Color.red : Color.blue)
                                    .frame(width: pathBoundsAbdomen.width, height: pathBoundsAbdomen.height)
                                    .padding(.top, -50)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartID = 3
                                        addWoundViewModel.bodyPartString = BodyPart(rawValue: 3)!.string
                                        elementSelected = 3
                                    }
                                ScaledBezier(bezierPath: .left_forearm_front, pathBounds: pathBoundsLeftForearmFrontal)
                                    .fill(self.elementSelected == 8 ? Color.red : Color.blue)
                                    .frame(width: pathBoundsLeftForearmFrontal.width, height: pathBoundsLeftForearmFrontal.height)
                                    .padding(.top, -35)
                                    .padding(.leading, 30)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartID = 8
                                        addWoundViewModel.bodyPartString = BodyPart(rawValue: 8)!.string
                                        elementSelected = 8
                                    }
                            }
                            HStack(alignment: .top, spacing: 0) {
                                ScaledBezier(bezierPath: .right_hand_front, pathBounds: pathBoundsRightHandFrontal)
                                    .fill(self.elementSelected == 6 ? Color.red : Color.blue)
                                    .frame(width: pathBoundsRightHandFrontal.width, height: pathBoundsRightHandFrontal.height)
                                    .padding(.top, -35)
                                    .padding(.trailing, 60)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartID = 6
                                        addWoundViewModel.bodyPartString = BodyPart(rawValue: 6)!.string
                                        elementSelected = 6
                                    }
                                ScaledBezier(bezierPath: .right_thigh_front, pathBounds: pathBoundsRightThighFront)
                                    .fill(self.elementSelected == 11 ? Color.red : Color.blue)
                                    .frame(width: pathBoundsRightThighFront.width, height: pathBoundsRightThighFront.height)
                                    .padding(.top, -50)
                                    .padding(.trailing, -15)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartID = 11
                                        addWoundViewModel.bodyPartString = BodyPart(rawValue: 11)!.string
                                        elementSelected = 11
                                    }
                                ScaledBezier(bezierPath: .genitals, pathBounds: pathBoundsGenitals)
                                    .fill(self.elementSelected == 10 ? Color.red : Color.blue)
                                    .frame(width: pathBoundsGenitals.width, height: pathBoundsGenitals.height)
                                    .padding(.top, -10)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartID = 10
                                        addWoundViewModel.bodyPartString = BodyPart(rawValue: 10)!.string
                                        elementSelected = 10
                                    }
                                ScaledBezier(bezierPath: .left_thigh_front, pathBounds: pathBoundsLeftThighFront)
                                    .fill(self.elementSelected == 12 ? Color.red : Color.blue)
                                    .frame(width: pathBoundsLeftThighFront.width, height: pathBoundsLeftThighFront.height)
                                    .padding(.top, -50)
                                    .padding(.leading, -10)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartID = 12
                                        addWoundViewModel.bodyPartString = BodyPart(rawValue: 12)!.string
                                        elementSelected = 12
                                    }
                                ScaledBezier(bezierPath: .left_hand_front, pathBounds: pathBoundsLeftHandFrontal)
                                    .fill(self.elementSelected == 9 ? Color.red : Color.blue)
                                    .frame(width: pathBoundsLeftHandFrontal.width, height: pathBoundsLeftHandFrontal.height)
                                    .padding(.top, -35)
                                    .padding(.leading, 60)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartID = 9
                                        addWoundViewModel.bodyPartString = BodyPart(rawValue: 9)!.string
                                        elementSelected = 9
                                    }
                            }
                            HStack() {
                                ScaledBezier(bezierPath: .right_leg_front, pathBounds: pathBoundsRightLegFront)
                                    .fill(self.elementSelected == 13 ? Color.red : Color.blue)
                                    .frame(width: pathBoundsRightLegFront.width, height: pathBoundsRightLegFront.height)
                                    .padding(.top, -45)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartID = 13
                                        addWoundViewModel.bodyPartString = BodyPart(rawValue: 13)!.string
                                        elementSelected = 13
                                    }
                                ScaledBezier(bezierPath: .left_leg_front, pathBounds: pathBoundsLeftLegFront)
                                    .fill(self.elementSelected == 14 ? Color.red : Color.blue)
                                    .frame(width: pathBoundsLeftLegFront.width, height: pathBoundsLeftLegFront.height)
                                    .padding(.top, -45)
                                    .padding(.leading, 3)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartID = 14
                                        addWoundViewModel.bodyPartString = BodyPart(rawValue: 14)!.string
                                        elementSelected = 14
                                    }
                            }
                            HStack(alignment: .top, spacing: 0) {
                                ScaledBezier(bezierPath: .right_foot_front, pathBounds: pathBoundsRightFootFront)
                                    .fill(self.elementSelected == 15 ? Color.red : Color.blue)
                                    .frame(width: pathBoundsRightFootFront.width, height: pathBoundsRightFootFront.height)
                                    .padding(.top, -25)
                                    .padding(.trailing, 5)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartID = 15
                                        addWoundViewModel.bodyPartString = BodyPart(rawValue: 15)!.string
                                        elementSelected = 15
                                    }
                                ScaledBezier(bezierPath: .left_foot_front, pathBounds: pathBoundsLeftFootFront)
                                    .fill(self.elementSelected == 16 ? Color.red : Color.blue)
                                    .frame(width: pathBoundsLeftFootFront.width, height: pathBoundsLeftFootFront.height)
                                    .padding(.top, -25)
                                    .padding(.leading, 5)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartID = 16
                                        addWoundViewModel.bodyPartString = BodyPart(rawValue: 16)!.string
                                        elementSelected = 16
                                    }
                            }
                        }.padding()
                    }.clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                    .tag(0)
                    // BODY FRONT END
                    
                    // BODY BACK START
                    ZStack {
                        VStack{
                            ScaledBezier(bezierPath: .face_back, pathBounds: pathBoundsFaceBack)
                                .fill(elementSelected == 17 ? Color.red : Color.blue)
                                .frame(width: pathBoundsFaceBack.width, height: pathBoundsFaceBack.height)
                                .onTapGesture() {
                                    addWoundViewModel.bodyPartID = 17
                                    addWoundViewModel.bodyPartString = BodyPart(rawValue: 17)!.string
                                    elementSelected = 17
                                }
                            ScaledBezier(bezierPath: .neck_back, pathBounds: pathBoundsNeckBack)
                                .fill(self.elementSelected == 18 ? Color.red : Color.blue)
                                .frame(width: pathBoundsNeckBack.width, height: pathBoundsNeckBack.height)
                                .padding(.top, -35)
                                .onTapGesture() {
                                    addWoundViewModel.bodyPartID = 18
                                    addWoundViewModel.bodyPartString = BodyPart(rawValue: 18)!.string
                                    elementSelected = 18
                                }
                            HStack() {
                                ScaledBezier(bezierPath: .left_shoulder_back, pathBounds: pathBoundsLeftShoulderBack)
                                    .fill(self.elementSelected == 24 ? Color.red : Color.blue)
                                    .frame(width: pathBoundsLeftShoulderBack.width, height: pathBoundsLeftShoulderBack.height)
                                    .padding(.trailing, -40)
                                    .padding(.top, 40)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartID = 24
                                        addWoundViewModel.bodyPartString = BodyPart(rawValue: 24)!.string
                                        elementSelected = 24
                                    }
                                ScaledBezier(bezierPath: .upper_back, pathBounds: pathBoundsUpperBack)
                                    .fill(self.elementSelected == 19 ? Color.red : Color.blue)
                                    .frame(width: pathBoundsUpperBack.width, height: pathBoundsUpperBack.height)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartID = 19
                                        addWoundViewModel.bodyPartString = BodyPart(rawValue: 19)!.string
                                        elementSelected = 19
                                    }
                                ScaledBezier(bezierPath: .right_shoulder_back, pathBounds: pathBoundsRightShoulderBack)
                                    .fill(self.elementSelected == 21 ? Color.red : Color.blue)
                                    .frame(width: pathBoundsRightShoulderBack.width, height: pathBoundsRightShoulderBack.height)
                                    .padding(.leading, -25)
                                    .padding(.top, 40)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartID = 21
                                        addWoundViewModel.bodyPartString = BodyPart(rawValue: 21)!.string
                                        elementSelected = 21
                                    }
                            }.padding(.top, -65)
                            HStack(alignment: .top, spacing: 0) {
                                ScaledBezier(bezierPath: .left_forearm_back, pathBounds: pathBoundsLeftForearmBack)
                                    .fill(self.elementSelected == 25 ? Color.red : Color.blue)
                                    .frame(width: pathBoundsLeftForearmBack.width, height: pathBoundsLeftForearmBack.height)
                                    .padding(.top, -20)
                                    .padding(.trailing, 15)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartID = 25
                                        addWoundViewModel.bodyPartString = BodyPart(rawValue: 25)!.string
                                        elementSelected = 25
                                    }
                                ScaledBezier(bezierPath: .lower_back, pathBounds: pathBoundsLowerBack)
                                    .fill(self.elementSelected == 20 ? Color.red : Color.blue)
                                    .frame(width: pathBoundsLowerBack.width, height: pathBoundsLowerBack.height)
                                    .padding(.top, -50)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartID = 20
                                        addWoundViewModel.bodyPartString = BodyPart(rawValue: 20)!.string
                                        elementSelected = 20
                                    }
                                ScaledBezier(bezierPath: .right_forearm_back, pathBounds: pathBoundsRightForearmBack)
                                    .fill(self.elementSelected == 22 ? Color.red : Color.blue)
                                    .frame(width: pathBoundsRightForearmBack.width, height: pathBoundsRightForearmBack.height)
                                    .padding(.top, -20)
                                    .padding(.leading, 20)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartID = 22
                                        addWoundViewModel.bodyPartString = BodyPart(rawValue: 22)!.string
                                        elementSelected = 22
                                    }
                            }
                            HStack(alignment: .top, spacing: 0) {
                                ScaledBezier(bezierPath: .left_gluteus, pathBounds: pathBoundsLeftGluteus)
                                    .fill(self.elementSelected == 28 ? Color.red : Color.blue)
                                    .frame(width: pathBoundsLeftGluteus.width, height: pathBoundsLeftGluteus.height)
                                    .padding(.top, -65)
                                    .padding(.trailing, 2)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartID = 28
                                        addWoundViewModel.bodyPartString = BodyPart(rawValue: 28)!.string
                                        elementSelected = 28
                                    }
                                ScaledBezier(bezierPath: .right_gluteus, pathBounds: pathBoundsRightGluteus)
                                    .fill(self.elementSelected == 27 ? Color.red : Color.blue)
                                    .frame(width: pathBoundsRightGluteus.width, height: pathBoundsRightGluteus.height)
                                    .padding(.top, -65)
                                    .padding(.leading, 2)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartID = 27
                                        addWoundViewModel.bodyPartString = BodyPart(rawValue: 27)!.string
                                        elementSelected = 27
                                    }
                            }
                            HStack(alignment: .top, spacing: 0) {
                                ScaledBezier(bezierPath: .left_hand_back, pathBounds: pathBoundsLeftHandBack)
                                    .fill(self.elementSelected == 26 ? Color.red : Color.blue)
                                    .frame(width: pathBoundsLeftHandBack.width, height: pathBoundsLeftHandBack.height)
                                    .padding(.top, -35)
                                    .padding(.trailing, 55)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartID = 26
                                        addWoundViewModel.bodyPartString = BodyPart(rawValue: 26)!.string
                                        elementSelected = 26
                                    }
                                ScaledBezier(bezierPath: .left_thigh_back, pathBounds: pathBoundsLeftThighBack)
                                    .fill(self.elementSelected == 30 ? Color.red : Color.blue)
                                    .frame(width: pathBoundsLeftThighBack.width, height: pathBoundsLeftThighBack.height)
                                    .padding(.top, -50)
                                    .padding(.trailing, 5)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartID = 30
                                        addWoundViewModel.bodyPartString = BodyPart(rawValue: 30)!.string
                                        elementSelected = 30
                                    }
                                ScaledBezier(bezierPath: .right_thigh_back, pathBounds: pathBoundsRightThighBack)
                                    .fill(self.elementSelected == 29 ? Color.red : Color.blue)
                                    .frame(width: pathBoundsRightThighBack.width, height: pathBoundsRightThighBack.height)
                                    .padding(.top, -50)
                                    .padding(.leading, 5)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartID = 29
                                        addWoundViewModel.bodyPartString = BodyPart(rawValue: 29)!.string
                                        elementSelected = 29
                                    }
                                ScaledBezier(bezierPath: .right_hand_back, pathBounds: pathBoundsRightHandBack)
                                    .fill(self.elementSelected == 23 ? Color.red : Color.blue)
                                    .frame(width: pathBoundsRightHandBack.width, height: pathBoundsRightHandBack.height)
                                    .padding(.top, -35)
                                    .padding(.leading, 55)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartID = 23
                                        addWoundViewModel.bodyPartString = BodyPart(rawValue: 23)!.string
                                        elementSelected = 23
                                    }
                            }
                            HStack() {
                                ScaledBezier(bezierPath: .left_leg_back, pathBounds: pathBoundsLeftLegBack)
                                    .fill(self.elementSelected == 32 ? Color.red : Color.blue)
                                    .frame(width: pathBoundsLeftLegBack.width, height: pathBoundsLeftLegBack.height)
                                    .padding(.top, -35)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartID = 32
                                        addWoundViewModel.bodyPartString = BodyPart(rawValue: 32)!.string
                                        elementSelected = 32
                                    }
                                ScaledBezier(bezierPath: .right_leg_back, pathBounds: pathBoundsRightLegBack)
                                    .fill(self.elementSelected == 31 ? Color.red : Color.blue)
                                    .frame(width: pathBoundsRightLegBack.width, height: pathBoundsRightLegBack.height)
                                    .padding(.top, -35)
                                    .padding(.leading, 5)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartID = 31
                                        addWoundViewModel.bodyPartString = BodyPart(rawValue: 31)!.string
                                        elementSelected = 31
                                    }
                            }
                            HStack(alignment: .top, spacing: 0) {
                                ScaledBezier(bezierPath: .left_foot_back, pathBounds: pathBoundsLeftFootFront)
                                    .fill(self.elementSelected == 34 ? Color.red : Color.blue)
                                    .frame(width: pathBoundsLeftFootFront.width, height: pathBoundsLeftFootFront.height)
                                    .padding(.top, -20)
                                    .padding(.trailing, 5)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartID = 34
                                        addWoundViewModel.bodyPartString = BodyPart(rawValue: 34)!.string
                                        elementSelected = 34
                                    }
                                ScaledBezier(bezierPath: .right_foot_back, pathBounds: pathBoundsRightFootBack)
                                    .fill(self.elementSelected == 33 ? Color.red : Color.blue)
                                    .frame(width: pathBoundsRightFootBack.width, height: pathBoundsRightFootBack.height)
                                    .padding(.top, -20)
                                    .padding(.leading, 5)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartID = 33
                                        addWoundViewModel.bodyPartString = BodyPart(rawValue: 33)!.string
                                        elementSelected = 33
                                    }
                            }
                        }.padding()
                    }.clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                    .tag(1)
                    // BODY BACK END
                }
                //.resizable()
                //.edgesIgnoringSafeArea(.all)
                //.scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-60)
                //.edgesIgnoringSafeArea(.all)
                .padding(.top, -40)
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            //}
        }.onAppear {
            self.elementSelected = addWoundViewModel.getBodyPart()
        }
    }
}

struct BodyPartView_Previews: PreviewProvider {
    static var previews: some View {
        BodyPartView(addWoundViewModel: AddWoundViewModel())
    }
}
