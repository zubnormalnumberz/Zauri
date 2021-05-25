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
    @EnvironmentObject var session: UserService
    
    func getUser() {
        session.listen()
    }
    
    var body: some View {
        TabView(selection: $selectedItem) {
            PatientsView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Pacientes")
                }
                .tag(1)
            CameraView(woundID: "", patientID: "", userID: self.session.self.session?.userID ?? "")
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
        }.onAppear(){
            getUser()
        }
    }
}

struct BottomTabsView_Previews: PreviewProvider {
    static var previews: some View {
        BottomTabsView()
            .previewDevice("iPhone 11")
    }
}
