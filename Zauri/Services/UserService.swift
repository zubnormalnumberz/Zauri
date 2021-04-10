//
//  UserService.swift
//  Zauri
//
//  Created by Oihan Arroyo on 09/04/2021.
//

import Combine
import FirebaseAuth

class UserService: ObservableObject {
    
    var didChange = PassthroughSubject<UserService, Never>()
    @Published var session: User? {didSet {self.didChange.send(self)}}
    var handle: AuthStateDidChangeListenerHandle?
    
    func listen(){
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let user = user {
                self.session = User(userID: user.uid, email: user.email ?? "")
            } else {
                self.session = nil
            }
        })
    }
    
    func signIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.session = nil
        } catch {
            print("error sign out")
        }
    }
    
    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit {
        unbind()
    }
    
}
