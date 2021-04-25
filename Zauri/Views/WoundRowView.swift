//
//  WoundRowView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 11/04/2021.
//

import SwiftUI

struct WoundRowView: View {
    
    let wound: Wound
    @State private var isPresented = false
    
    var body: some View {
        
        Button(action: {
                self.isPresented.toggle()
        }) {
            HStack {
                
                VStack(alignment: .leading) {
                    Text("Quemadura")
                        .font(.title3)
                        .padding(.bottom, 1)
                    Text("Pierna derecha frontal").font(.subheadline).foregroundColor(.gray)
                }
                Spacer()
                Text("0")
                    .font(.title2)
            }
            .padding()
            .fullScreenCover(isPresented: $isPresented){
                WoundView()
            }
        }
    }
}

struct WoundRowView_Previews: PreviewProvider {
    static var previews: some View {
        WoundRowView(wound: Wound(woundID: "String", pacientID: "String", createdBy: "String", resolved: false, comment: "String", commentEdited: "String", creationDate: Date(), woundType: 1, bodyPart: 1, commentIntroDate: Date()))
    }
}
