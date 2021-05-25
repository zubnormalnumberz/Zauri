//
//  BottomTabsView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 05/04/2021.
//

import SwiftUI
import Combine

struct BottomTabsView: View {
    
    @State private var selectedItem = 1
    
    var body: some View {
        TabView(selection: $selectedItem) {
            PatientsView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Pacientes")
                }
                .tag(1)
            CameraView(woundID: "", patientID: "")
                .tabItem {
                    Image(systemName: "camera.fill")
                    Text("Añadir medición")
                }
                .tag(2)
            PendingMeasurementsView()
                .tabItem {
                    Image(systemName: "hourglass.tophalf.fill")
                    Text("Mediciones pendientes")
                }
                .tag(3)
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Ajustes")
                }
                .tag(4)
        }
    }
}

struct BottomTabsView_Previews: PreviewProvider {
    static var previews: some View {
        BottomTabsView()
            .previewDevice("iPhone 11")
    }
}
