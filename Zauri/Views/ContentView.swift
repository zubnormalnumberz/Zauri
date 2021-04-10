//
//  ContentView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 10/04/2021.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var session: UserService
    
    func getUser(){
        session.listen()
    }
    
    var body: some View {
        Group{
            if session.session != nil {
                BottomTabsView()
            } else {
                LoginView()
            }
        }.onAppear(perform: getUser)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UserService())
    }
}
