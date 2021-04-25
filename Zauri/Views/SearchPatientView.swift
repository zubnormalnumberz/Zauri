//
//  SearchPatientView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 23/04/2021.
//

import SwiftUI

struct SearchPatientView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var searchPatientViewModel = SearchPatientViewModel()
    private var onePatient = Patient(patientID: "String", name: "String", surname1: "String", surname2: "String", sex: false, dateBirth: Date(), cic: 1234567, phone: 653159847)
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Nombre, apellido, CIC...", text: $searchPatientViewModel.searchText)
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
                                if searchPatientViewModel.searchText != "" {
                                    Button(action: {
                                        searchPatientViewModel.searchText = ""
                                    }) {
                                        Image(systemName: "multiply.circle.fill")
                                            .padding(.trailing, 8)
                                    }
                                }
                            }
                        )
                        .padding(.horizontal, 10)
                        if searchPatientViewModel.searchText != "" {
                            Button(action: {
                                searchPatientViewModel.fetchPatientsData()
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
                if !searchPatientViewModel.searched {
                    Spacer()
                    Text("Puedes buscar un paciente por nombre, apellido o CIC").multilineTextAlignment(.center).padding()
                    Spacer()
                }else if searchPatientViewModel.searched && searchPatientViewModel.patients.count == 0{
                    Spacer()
                    Text("No hay resultados para esta busqueda").multilineTextAlignment(.center).padding()
                    Spacer()
                }else{
                    List(searchPatientViewModel.patients, id: \.patientID) { patient in
                        NavigationLink(destination: PatientView(patient: patient)) {
                            PatientRowView(patient: patient)
                        }
                    }
                }
            }
            .navigationBarTitle("Buscar paciente", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Cerrar")
            }))
        }
        /*.onTapGesture {
            hideKeyboard()
        }*/
    }
}

struct SearchPatientView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPatientView()
    }
}