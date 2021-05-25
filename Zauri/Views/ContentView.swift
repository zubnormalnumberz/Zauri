//
//  ContentView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 10/04/2021.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var session: UserService
    @EnvironmentObject var modal: ModalState
    
    func getUser(){
        session.listen()
    }
    
    var body: some View {
        Group{
            ZStack {
                if session.session != nil {
                    BottomTabsView()
                } else {
                    LoginView()
                }
            }.transition(.slide)
        }.onAppear(perform: getUser)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserService())
            .environmentObject(ModalState())
    }
}
