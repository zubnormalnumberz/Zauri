//
//  SettingsView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 05/04/2021.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var session: UserService
    
    func getUser() {
        session.listen()
    }
    
    var body: some View {
        Group{
            NavigationView {
                VStack{
                    Text("klahflh")
                    Spacer()
                    Button("Cerrar sesión") {
                        session.signOut()
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
        }.onAppear(perform: getUser)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
