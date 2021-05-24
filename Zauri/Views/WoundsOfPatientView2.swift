//
//  WoundsOfPatientView2.swift
//  Zauri
//
//  Created by Oihan Arroyo on 09/05/2021.
//

import SwiftUI
import AlertToast

struct WoundsOfPatientView2: View {
    let patient: Patient
    @ObservedObject var asignPatientViewModel: AsignPatientViewModel
    @StateObject private var woundsOfPatientViewModel = WoundsOfPatientViewModel()
    @State private var showToast = false
    
    var body: some View {
        VStack{
            if woundsOfPatientViewModel.downloading {
                ProgressView("Downloading…")
            }else{
                VStack{
                    if woundsOfPatientViewModel.wounds.count == 0{
                        Spacer()
                        Text("No wounds")
                        Spacer()
                    }else{
                        List(woundsOfPatientViewModel.wounds, id: \.woundID) { wound in
                            WoundRowSelectView2(wound: wound, patient: patient, asignPatientViewModel: asignPatientViewModel)
                                .onTapGesture {
                                    asignPatientViewModel.selectedPatient = patient
                                    asignPatientViewModel.selectedWound = wound
                                    showToast = true
                                }
                        }
                    }
                }
            }
        }
        .toast(isPresenting: $showToast, duration: 2){
            AlertToast(type: .complete(Color.green), title: "La herida se ha seleccionado correctamente")
        }
        .onAppear(perform: {
            woundsOfPatientViewModel.fetchWoundsData(patient: self.patient)
        })
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct WoundsOfPatientView2_Previews: PreviewProvider {
    static var previews: some View {
        WoundsOfPatientView2(patient: Patient(patientID: "sdgds", name: "Izena", surname1: "Abizena1", surname2: "Abizena2", sex: false, dateBirth: Date(), cic: 1234567, phone: 656772418), asignPatientViewModel: AsignPatientViewModel())
    }
}
