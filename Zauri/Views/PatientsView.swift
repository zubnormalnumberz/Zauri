//
//  PatientsView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 05/04/2021.
//

import SwiftUI

struct PatientsView: View {
    
    @ObservedObject private var patientsViewModel = PatientsViewModel()
    
    var body: some View {
        NavigationView {
            VStack{
                if patientsViewModel.patients.count == 0{
                    NoPatientView()
                }else{
                    List(patientsViewModel.patients, id: \.patientID) { patient in
                        NavigationLink(destination: PatientView(patient: patient)) {
                            PatientRowView(patient: patient)
                        }
                    }
                }
            }.onAppear(){
                self.patientsViewModel.fetchPatientsData()
            }
            .navigationBarTitle("Pacientes")
            .navigationBarItems(trailing: Button(action: {
                print("Buscar paciente")
            }, label: {
                Image(systemName: "plus")
            }))
        }
    }
}

struct PatientsView_Previews: PreviewProvider {
    static var previews: some View {
        PatientsView()
            .previewDevice("iPhone 11")
    }
}
