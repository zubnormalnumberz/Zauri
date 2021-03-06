//
//  TreatmentView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 22/04/2021.
//

import SwiftUI
import AlertToast

struct TreatmentView: View {
    
    @ObservedObject var modalState: ModalState

    @ObservedObject var treatmentViewModel = TreatmentViewModel()
    @State private var showToast = false
    @State private var showToast2 = false
    
    var image: UIImage?
    var points: [CGPoint]
    var woundID: String
    var patientID: String
    var userID: String
    var scale: Scale
    @Binding var rootIsActive : Bool
        
    func handleData(){
        treatmentViewModel.image = image
        treatmentViewModel.points = points
        treatmentViewModel.woundID = woundID
        treatmentViewModel.patientID = patientID
        treatmentViewModel.userID = userID
        treatmentViewModel.scale = scale
    }
    
    var body: some View {
        VStack{
            Form {
                Picker(selection: $treatmentViewModel.selectedDressingType, label: Text("Tipo de apósito")) {
                    ForEach(DressingType.allCases) { (dressingType) in
                        Text(dressingType.string)
                    }
                }
                TextEditor(text: $treatmentViewModel.comment)
                    .background(
                        HStack(alignment: .top) {
                            treatmentViewModel.comment == "" ? Text("Descripción del tratamiento aplicado") : Text("")
                            Spacer()
                        }
                        .foregroundColor(Color.primary.opacity(0.25))
                        .padding(EdgeInsets(top: 0, leading: 4, bottom: 7, trailing: 0))
                    )
            }
            Spacer()
        }
        .navigationBarTitle(Text("Tratamiento"), displayMode: .inline)
        .navigationBarItems(trailing: treatmentViewModel.woundID == "" ?
                                AnyView(self.selectUserNavigationLink) : AnyView(self.saveWoundButton))
        .onAppear(perform: handleData)
        .onReceive(treatmentViewModel.viewDismissalModePublisher) { shouldDismiss in
            if shouldDismiss {
                self.showToast = false
                self.showToast2 = true
            }
        }
        .toast(isPresenting: $showToast){
            AlertToast(type: .loading, title: "Guardando medición...")
        }
        .toast(isPresenting: ($showToast2), duration: 2.5, alert: {
           
            AlertToast(type: .complete(Color.green), title: "La medición se ha guardado correctamente")
           
        }, completion: { dismissed in
            self.modalState.isWoundViewModalPresented = false
            self.modalState.isCamera2ViewModalPresented = false
            self.modalState.isCaliberViewModalPresented = false
        })
    }
    
    var selectUserNavigationLink: some View {
      NavigationLink(
        destination: SearchPatientForMeasurementView(modalState: self.modalState, userID: self.userID, image: self.image, points: self.points, scale: self.scale, treatment: treatmentViewModel.comment, dressingType: treatmentViewModel.selectedDressingType, shouldPopToRootView: self.$rootIsActive),
        label: {
            Text("Seleccionar paciente")
        })
    }
    
    var saveWoundButton: some View {
        Button(action: {
            treatmentViewModel.saveMeasurement()
            self.showToast = true
        }){
           Text("Guardar medición")
        }
    }
}

struct TreatmentView_Previews: PreviewProvider {
    static var previews: some View {
        TreatmentView(modalState: ModalState(), image: UIImage(named: "arm"), points: [CGPoint(x: 172.5, y: 252.0), CGPoint(x: 148.0, y: 266.0), CGPoint(x: 131.0, y: 290.5), CGPoint(x: 120.5, y: 316.5), CGPoint(x: 118.5, y: 340.0), CGPoint(x: 121.0, y: 364.0), CGPoint(x: 133.5, y: 383.5), CGPoint(x: 152.0, y: 404.5)], woundID: "String", patientID: "String", userID: "String", scale: Scale(unit: 1, measureUnit: "cm", scale: []), rootIsActive: .constant(false))
    }
}
