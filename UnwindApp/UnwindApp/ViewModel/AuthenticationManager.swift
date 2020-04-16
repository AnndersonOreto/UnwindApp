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
    
    private var database = DatabaseManager()
    var didchange = PassthroughSubject<AuthenticationManager, Never>()
    @Published var profile: AuthenticationProfile? {
        didSet {
            self.didchange.send(self)
        }
    }
    var handle: AuthStateDidChangeListenerHandle?
    
    
    @Published var selectedTab: Int = 0
    
    func listen() {
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            
            if let user = user {
                
                self.database.getUserProfile(userUid: user.uid, completion: { profile in
                    
                    self.profile = profile
                })
            } else {
                
                self.profile = nil
            }
        }
    }
    
    func signUp(email: String, password: String, phone: String, name: String, role: String, handler: @escaping AuthDataResultCallback) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            if let userResult = user?.user {
                
                self.database.saveNewProfile(email: email, name: name, phone: phone, role: role, userUid: userResult.uid)
            } else {
                
                print(error?.localizedDescription ?? "")
            }
        }
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
    
    func saveFeelingsPackage() {
        
        guard let userUid = Auth.auth().currentUser?.uid else { return }
        
        self.database.saveFeelings(userUid: userUid)
    }
    
    deinit {
        unbind()
    }
}
