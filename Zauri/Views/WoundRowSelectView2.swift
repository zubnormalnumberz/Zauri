//
//  WoundRowSelectView2.swift
//  Zauri
//
//  Created by Oihan Arroyo on 09/05/2021.
//

import SwiftUI

struct WoundRowSelectView2: View {
    let wound: Wound
    let patient: Patient
    @ObservedObject var asignPatientViewModel: AsignPatientViewModel
    
    var body: some View {
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
                    .foregroundColor(asignPatientViewModel.selectedWound.woundID == wound.woundID ? .white : .gray)
                    .padding(.bottom, 1)
                Text("Fecha de creación: \(wound.getDateFormat())")
                    .font(.subheadline)
                    .foregroundColor(asignPatientViewModel.selectedWound.woundID == wound.woundID ? .white : .gray)
            }
            Spacer()
            Text(String(wound.measurementQuantity))
                .font(.title2)
        }
        .padding()
        .background(asignPatientViewModel.selectedWound.woundID == wound.woundID ? Color.blue : Color(UIColor.systemBackground))
    }
}

struct WoundRowSelectView2_Previews: PreviewProvider {
    static var previews: some View {
        WoundRowSelectView2(wound: Wound(woundID: "String", pacientID: "String", createdBy: "String", resolved: true, comment: "String", commentEdited: "String", creationDate: Date(), woundType: 1, bodyPart: 1, measurementQuantity: 0), patient: Patient(patientID: "String", name: "String", surname1: "String", surname2: "String", sex: false, dateBirth: Date(), cic: 1, phone: 1), asignPatientViewModel: AsignPatientViewModel())
    }
}
