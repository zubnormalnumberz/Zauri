//
//  PatientView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 05/04/2021.
//

import SwiftUI

struct PatientView: View {
    
    let patient: Patient
    @State var showingSheet = false
    @Environment(\.presentationMode) private var addWoundPresentation
    
    var body: some View {
        VStack{
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
                Spacer()
                //NoWoundView()
                List {
                        WoundRowView()
                        WoundRowView()
                        WoundRowView()
                    }
                Spacer()
            }
        }.navigationBarItems(trailing: Button(action: {
            self.showingSheet.toggle()
        }, label: {
            Image(systemName: "plus")
        }))
        .navigationBarTitle("", displayMode: .inline)
        .sheet(isPresented: $showingSheet) {
                    AddWoundView()
        }
    }
}

struct PatientView_Previews: PreviewProvider {
    static var previews: some View {
        PatientView(patient: Patient(patientID: "sdgds", name: "Izena", surname1: "Abizena1", surname2: "Abizena2", sex: false, dateBirth: Date(), cic: 1234567, phone: 656772418))
            .preferredColorScheme(.dark)
    }
}
