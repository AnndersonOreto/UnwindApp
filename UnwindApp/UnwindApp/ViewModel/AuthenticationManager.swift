//
//  AuthenticationManager.swift
//  UnwindApp
//
//  Created by Annderson Packeiser Oreto on 07/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import Foundation
import SwiftUI
import FirebaseAuth
import Combine

class AuthenticationManager: ObservableObject {
    
    var didchange = PassthroughSubject<AuthenticationManager, Never>()
    @Published var profile: AuthenticationProfile? {
        didSet {
            self.didchange.send(self)
        }
    }
    var handle: AuthStateDidChangeListenerHandle?
    
    func listen() {
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            
            if let user = user {
                
                self.profile = AuthenticationProfile(id: user.uid, email: user.email)
            } else {
                
                self.profile = nil
            }
        }
    }
    
    func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        
        Auth.auth().createUser(withEmail: email, password: password)
    }
    
    func signIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func logout() {
        
        do {
            try Auth.auth().signOut()
            self.profile = nil
        } catch {
            print("Logout error")
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
