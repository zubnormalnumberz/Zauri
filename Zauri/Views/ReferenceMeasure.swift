//
//  ReferenceMeasure.swift
//  Zauri
//
//  Created by Oihan Arroyo on 19/04/2021.
//

import SwiftUI

struct ReferenceMeasure: View {
    
    var units = ["Centimetro", "Milimetros"]
    @State private var selectedUnitIndex = 0
    @State private var unit: String = "1"
    @Environment(\.presentationMode) var referenceMeasureModal
    
    var body: some View {
        NavigationView {
            VStack{
                Form {
                    Section(header: Text("Tamaño de referencia")) {
                        TextField("", text: $unit)
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
                referenceMeasureModal.wrappedValue.dismiss()
            }) {
                Text("Guardar")
            })
        }
    }
}

struct ReferenceMeasure_Previews: PreviewProvider {
    static var previews: some View {
        ReferenceMeasure()
    }
}
