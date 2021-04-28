//
//  AddWoundView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 13/04/2021.
//

import SwiftUI

struct AddWoundView: View {
    
    @ObservedObject var addWoundViewModel = AddWoundViewModel()
    @State var selectedLanguageIndex = 0
    @Environment(\.presentationMode) private var addWoundPresentation
    
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
                    Picker(selection: self.$selectedLanguageIndex, label: Text("Tipo de herida")) {
                        ForEach(0 ..< self.addWoundViewModel.woundTypes.count) {
                            Text(self.addWoundViewModel.woundTypes[$0])
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
                Spacer()
            }
                .navigationBarTitle(Text("Añadir herida"), displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    self.addWoundPresentation.wrappedValue.dismiss()
                }) {
                    Text("Cancelar")
                }, trailing: Button(action: {
                    //Zaurixe gorde
                    print("Dismissing sheet view...")
                }) {
                    Text("Guardar")
                })
        }
    }
}

struct AddWoundView_Previews: PreviewProvider {
    static var previews: some View {
        AddWoundView()
    }
}
