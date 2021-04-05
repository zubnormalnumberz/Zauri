//
//  LoginView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 05/04/2021.
//

import SwiftUI

struct LoginView: View {
    
    //MARK: Properties
    @State var username: String = ""
    @State var password: String = ""
    @State private var showPassword = false
        
    var body: some View {
        ZStack{
            Color.blue.ignoresSafeArea(.all)
            VStack(spacing: 20) {
                Text("Welcome to Zauri!")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Image("logo")
                     .resizable()
                     .aspectRatio(contentMode: .fill)
                     .frame(width: 200.0, height: 200.0, alignment: .center)
                     .clipped()
                HStack{
                    Image(systemName: "person")
                        .foregroundColor(.white)
                    TextField("Usuario", text: $username)
                        .accentColor(.white)
                        //.padding()
                        //.border(Color.white, width: 1.5)
                }
                .padding()
                //.background(Color.gray)
                .border(Color.white, width: 2)
                .cornerRadius(4.0)
                HStack{
                    Image(systemName: "lock")
                        .foregroundColor(.white)
                    if(showPassword){
                        TextField("Contraseña", text: $password)
                            .accentColor(.white)
                    }else{
                        SecureField("Contraseña", text: $password)
                            .accentColor(.white)
                    }
                    Button(action: { self.showPassword.toggle()}) {
                        Image(systemName: "eye")
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .border(Color.white, width: 2)
                .cornerRadius(4.0)
                Button("Iniciar sesión") {}
                    .foregroundColor(.blue)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(8)
            }.padding()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
