//
//  NoMeasurementView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 10/04/2021.
//

import SwiftUI

struct NoMeasurementView: View {
    var body: some View {
        VStack{
            Image(systemName: "ruler.fill")
                .font(.system(size: 150))
            Text("Esta herida no tiene ninguna medición")
                .multilineTextAlignment(.center)
                .font(.title2)
                .padding()
            Text("Toca en 'Acciones -> Añadir medición' para añadir la primera")
                .multilineTextAlignment(.center)
                //.padding()
        }.padding()
    }
}

struct NoMeasurementView_Previews: PreviewProvider {
    static var previews: some View {
        NoMeasurementView()
    }
}
