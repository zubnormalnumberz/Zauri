//
//  TreatmentView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 22/04/2021.
//

import SwiftUI

struct TreatmentView: View {
    
    @State private var selectedStrength = "Mild"
    let strengths = ["Mild", "Medium", "Mature"]
    @State private var comment = ""
    
    var body: some View {
        VStack{
            Form {
                Picker("Tipo de apósito", selection: $selectedStrength) {
                    ForEach(strengths, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Comentario", text: $comment)
            }
            Spacer()
        }
        .navigationBarTitle(Text("Resultado de la medición"), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            print("Go to add info")
        }) {
            Text("Seguir")
        })
    }
}

struct TreatmentView_Previews: PreviewProvider {
    static var previews: some View {
        TreatmentView()
    }
}
