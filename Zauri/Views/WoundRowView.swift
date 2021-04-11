//
//  WoundRowView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 11/04/2021.
//

import SwiftUI

struct WoundRowView: View {
    var body: some View {
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
        }.padding()
    }
}

struct WoundRowView_Previews: PreviewProvider {
    static var previews: some View {
        WoundRowView()
    }
}
