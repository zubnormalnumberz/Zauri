//
//  AboutUsView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 11/04/2021.
//

import SwiftUI

struct AboutUsView: View {
    var body: some View {
        VStack{
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150)
                .padding(.top)
            Text("Zauri 0.1")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Text("Zubnormal Numberz")
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            Divider()
            VStack{
                Text("Esta aplicación ha sido diseñada e implementada como trabajo de fin del master de de desarrollo de aplicaciones para dispositivos móviles de la ")
                + Text("Universitat Oberta de Catalunya")
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .fontWeight(.bold)
            }
            .padding(.horizontal)
            Text("Cualquier duda, sugerencia o corrección por favor contacta conmigo a traves de mi perfil de Github")
                .padding()
            Spacer()
        }
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView()
    }
}
