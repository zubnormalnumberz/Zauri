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
        
    @State private var elementSelected: String = ""
    
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
                                .fill(elementSelected == "Cara anterior" ? Color.red : Color.blue)
                                .frame(width: pathBoundsFaceFront.width, height: pathBoundsFaceFront.height)
                                .onTapGesture() {
                                    addWoundViewModel.bodyPartString = "Cara anterior"
                                    elementSelected = "Cara anterior"
                                }
                            ScaledBezier(bezierPath: .neck_front, pathBounds: pathBoundsNeckFront)
                                .fill(self.elementSelected == "Cuello anterior" ? Color.red : Color.blue)
                                .frame(width: pathBoundsNeckFront.width, height: pathBoundsNeckFront.height*2.3)
                                .padding(.top, -10)
                                .onTapGesture() {
                                    addWoundViewModel.bodyPartString = "Cuello anterior"
                                    elementSelected = "Cuello anterior"
                                }
                            HStack() {
                                ScaledBezier(bezierPath: .right_shoulder_front, pathBounds: pathBoundsRightShoulderFront)
                                    .fill(self.elementSelected == "Hombro derecho frontal" ? Color.red : Color.blue)
                                    .frame(width: pathBoundsRightShoulderFront.width, height: pathBoundsRightShoulderFront.height)
                                    .padding(.trailing, -20)
                                    .padding(.top, 15)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartString = "Hombro derecho frontal"
                                        elementSelected = "Hombro derecho frontal"
                                    }
                                ScaledBezier(bezierPath: .torax, pathBounds: pathBoundsTorax)
                                    .fill(self.elementSelected == "Torax" ? Color.red : Color.blue)
                                    .frame(width: pathBoundsTorax.width, height: pathBoundsTorax.height)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartString = "Torax"
                                        self.elementSelected = "Torax"
                                    }
                                ScaledBezier(bezierPath: .left_shoulder_front, pathBounds: pathBoundsLeftShoulderFront)
                                    .fill(self.elementSelected == "Hombro izquierdo frontal" ? Color.red : Color.blue)
                                    .frame(width: pathBoundsLeftShoulderFront.width, height: pathBoundsLeftShoulderFront.height)
                                    .padding(.leading, -20)
                                    .padding(.top, 15)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartString = "Hombro izquierdo frontal"
                                        self.elementSelected = "Hombro izquierdo frontal"
                                    }
                            }.padding(.top, -80)
                            HStack(alignment: .top, spacing: 0) {
                                ScaledBezier(bezierPath: .right_forearm_front, pathBounds: pathBoundsRightForearmFrontal)
                                    .fill(self.elementSelected == "Antebrazo derecho frontal" ? Color.red : Color.blue)
                                    .frame(width: pathBoundsRightForearmFrontal.width, height: pathBoundsRightForearmFrontal.height)
                                    .padding(.top, -35)
                                    .padding(.trailing, 30)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartString = "Antebrazo derecho frontal"
                                        self.elementSelected = "Antebrazo derecho frontal"
                                    }
                                ScaledBezier(bezierPath: .abdomen, pathBounds: pathBoundsAbdomen)
                                    .fill(self.elementSelected == "Abdomen" ? Color.red : Color.blue)
                                    .frame(width: pathBoundsAbdomen.width, height: pathBoundsAbdomen.height)
                                    .padding(.top, -50)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartString = "Abdomen"
                                        self.elementSelected = "Abdomen"
                                    }
                                ScaledBezier(bezierPath: .left_forearm_front, pathBounds: pathBoundsLeftForearmFrontal)
                                    .fill(self.elementSelected == "Antebrazo izquierdo frontal" ? Color.red : Color.blue)
                                    .frame(width: pathBoundsLeftForearmFrontal.width, height: pathBoundsLeftForearmFrontal.height)
                                    .padding(.top, -35)
                                    .padding(.leading, 30)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartString = "Antebrazo izquierdo frontal"
                                        self.elementSelected = "Antebrazo izquierdo frontal"
                                    }
                            }
                            HStack(alignment: .top, spacing: 0) {
                                ScaledBezier(bezierPath: .right_hand_front, pathBounds: pathBoundsRightHandFrontal)
                                    .fill(self.elementSelected == "Mano derecha anterior" ? Color.red : Color.blue)
                                    .frame(width: pathBoundsRightHandFrontal.width, height: pathBoundsRightHandFrontal.height)
                                    .padding(.top, -35)
                                    .padding(.trailing, 60)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartString = "Mano derecha anterior"
                                        self.elementSelected = "Mano derecha anterior"
                                    }
                                ScaledBezier(bezierPath: .right_thigh_front, pathBounds: pathBoundsRightThighFront)
                                    .fill(self.elementSelected == "Muslo derecho anterior" ? Color.red : Color.blue)
                                    .frame(width: pathBoundsRightThighFront.width, height: pathBoundsRightThighFront.height)
                                    .padding(.top, -50)
                                    .padding(.trailing, -15)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartString = "Muslo derecho anterior"
                                        self.elementSelected = "Muslo derecho anterior"
                                    }
                                ScaledBezier(bezierPath: .genitals, pathBounds: pathBoundsGenitals)
                                    .fill(self.elementSelected == "Genitales" ? Color.red : Color.blue)
                                    .frame(width: pathBoundsGenitals.width, height: pathBoundsGenitals.height)
                                    .padding(.top, -10)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartString = "Genitales"
                                        elementSelected = "Genitales"
                                    }
                                ScaledBezier(bezierPath: .left_thigh_front, pathBounds: pathBoundsLeftThighFront)
                                    .fill(self.elementSelected == "Muslo izquierdo anterior" ? Color.red : Color.blue)
                                    .frame(width: pathBoundsLeftThighFront.width, height: pathBoundsLeftThighFront.height)
                                    .padding(.top, -50)
                                    .padding(.leading, -10)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartString = "Muslo izquierdo anterior"
                                        self.elementSelected = "Muslo izquierdo anterior"
                                    }
                                ScaledBezier(bezierPath: .left_hand_front, pathBounds: pathBoundsLeftHandFrontal)
                                    .fill(self.elementSelected == "Mano izquierda anterior" ? Color.red : Color.blue)
                                    .frame(width: pathBoundsLeftHandFrontal.width, height: pathBoundsLeftHandFrontal.height)
                                    .padding(.top, -35)
                                    .padding(.leading, 60)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartString = "Mano izquierda anterior"
                                        self.elementSelected = "Mano izquierda anterior"
                                    }
                            }
                            HStack() {
                                ScaledBezier(bezierPath: .right_leg_front, pathBounds: pathBoundsRightLegFront)
                                    .fill(self.elementSelected == "Pierna derecha anterior" ? Color.red : Color.blue)
                                    .frame(width: pathBoundsRightLegFront.width, height: pathBoundsRightLegFront.height)
                                    .padding(.top, -45)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartString = "Pierna derecha anterior"
                                        self.elementSelected = "Pierna derecha anterior"
                                    }
                                ScaledBezier(bezierPath: .left_leg_front, pathBounds: pathBoundsLeftLegFront)
                                    .fill(self.elementSelected == "Pierna izquierda anterior" ? Color.red : Color.blue)
                                    .frame(width: pathBoundsLeftLegFront.width, height: pathBoundsLeftLegFront.height)
                                    .padding(.top, -45)
                                    .padding(.leading, 3)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartString = "Pierna izquierda anterior"
                                        self.elementSelected = "Pierna izquierda anterior"
                                    }
                            }
                            HStack(alignment: .top, spacing: 0) {
                                ScaledBezier(bezierPath: .right_foot_front, pathBounds: pathBoundsRightFootFront)
                                    .fill(self.elementSelected == "Pie derecho anterior" ? Color.red : Color.blue)
                                    .frame(width: pathBoundsRightFootFront.width, height: pathBoundsRightFootFront.height)
                                    .padding(.top, -25)
                                    .padding(.trailing, 5)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartString = "Pie derecho anterior"
                                        self.elementSelected = "Pie derecho anterior"
                                    }
                                ScaledBezier(bezierPath: .left_foot_front, pathBounds: pathBoundsLeftFootFront)
                                    .fill(self.elementSelected == "Pie izquierdo anterior" ? Color.red : Color.blue)
                                    .frame(width: pathBoundsLeftFootFront.width, height: pathBoundsLeftFootFront.height)
                                    .padding(.top, -25)
                                    .padding(.leading, 5)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartString = "Pie izquierdo anterior"
                                        self.elementSelected = "Pie izquierdo anterior"
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
                                .fill(elementSelected == "Cara posterior" ? Color.red : Color.blue)
                                .frame(width: pathBoundsFaceBack.width, height: pathBoundsFaceBack.height)
                                .onTapGesture() {
                                    addWoundViewModel.bodyPartString = "Cara posterior"
                                    elementSelected = "Cara posterior"
                                }
                            ScaledBezier(bezierPath: .neck_back, pathBounds: pathBoundsNeckBack)
                                .fill(self.elementSelected == "Cuello posterior" ? Color.red : Color.blue)
                                .frame(width: pathBoundsNeckBack.width, height: pathBoundsNeckBack.height)
                                .padding(.top, -35)
                                .onTapGesture() {
                                    addWoundViewModel.bodyPartString = "Cuello posterior"
                                    self.elementSelected = "Cuello posterior"
                                }
                            HStack() {
                                ScaledBezier(bezierPath: .left_shoulder_back, pathBounds: pathBoundsLeftShoulderBack)
                                    .fill(self.elementSelected == "Hombro izquierdo posterior" ? Color.red : Color.blue)
                                    .frame(width: pathBoundsLeftShoulderBack.width, height: pathBoundsLeftShoulderBack.height)
                                    .padding(.trailing, -40)
                                    .padding(.top, 40)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartString = "Hombro izquierdo posterior"
                                        self.elementSelected = "Hombro izquierdo posterior"
                                    }
                                ScaledBezier(bezierPath: .upper_back, pathBounds: pathBoundsUpperBack)
                                    .fill(self.elementSelected == "Espalda superior" ? Color.red : Color.blue)
                                    .frame(width: pathBoundsUpperBack.width, height: pathBoundsUpperBack.height)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartString = "Espalda superior"
                                        self.elementSelected = "Espalda superior"
                                    }
                                ScaledBezier(bezierPath: .right_shoulder_back, pathBounds: pathBoundsRightShoulderBack)
                                    .fill(self.elementSelected == "Hombro derecho posterior" ? Color.red : Color.blue)
                                    .frame(width: pathBoundsRightShoulderBack.width, height: pathBoundsRightShoulderBack.height)
                                    .padding(.leading, -25)
                                    .padding(.top, 40)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartString = "Hombro derecho posterior"
                                        self.elementSelected = "Hombro derecho posterior"
                                    }
                            }.padding(.top, -65)
                            HStack(alignment: .top, spacing: 0) {
                                ScaledBezier(bezierPath: .left_forearm_back, pathBounds: pathBoundsLeftForearmBack)
                                    .fill(self.elementSelected == "Antebrazo izquierdo posterior" ? Color.red : Color.blue)
                                    .frame(width: pathBoundsLeftForearmBack.width, height: pathBoundsLeftForearmBack.height)
                                    .padding(.top, -20)
                                    .padding(.trailing, 15)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartString = "Antebrazo izquierdo posterior"
                                        self.elementSelected = "Antebrazo izquierdo posterior"
                                    }
                                ScaledBezier(bezierPath: .lower_back, pathBounds: pathBoundsLowerBack)
                                    .fill(self.elementSelected == "Espalda inferior" ? Color.red : Color.blue)
                                    .frame(width: pathBoundsLowerBack.width, height: pathBoundsLowerBack.height)
                                    .padding(.top, -50)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartString = "Espalda inferior"
                                        self.elementSelected = "Espalda inferior"
                                    }
                                ScaledBezier(bezierPath: .right_forearm_back, pathBounds: pathBoundsRightForearmBack)
                                    .fill(self.elementSelected == "Antebrazo derecho posterior" ? Color.red : Color.blue)
                                    .frame(width: pathBoundsRightForearmBack.width, height: pathBoundsRightForearmBack.height)
                                    .padding(.top, -20)
                                    .padding(.leading, 20)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartString = "Antebrazo derecho posterior"
                                        self.elementSelected = "Antebrazo derecho posterior"
                                    }
                            }
                            HStack(alignment: .top, spacing: 0) {
                                ScaledBezier(bezierPath: .left_gluteus, pathBounds: pathBoundsLeftGluteus)
                                    .fill(self.elementSelected == "Gluteo izquierdo" ? Color.red : Color.blue)
                                    .frame(width: pathBoundsLeftGluteus.width, height: pathBoundsLeftGluteus.height)
                                    .padding(.top, -65)
                                    .padding(.trailing, 2)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartString = "Gluteo izquierdo"
                                        self.elementSelected = "Gluteo izquierdo"
                                    }
                                ScaledBezier(bezierPath: .right_gluteus, pathBounds: pathBoundsRightGluteus)
                                    .fill(self.elementSelected == "Gluteo derecho" ? Color.red : Color.blue)
                                    .frame(width: pathBoundsRightGluteus.width, height: pathBoundsRightGluteus.height)
                                    .padding(.top, -65)
                                    .padding(.leading, 2)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartString = "Gluteo derecho"
                                        self.elementSelected = "Gluteo derecho"
                                    }
                            }
                            HStack(alignment: .top, spacing: 0) {
                                ScaledBezier(bezierPath: .left_hand_back, pathBounds: pathBoundsLeftHandBack)
                                    .fill(self.elementSelected == "Mano izquieda posterior" ? Color.red : Color.blue)
                                    .frame(width: pathBoundsLeftHandBack.width, height: pathBoundsLeftHandBack.height)
                                    .padding(.top, -35)
                                    .padding(.trailing, 55)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartString = "Mano izquieda posterior"
                                        self.elementSelected = "Mano izquieda posterior"
                                    }
                                ScaledBezier(bezierPath: .left_thigh_back, pathBounds: pathBoundsLeftThighBack)
                                    .fill(self.elementSelected == "Muslo izquierdo posterior" ? Color.red : Color.blue)
                                    .frame(width: pathBoundsLeftThighBack.width, height: pathBoundsLeftThighBack.height)
                                    .padding(.top, -50)
                                    .padding(.trailing, 5)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartString = "Muslo izquierdo posterior"
                                        self.elementSelected = "Muslo izquierdo posterior"
                                    }
                                ScaledBezier(bezierPath: .right_thigh_back, pathBounds: pathBoundsRightThighBack)
                                    .fill(self.elementSelected == "Muslo derecho posterior" ? Color.red : Color.blue)
                                    .frame(width: pathBoundsRightThighBack.width, height: pathBoundsRightThighBack.height)
                                    .padding(.top, -50)
                                    .padding(.leading, 5)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartString = "Muslo derecho posterior"
                                        self.elementSelected = "Muslo derecho posterior"
                                    }
                                ScaledBezier(bezierPath: .right_hand_back, pathBounds: pathBoundsRightHandBack)
                                    .fill(self.elementSelected == "Mano derecha posterior" ? Color.red : Color.blue)
                                    .frame(width: pathBoundsRightHandBack.width, height: pathBoundsRightHandBack.height)
                                    .padding(.top, -35)
                                    .padding(.leading, 55)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartString = "Mano derecha posterior"
                                        self.elementSelected = "Mano derecha posterior"
                                    }
                            }
                            HStack() {
                                ScaledBezier(bezierPath: .left_leg_back, pathBounds: pathBoundsLeftLegBack)
                                    .fill(self.elementSelected == "Pierna izquierda posterior" ? Color.red : Color.blue)
                                    .frame(width: pathBoundsLeftLegBack.width, height: pathBoundsLeftLegBack.height)
                                    .padding(.top, -35)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartString = "Pierna izquierda posterior"
                                        self.elementSelected = "Pierna izquierda posterior"
                                    }
                                ScaledBezier(bezierPath: .right_leg_back, pathBounds: pathBoundsRightLegBack)
                                    .fill(self.elementSelected == "Pierna derecha posterior" ? Color.red : Color.blue)
                                    .frame(width: pathBoundsRightLegBack.width, height: pathBoundsRightLegBack.height)
                                    .padding(.top, -35)
                                    .padding(.leading, 5)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartString = "Pierna derecha posterior"
                                        self.elementSelected = "Pierna derecha posterior"
                                    }
                            }
                            HStack(alignment: .top, spacing: 0) {
                                ScaledBezier(bezierPath: .left_foot_back, pathBounds: pathBoundsLeftFootFront)
                                    .fill(self.elementSelected == "Pie izquierdo posterior" ? Color.red : Color.blue)
                                    .frame(width: pathBoundsLeftFootFront.width, height: pathBoundsLeftFootFront.height)
                                    .padding(.top, -20)
                                    .padding(.trailing, 5)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartString = "Pie izquierdo posterior"
                                        self.elementSelected = "Pie izquierdo posterior"
                                    }
                                ScaledBezier(bezierPath: .right_foot_back, pathBounds: pathBoundsRightFootBack)
                                    .fill(self.elementSelected == "Pie derecho posterior" ? Color.red : Color.blue)
                                    .frame(width: pathBoundsRightFootBack.width, height: pathBoundsRightFootBack.height)
                                    .padding(.top, -20)
                                    .padding(.leading, 5)
                                    .onTapGesture() {
                                        addWoundViewModel.bodyPartString = "Pie derecho posterior"
                                        self.elementSelected = "Pie derecho posterior"
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
