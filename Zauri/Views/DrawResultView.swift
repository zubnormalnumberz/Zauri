//
//  DrawResultView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 20/04/2021.
//

import SwiftUI

struct DrawResultView: View {
    
    @ObservedObject var modalState: ModalState
    
    var image: UIImage?
    var points: [CGPoint]
    var scale: Scale
    
    var woundID: String
    var patientID: String
    var userID: String
    
    @Binding var rootIsActive : Bool
    
    var body: some View {
        VStack{
            ZStack{
                Image(uiImage: image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                DrawShapeEnd(points: points)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.green)
                VStack{
                    HStack {
                        Text("\(scale.getArea(points: self.points)) \(scale.measureUnit)") + Text("2")
                            .baselineOffset(6.0)
                    }.padding(5.0)
                    .foregroundColor(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(Color.green, lineWidth: 2.0)
                    ).background(RoundedRectangle(cornerRadius: 10.0).fill(Color.green))
                }.position(x: points[0].x-35, y: points[0].y-25)
            }.aspectRatio(contentMode: .fit)
            HStack{
                VStack(alignment: .leading){
                    Text("Longitud (L): - \(scale.measureUnit)")
                        .padding(.bottom, 10)
                    Text("Area: \(scale.getArea(points: self.points)) \(scale.measureUnit)") + Text("2")
                        .baselineOffset(6.0)
                }.padding()
                VStack(alignment: .leading){
                    Text("Anchura (A): - \(scale.measureUnit)")
                        .padding(.bottom, 10)
                    Text("Perimetro: \(scale.getPerimeter(points: self.points)) \(scale.measureUnit)")
                }.padding()
            }.background(RoundedRectangle(cornerRadius: 16).fill(Color.blue))
            NavigationLink(
                destination: TreatmentView(modalState: self.modalState, image: self.image, points: points, woundID: self.woundID, patientID: self.patientID, userID: self.userID, scale: scale, rootIsActive: self.$rootIsActive),
                label: {
                    Text("Confirmar medidas")
                }).padding()
        }
        .navigationBarTitle(Text("Resultado"), displayMode: .inline)
    }
}

struct DrawResultView_Previews: PreviewProvider {
    
    static var previews: some View {
        DrawResultView(modalState: ModalState(), image: UIImage(named: "arm"), points: [CGPoint(x: 172.5, y: 252.0), CGPoint(x: 148.0, y: 266.0), CGPoint(x: 131.0, y: 290.5), CGPoint(x: 120.5, y: 316.5), CGPoint(x: 118.5, y: 340.0), CGPoint(x: 121.0, y: 364.0), CGPoint(x: 133.5, y: 383.5), CGPoint(x: 152.0, y: 404.5)], scale: Scale(unit: 1, measureUnit: "cm", scale: [CGPoint(x: 1.0, y: 2.0), CGPoint(x: 5.0, y: 10.0)]), woundID: "String", patientID: "String", userID: "String", rootIsActive: .constant(false))
    }
}
