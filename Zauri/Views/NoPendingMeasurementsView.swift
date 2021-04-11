//
//  NoPendingMeasurementsView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 11/04/2021.
//

import SwiftUI

struct NoPendingMeasurementsView: View {
    var body: some View {
        VStack{
            Image(systemName: "tray.fill")
                .font(.system(size: 150))
            Text("Nada por aqui...de momento")
                .multilineTextAlignment(.center)
                .font(.title2)
                .padding()
            Text("No tienes ninguna medición pendiente")
                .multilineTextAlignment(.center)
        }.padding()
    }
}

struct NoPendingMeasurementsView_Previews: PreviewProvider {
    static var previews: some View {
        NoPendingMeasurementsView()
    }
}
