//
//  BottomTabsView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 05/04/2021.
//

import SwiftUI

struct BottomTabsView: View {
    var body: some View {
        TabView {
            PatientsView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Pacientes")
                }
            Text("Añadir medición")
                .tabItem {
                    Image(systemName: "camera.fill")
                    Text("Añadir medición")
                }
            PendingMeasurementsView()
                .tabItem {
                    Image(systemName: "hourglass.tophalf.fill")
                    Text("Mediciones pendientes")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Ajustes")
                }
        }
    }
}

struct BottomTabsView_Previews: PreviewProvider {
    static var previews: some View {
        BottomTabsView()
            .previewDevice("iPhone 11")
    }
}
