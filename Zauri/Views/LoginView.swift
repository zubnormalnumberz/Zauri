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
    @State private var editingUsername = false
    @State private var editingPassword = false
    @State private var showPassword = false
        
    var body: some View {
        NavigationView {
        ZStack{
            Color.blue.ignoresSafeArea(.all)
            VStack(spacing: 20) {
                Text("Welcome to Zauri!")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.bottom, 50)
                HStack{
                    Image(systemName: "person")
                        .foregroundColor(.white)
                    TextField("Usuario", text: $username, onEditingChanged: { edit in
                        self.editingUsername = edit
                    })
                    .disableAutocorrection(true)
                    .accentColor(.white)
                        //.padding()
                        //.border(Color.white, width: 1.5)
                }
                .padding()
                .background( editingUsername ? Color.blue : .gray)
                .border(editingUsername ? Color.white : .gray, width: 2)
                .cornerRadius(4.0)
                HStack{
                    Image(systemName: "lock")
                        .foregroundColor(.white)
                    if(showPassword){
                        TextField("Contraseña", text: $password, onEditingChanged: { edit in
                                  self.editingPassword = edit
                              })
                            .accentColor(.white)
                        .disableAutocorrection(true)
                    }else{
                        SecureField("Contraseña", text: $password).onTapGesture {
                            self.editingPassword.toggle()
                        }
                            .accentColor(.white)
                    }
                    Button(action: { self.showPassword.toggle()}) {
                        Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .background( editingPassword ? Color.blue : .gray)
                .border(editingPassword ? Color.white : .gray, width: 2)
                .cornerRadius(4.0)
                Button("Iniciar sesión") {
                    print("Thank you!")
                }
                    .foregroundColor(buttonTextColor)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(buttonColor)
                    .cornerRadius(8)
                    .disabled(username == "" || password == "")
            }.padding()
        }
    }
        .onTapGesture {
            self.editingPassword = false
            hideKeyboard()
        }
    }
    
    var buttonColor: Color {
        return (username == "" || password == "") ? .gray : .white
    }
    
    var buttonTextColor: Color {
        return (username == "" || password == "") ? .black : .blue
    }
    
    func borderColor(editing: Bool) -> Color {
        return (username == "" || password == "") ? .black : .blue
    }

    func textFieldBackground(editing: Bool) -> Color {
        return (username == "" || password == "") ? .black : .blue
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .previewDevice("iPhone SE (1st generation)")
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
