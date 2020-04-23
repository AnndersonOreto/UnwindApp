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
                
                self.database.getUserProfile(userUid: self.replaceEmail(email: user.email ?? ""), completion: { profile in
                    
                    self.profile = profile
                    profileName = profile.name
                })
                
                self.getFeelingsList()
            } else {
                
                self.profile = nil
            }
        }
    }
    
    func signUp(email: String, password: String, phone: String, name: String, role: String, handler: @escaping AuthDataResultCallback) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            if let userResult = user?.user {
                
                self.database.saveNewProfile(email: self.replaceEmail(email: email), name: name, phone: phone, role: role, userUid: userResult.uid)
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
        
        guard let userUid = Auth.auth().currentUser?.email else { return }
        
        self.database.saveFeelings(userUid: self.replaceEmail(email: userUid)) { data in
            
            self.profile?.feelings = data
        }
    }
    
    func getFeelingsList() {
        
        guard let userUid = Auth.auth().currentUser?.email else { return }
        
        self.database.getFeelings(userUid: self.replaceEmail(email: userUid), completion: { feelings in
            
            DispatchQueue.main.async {
                self.profile?.feelings = feelings
                fakeReports = feelings.user_array
            }
        })
    }
    
    func getPendingStatus() {
        guard let userUid = Auth.auth().currentUser?.email else { return }
        
        self.database.getPendingStatus(userUid: self.replaceEmail(email: userUid)) { (pendingStatus) in
            self.profile?.pending = pendingStatus
        }
    }
    
    func acceptPending() {
        guard let userUid = Auth.auth().currentUser?.email else { return }
        
        self.database.acceptPending(source: self.replaceEmail(email: userUid), target: self.profile?.pending ?? "")
    }
    
    func replaceEmail(email: String) -> String {
        
        if email.contains(".") {
            return email.replacingOccurrences(of: ".", with: "(dot)").lowercased()
        } else {
            return email.replacingOccurrences(of: "(dot)", with: ".").lowercased()
        }
    }
    
    deinit {
        unbind()
    }
}
