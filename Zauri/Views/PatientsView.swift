//
//  PatientsView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 05/04/2021.
//

import SwiftUI

struct PatientsView: View {
    var body: some View {
        NavigationView {
            VStack{
                NoPatientView()
            }
            .navigationBarTitle("Pacientes")
            .navigationBarItems(trailing: Button(action: {
                print("Search")
            }, label: {
                Image(systemName: "plus")
            }))
        }
    }
}

struct PatientsView_Previews: PreviewProvider {
    static var previews: some View {
        PatientsView()
    }
}
