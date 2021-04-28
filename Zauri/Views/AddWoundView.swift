//
//  AddWoundView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 13/04/2021.
//

import SwiftUI
import AlertToast

struct AddWoundView: View {
    
    @State private var showToast = false
    var patient: Patient
    @ObservedObject var addWoundViewModel = AddWoundViewModel()
    @ObservedObject var patientViewModel: PatientViewModel
    @Environment(\.presentationMode) private var addWoundPresentation
    @EnvironmentObject var session: UserService
    
    func getUser() {
        session.listen()
        addWoundViewModel.userId = session.self.session?.userID ?? ""
    }
    
    var body: some View {
        NavigationView {
            VStack{
                Form {
                    NavigationLink(destination: BodyPartView(addWoundViewModel: self.addWoundViewModel)) {
                        HStack {
                            Text("Parte del cuerpo")
                            Spacer()
                            TextField("", text: $addWoundViewModel.bodyPartString).multilineTextAlignment(.trailing)
                                .disabled(true)
                        }
                    }
                    Picker(selection: self.$addWoundViewModel.selectedWoundTypeIndex, label: Text("Tipo de herida")) {
                        ForEach(WoundType.allCases) { (woundType) in
                            Text(woundType.string)
                        }
                    }
                    TextEditor(text: $addWoundViewModel.comment)
                        .background(
                            HStack(alignment: .top) {
                                addWoundViewModel.comment == "" ? Text("Descripción de le herida") : Text("")
                                Spacer()
                            }
                            .foregroundColor(Color.primary.opacity(0.25))
                            .padding(EdgeInsets(top: 0, leading: 4, bottom: 7, trailing: 0))
                        )
                }
            }
                .onAppear(){
                    getUser()
                    addWoundViewModel.patientId = self.patient.patientID
                }
                .navigationBarTitle(Text("Añadir herida"), displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    self.addWoundPresentation.wrappedValue.dismiss()
                }) {
                    Text("Cancelar")
                }, trailing: Button(action: {
                    if addWoundViewModel.comment.isEmpty{
                        self.showToast.toggle()
                    }else{
                        self.addWoundViewModel.saveWound()
                    }
                }) {
                    Text("Guardar")
                        .foregroundColor(addWoundViewModel.comment.isEmpty ? .gray : .blue)
                })
                .onReceive(addWoundViewModel .viewDismissalModePublisher) { shouldDismiss in
                    if shouldDismiss {
                        self.patientViewModel.createdWound = true
                        self.addWoundPresentation.wrappedValue.dismiss()
                    }
                }
            .toast(isPresenting: $showToast, duration: 3){

                AlertToast(type: .error(Color.red), title: "Error!", subTitle: "La descripción de la herida es obligatoria")
                    }
        }
    }
}

struct AddWoundView_Previews: PreviewProvider {
    static var previews: some View {
        AddWoundView(patient: Patient(patientID: "sdgds", name: "Izena", surname1: "Abizena1", surname2: "Abizena2", sex: false, dateBirth: Date(), cic: 1234567, phone: 656772418), patientViewModel: PatientViewModel())
    }
}
