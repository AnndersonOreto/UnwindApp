//
//  DatabaseManager.swift
//  UnwindApp
//
//  Created by Annderson Packeiser Oreto on 10/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DatabaseManager {
    
    private var ref: DatabaseReference!
    
    init() {
        
        ref = Database.database().reference()
    }
    
    func saveNewProfile(email: String, name: String, phone: String, role: String, userUid: String) {
        
        let post = ["email": email,
                    "name": name,
                    "phone": phone,
                    "role": role]
        
        ref.child("users").childByAutoId().setValue(post) { (error, ret) in
            
            if let error = error {
                
                print(error.localizedDescription)
            }
        }
    }
    
    func saveFeelings(profile: AuthenticationProfile) {
        
    }
}
