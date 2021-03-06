//
//  PatientView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 05/04/2021.
//

import SwiftUI
import AlertToast

struct PatientView: View {
    
    let patient: Patient
    @StateObject private var patientViewModel = PatientViewModel()
    @State var showingSheet = false
    @Environment(\.presentationMode) private var addWoundPresentation
    
    var body: some View {
        VStack{
            if patientViewModel.downloading {
                ProgressView("Downloadingâ€¦")
            }else{
                VStack{
                    Text(patient.getInitials())
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .frame(width: 45, height: 45, alignment: .center)
                        .padding()
                        .background(Color.blue)
                        .clipShape(Circle())
                    Text("\(patient.name) \(patient.surname1) \(patient.surname2)")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                    Text("\(patient.dateToString()) (\(patient.getAge()))")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.top, 5)
                }
                .padding()
                Divider()
                Spacer()
                VStack{
                    if patientViewModel.wounds.count == 0{
                        Spacer()
                        NoWoundView()
                        Spacer()
                    }else{
                        List(patientViewModel.wounds, id: \.woundID) { wound in
                            WoundRowView(wound: wound, patient: patient)
                        }
                    }
                }
            }
        }
        .onAppear(perform: {
            patientViewModel.fetchWoundsData(patient: self.patient)
        })
        .navigationBarItems(trailing: Button(action: {
            self.showingSheet.toggle()
        }, label: {
            Image(systemName: "plus")
        }))
        .navigationBarTitle("", displayMode: .inline)
        .sheet(isPresented: $showingSheet) {
            AddWoundView(patient: patient, patientViewModel: self.patientViewModel)
        }.toast(isPresenting: $patientViewModel.createdWound, duration: 3){
            
            AlertToast(type: .complete(Color.green), title: "La herida se ha creado correctamente")
        }
    }
}

struct PatientView_Previews: PreviewProvider {
    static var previews: some View {
        PatientView(patient: Patient(patientID: "sdgds", name: "Izena", surname1: "Abizena1", surname2: "Abizena2", sex: false, dateBirth: Date(), cic: 1234567, phone: 656772418))
            .preferredColorScheme(.dark)
    }
}
