//
//  SettingsView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 05/04/2021.
//

import SwiftUI
import AlertToast

struct SettingsView: View {
    
    var languages = ["Euskera", "Castellano"]
    @State private var selectedLanguageIndex = 1
    var appearance = ["Claro", "Oscuro", "Igual que el sistema"]
    @State private var selectedAppearanceIndex = 2
    @EnvironmentObject var session: UserService
    @ObservedObject var settingsViewModel = SettingsViewModel()
    @State private var showLogOutToast = false
    
    func getUser() {
        session.listen()
    }
    
    var body: some View {
        Group{
            NavigationView {
                VStack{
                    HStack{
                        Image(systemName: "person.crop.circle")
                        Text("Kaixo, \(session.self.session?.getFullName() ?? "")")
                        Spacer()
                    }.padding()
                    Form {
                        Section(header: Text("Ajustes generales")) {
                            Picker(selection: $selectedLanguageIndex, label: Text("Idioma")) {
                                ForEach(0 ..< languages.count) {
                                    Text(self.languages[$0])
                                }
                            }
                            Picker(selection: $selectedAppearanceIndex, label: Text("Apariencia")) {
                                ForEach(0 ..< appearance.count) {
                                    Text(self.appearance[$0])
                                }
                            }
                        }
                        Section(header: Text("ABOUT")) {
                            HStack {
                                Text("Version")
                                Spacer()
                                Text("0.1")
                            }
                            NavigationLink(destination : AboutUsView()) {
                                Text("Acerca de")
                            }
                        }
                    }
                    Spacer()
                    HStack{
                        Text("Desarrollado por ")
                        Link("Zubnormal Numberz", destination: URL(string: "https://github.com/zubnormalnumberz")!)
                    }
                    Button("Cerrar sesión") {
                        showLogOutToast = true
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(8)
                    .padding()
                }
                .navigationBarTitle("Ajustes")
            }
            //}
        }.onAppear(perform: getUser)
        .toast(isPresenting: $showLogOutToast, duration: 2, alert: {
            AlertToast(type: .regular, title: "Cerrando sesión...")
        }, completion: { dismissed in
            session.signOut()
        })
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .preferredColorScheme(.dark)
    }
}
