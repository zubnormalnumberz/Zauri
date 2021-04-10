//
//  PatientRowView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 05/04/2021.
//

import SwiftUI

struct PatientRowView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Nombre Apellido1 Apellido 2")
                    .font(.title3)
                    .padding(.bottom, 1)
                Text("7/9/1998 (23)").font(.subheadline).foregroundColor(.gray)
            }
            Spacer()
        }.padding()
    }
}

struct PatientRowView_Previews: PreviewProvider {
    static var previews: some View {
        PatientRowView()
    }
}
