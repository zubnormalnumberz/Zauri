//
//  NoPatientView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 10/04/2021.
//

import SwiftUI

struct NoPatientView: View {
    var body: some View {
        VStack{
            Image(systemName: "questionmark.folder")
                .font(.system(size: 150))
            Text("No estas trabajando con nigun paciente")
                .multilineTextAlignment(.center)
                .font(.title2)
                .padding()
            Text("Toca en el botón + para buscar un paciente con el que quieres trabajar")
                .multilineTextAlignment(.center)
                //.padding()
        }.padding()
    }
}

struct NoPatientView_Previews: PreviewProvider {
    static var previews: some View {
        NoPatientView()
            .previewDevice("iPhone 11")
    }
}
