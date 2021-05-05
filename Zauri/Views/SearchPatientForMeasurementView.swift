//
//  SearchPatientForMeasurementView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 04/05/2021.
//

import SwiftUI

struct SearchPatientForMeasurementView: View {
    
    @ObservedObject var searchPatientForMeasurementViewModel = SearchPatientForMeasurementViewModel()
    
    var body: some View {
        VStack{
            VStack {
                HStack {
                    TextField("Nombre, apellido, CIC...", text: $searchPatientForMeasurementViewModel.searchText)
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
                                if searchPatientForMeasurementViewModel.searchText != "" {
                                    Button(action: {
                                        searchPatientForMeasurementViewModel.searchText = ""
                                        searchPatientForMeasurementViewModel.searched = false
                                    }) {
                                        Image(systemName: "multiply.circle.fill")
                                            .padding(.trailing, 8)
                                    }
                                }
                            }
                        )
                        .padding(.horizontal, 10)
                        if searchPatientForMeasurementViewModel.searchText != "" {
                            Button(action: {
                                hideKeyboard()
                                searchPatientForMeasurementViewModel.fetchPatientsData()
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
                if searchPatientForMeasurementViewModel.getSelectedWound().woundID == ""{
                    VStack{
                        Text("Ninguna herida seleccionada")
                    }
                    .padding(.all, 10)
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                }else{
                    HStack {
                        VStack(alignment: .leading){
                            Text("Paciente: \(searchPatientForMeasurementViewModel.getSelectedPatient().getShortName())")
                            Text("Herida: \(WoundType(rawValue: searchPatientForMeasurementViewModel.getSelectedWound().woundType)!.string) en \(BodyPart(rawValue: searchPatientForMeasurementViewModel.getSelectedWound().bodyPart)!.string)")
                        }
                        .padding(.all, 10)
                        Spacer()
                        Button(action: {
                            searchPatientForMeasurementViewModel.updateSelectedWound(wound: searchPatientForMeasurementViewModel.defaultWound)
                            searchPatientForMeasurementViewModel.updateSelectedPatient(patient: searchPatientForMeasurementViewModel.defaultPatient)
                        }) {
                            Image(systemName: "trash.fill")
                                .font(.system(size: 25))
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    .background(Color.blue)
                }
                if searchPatientForMeasurementViewModel.searching {
                    ProgressView("Buscando…")
                }else{
                    if !searchPatientForMeasurementViewModel.searched {
                        Spacer()
                        Text("Puedes buscar un paciente por nombre, apellido o CIC").multilineTextAlignment(.center).padding()
                        Spacer()
                    }else if searchPatientForMeasurementViewModel.searched && searchPatientForMeasurementViewModel.patients.count == 0 {
                        Spacer()
                        NoResultsView(text: searchPatientForMeasurementViewModel.searchText)
                        Spacer()
                    }else{
                        List(searchPatientForMeasurementViewModel.patients, id: \.patientID) { patient in
                            NavigationLink(destination: WoundsOfPatientView(patient: patient, searchPatientForMeasurementViewModel: self.searchPatientForMeasurementViewModel)) {
                                PatientRowView(patient: patient)
                                    .background(searchPatientForMeasurementViewModel.getSelectedPatient().patientID == patient.patientID ? Color.blue : Color(UIColor.systemBackground))
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Buscar paciente", displayMode: .inline)
            .navigationBarItems(trailing: searchPatientForMeasurementViewModel.getSelectedWound().woundID == "" ?
                                    AnyView(self.savePendingMeasurementButton) : AnyView(self.saveMeasurementButton))
        }
    }
    
    var savePendingMeasurementButton: some View {
        Button(action: {
            print("Guardar medición pendiente")
        }){
           Text("Saltar")
        }
    }
    
    var saveMeasurementButton: some View {
        Button(action: {
            print("Guardar medición")
        }){
           Text("Guardar medición")
        }
    }
}

struct SearchPatientForMeasurementView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPatientForMeasurementView()
    }
}
