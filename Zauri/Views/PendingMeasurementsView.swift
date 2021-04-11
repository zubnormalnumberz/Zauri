//
//  PendingMeasurements.swift
//  Zauri
//
//  Created by Oihan Arroyo on 05/04/2021.
//

import SwiftUI

struct PendingMeasurementsView: View {
    var body: some View {
        NavigationView {
            VStack{
               NoPendingMeasurementsView()
            }
            .navigationBarTitle("Mediciones pendientes")
        }
    }
}

struct PendingMeasurements_Previews: PreviewProvider {
    static var previews: some View {
        PendingMeasurementsView()
    }
}
