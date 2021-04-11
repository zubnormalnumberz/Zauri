//
//  PatientRowView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 05/04/2021.
//

import SwiftUI

struct PatientRowView: View {
    
    let patient: Patient
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(patient.name) \(patient.surname1) \(patient.surname2)")
                    .font(.title3)
                    .padding(.bottom, 1)
                Text("\(patient.dateToString()) (\(patient.getAge()))").font(.subheadline).foregroundColor(.gray)
            }
            Spacer()
        }.padding()
    }
}

struct PatientRowView_Previews: PreviewProvider {
    static var previews: some View {
        PatientRowView(patient: Patient(patientID: "sdgds", name: "Izena", surname1: "Abizena1", surname2: "Abizena2", sex: false, dateBirth: Date(), cic: 1234567, phone: 656772418))
    }
}
