//
//  WoundRowView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 11/04/2021.
//

import SwiftUI

struct WoundRowView: View {
    
    let wound: Wound
    let patient: Patient
    @State private var isPresented = false
    
    var body: some View {
        Button(action: {
                self.isPresented.toggle()
        }) {
            HStack {
                
                VStack(alignment: .leading) {
                    HStack{
                        Text(WoundType(rawValue: wound.woundType)!.string)
                            .font(.title3)
                        if wound.resolved {
                            Text("(Resuelto)")
                                .font(.title3)
                        }
                    }.padding(.bottom, 1)
                    Text(BodyPart(rawValue: wound.bodyPart)!.string)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.bottom, 1)
                    Text("Fecha de creación: \(wound.getDateFormat())")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                Text(String(wound.measurementQuantity))
                    .font(.title2)
            }
            .padding()
            .fullScreenCover(isPresented: $isPresented){
                WoundView(wound: wound, patient: patient)
            }
        }
    }
}

struct WoundRowView_Previews: PreviewProvider {
    static var previews: some View {
        WoundRowView(wound: Wound(woundID: "String", pacientID: "String", createdBy: "String", resolved: true, comment: "String", commentEdited: "String", creationDate: Date(), woundType: 1, bodyPart: 1, measurementQuantity: 0), patient: Patient(patientID: "String", name: "String", surname1: "String", surname2: "String", sex: false, dateBirth: Date(), cic: 1, phone: 1))
    }
}
