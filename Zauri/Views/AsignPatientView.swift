//
//  AsignPatientView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 09/05/2021.
//

import SwiftUI

struct AsignPatientView: View {
    
    @ObservedObject var asignPatientViewModel = AsignPatientViewModel()
    @Environment(\.presentationMode) var asignPatientView
    var pendingMeasurement: PendingMeasurements
    @ObservedObject var pendingMeasurementViewModel: PendingMeasurementsViewModel
    
    func handleData(){
        asignPatientViewModel.pendingMeasurement = pendingMeasurement
    }
    
    var body: some View {
        VStack{
            VStack {
                HStack {
                    TextField("Nombre, apellido, CIC...", text: $asignPatientViewModel.searchText)
                        .padding(7)
                        .padding(.horizontal, 25)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .overlay(
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 8)
                                if asignPatientViewModel.searchText != "" {
                                    Button(action: {
                                        asignPatientViewModel.searchText = ""
                                        asignPatientViewModel.searched = false
                                    }) {
                                        Image(systemName: "multiply.circle.fill")
                                            .padding(.trailing, 8)
                                    }
                                }
                            }
                        )
                        .padding(.horizontal, 10)
                        if asignPatientViewModel.searchText != "" {
                            Button(action: {
                                hideKeyboard()
                                asignPatientViewModel.fetchPatientsData()
                            }) {
                                Text("Buscar")
                            }
                            .padding(.trailing, 10)
                            .transition(.move(edge: .trailing))
                            .animation(.default)
                        }
                }
                .padding(.top, 15)
                .padding(.horizontal, 10)
                if asignPatientViewModel.selectedWound.woundID == ""{
                    VStack{
                        Text("Ningun paciente seleccionado")
                    }
                    .padding(.all, 10)
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                }else{
                    HStack {
                        VStack(alignment: .leading){
                            Text("Paciente: \(asignPatientViewModel.selectedPatient.getShortName())")
                            Text("Herida: \(WoundType(rawValue: asignPatientViewModel.selectedWound.woundType)!.string) en \(BodyPart(rawValue: asignPatientViewModel.selectedWound.bodyPart)!.string)")
                        }
                        .padding(.all, 10)
                        Spacer()
                        Button(action: {
                            asignPatientViewModel.selectedWound = asignPatientViewModel.defaultWound
                            asignPatientViewModel.selectedPatient = asignPatientViewModel.defaultPatient
                        }) {
                            Image(systemName: "trash.fill")
                                .font(.system(size: 25))
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    .background(Color.blue)
                }
                if asignPatientViewModel.searching {
                    ProgressView("Buscando…")
                }else{
                    if !asignPatientViewModel.searched {
                        Spacer()
                        Text("Puedes buscar un paciente por nombre, apellido o CIC").multilineTextAlignment(.center).padding()
                        Spacer()
                    }else if asignPatientViewModel.searched && asignPatientViewModel.patients.count == 0 {
                        Spacer()
                        NoResultsView(text: asignPatientViewModel.searchText)
                        Spacer()
                    }else{
                        List(asignPatientViewModel.patients, id: \.patientID) { patient in
                            NavigationLink(destination: WoundsOfPatientView2(patient: patient, asignPatientViewModel: self.asignPatientViewModel)) {
                                PatientRowView(patient: patient)
                                    .background(asignPatientViewModel.selectedPatient.patientID == patient.patientID ? Color.blue : Color(UIColor.systemBackground))
                            }
                        }
                    }
                }
            }
            .onAppear(perform: handleData)
            .navigationBarTitle("Buscar paciente", displayMode: .inline)
            .navigationBarItems(trailing: Button("Asignar") {
                asignPatientViewModel.saveMeasurementData()
                asignPatientView.wrappedValue.dismiss()
                pendingMeasurementViewModel.asigned = true
            }.disabled(asignPatientViewModel.selectedWound.woundID == ""))
        }
    }
}

struct AsignPatientView_Previews: PreviewProvider {
    static var previews: some View {
        AsignPatientView(pendingMeasurement: PendingMeasurements(measurementID: "String", userID: "String", width: 1, height: 1, area: 1, perimeter: 1, imageURL: "String", points: [], treatment: "String", dressingType: 1, creationDate: Date(), treatmentEdit: "String", editDate: Date()), pendingMeasurementViewModel: PendingMeasurementsViewModel())
    }
}
