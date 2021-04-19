//
//  NoPictureView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 17/04/2021.
//

import SwiftUI

struct NoPictureView: View {
    var body: some View {
        VStack{
            Image(systemName: "photo.fill")
                .font(.system(size: 150))
            Text("Necesitamos una imagen")
                .multilineTextAlignment(.center)
                .font(.title2)
                .padding()
            Text("Saca una foto o usa una de la galería")
                .multilineTextAlignment(.center)
                //.padding()
        }.padding()
    }
}

struct NoPictureView_Previews: PreviewProvider {
    static var previews: some View {
        NoPictureView()
    }
}
