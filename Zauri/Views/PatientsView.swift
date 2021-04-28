//
//  PatientsView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 05/04/2021.
//

import SwiftUI

struct PatientsView: View {
    
    @ObservedObject private var patientsViewModel = PatientsViewModel()
    @State private var isPresented = false
    @EnvironmentObject var session: UserService
    
    func getUser() {
        session.listen()
        patientsViewModel.userId = session.self.session?.userID ?? ""
    }
    
    var body: some View {
        NavigationView {
            VStack{
                if patientsViewModel.downloading {
                    ProgressView("Downloading…")
                }else{
                    if patientsViewModel.patients.count == 0{
                        NoPatientView()
                    }else{
                        List(patientsViewModel.patients, id: \.patientID) { patient in
                            NavigationLink(destination: PatientView(patient: patient)) {
                                PatientRowView(patient: patient)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Pacientes")
            .navigationBarItems(trailing: Button(action: {
                isPresented.toggle()
            }, label: {
                Image(systemName: "plus")
            }))
        }.fullScreenCover(isPresented: $isPresented){
            SearchPatientView()
        }.onAppear(){
            getUser()
            patientsViewModel.getWoundsData()
        }
    }
}

struct PatientsView_Previews: PreviewProvider {
    static var previews: some View {
        PatientsView()
            .previewDevice("iPhone 11")
    }
}
