//
//  NoWoundView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 10/04/2021.
//

import SwiftUI

struct NoWoundView: View {
    var body: some View {
        VStack{
            Image(systemName: "bandage.fill")
                .font(.system(size: 150))
            Text("Este paciente no tiene ninguna herida no resuelta")
                .multilineTextAlignment(.center)
                .font(.title2)
                .padding()
            Text("Toca en el botón + para añadir una")
                .multilineTextAlignment(.center)
                //.padding()
        }.padding()
    }
}

struct NoWoundView_Previews: PreviewProvider {
    static var previews: some View {
        NoWoundView()
    }
}
