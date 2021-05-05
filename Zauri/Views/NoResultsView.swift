//
//  NoResultsView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 04/05/2021.
//

import SwiftUI

struct NoResultsView: View {
    
    var text: String
    
    var body: some View {
        VStack{
            Image(systemName: "person.fill.questionmark")
                .font(.system(size: 150))
            Text("No se encontraron resultados para \(text)")
                .multilineTextAlignment(.center)
                .font(.title2)
                .padding()
        }.padding()
    }
}

struct NoResultsView_Previews: PreviewProvider {
    static var previews: some View {
        NoResultsView(text: "message")
    }
}
