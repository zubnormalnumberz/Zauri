//
//  ReferenceMeasure.swift
//  Zauri
//
//  Created by Oihan Arroyo on 19/04/2021.
//

import SwiftUI

struct ReferenceMeasure: View {
    
    var units = ["Centimetro", "Milimetros"]
    @State private var selectedUnitIndex: Int = 0
    @State private var unit: String = ""
    @Environment(\.presentationMode) var referenceMeasureModal
    @ObservedObject var caliberViewModel = CaliberViewModel()
    
    var body: some View {
        NavigationView {
            VStack{
                Form {
                    Section(header: Text("Tamaño de referencia")) {
                        TextField("", text: $unit)
                            .keyboardType(.numberPad)
                    }
                    Section(header: Text("Tamaño de referencia")){
                        Picker(selection: $selectedUnitIndex, label: Text("Unidad")) {
                            ForEach(0 ..< units.count) {
                                Text(self.units[$0])
                            }
                        }
                    }
                }
                Spacer()
            }.navigationBarTitle(Text("Ajustar referencia"), displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                referenceMeasureModal.wrappedValue.dismiss()
            }) {
                Text("Cancelar")
            }, trailing: Button(action: {
                caliberViewModel.unit = Int(self.unit) ?? 0
                self.selectedUnitIndex == 0 ? (caliberViewModel.measureUnit = "cm") : (caliberViewModel.measureUnit = "mm")
                referenceMeasureModal.wrappedValue.dismiss()
            }) {
                Text("Guardar")
            }.disabled(self.unit == ""))
        }.onAppear {
            self.unit = String(caliberViewModel.getUnit())
            caliberViewModel.getMeasureUnit() == "cm" ? (self.selectedUnitIndex = 0) : (self.selectedUnitIndex = 1)
        }
    }
}

struct ReferenceMeasure_Previews: PreviewProvider {
    static var previews: some View {
        ReferenceMeasure(caliberViewModel: CaliberViewModel())
    }
}
