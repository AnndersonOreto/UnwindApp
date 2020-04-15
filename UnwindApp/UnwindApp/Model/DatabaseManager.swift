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
        
        ref.child("users").child(userUid).setValue(post) { (error, ret) in
            
            if let error = error {
                
                print(error.localizedDescription)
            }
        }
    }
    
    func saveFeelings(userUid: String, feelings: FeelingsInfo) {
        
        let userEmotions: String = feelings.user_emotions.reduce("") { text, name in "\(text),\(name)" }
        
        let feelingsArray = ["user_feeling": feelings.user_feeling,
                             "user_emotions": userEmotions,
                             "user_situation": feelings.user_situation,
                             "user_thoughts": feelings.user_thoughts,
                             "user_action": feelings.user_action]
        
        let post = ["feelings": feelingsArray]
        
        ref.child("users").child(userUid).setValue(post) { (error, ret) in
            
            if let error = error {
                
                print(error.localizedDescription)
            }
        }
    }
    
    func saveMaster(userUid: String, master: String) {
        
        let post = ["master": master]
        
        ref.child("users").child(userUid).setValue(post) { (error, ret) in
            
            if let error = error {
                
                print(error.localizedDescription)
            }
        }
    }
    
    func getUserProfile(userUid: String, completion: @escaping(AuthenticationProfile)->()) {
        
        ref.child("users").child(userUid).observeSingleEvent(of: .value, with: { (snapshopt) in
            
            let value = snapshopt.value as? NSDictionary
            let email = ""
            let name = value?["name"] as? String ?? ""
            let phone = value?["phone"] as? String ?? ""
            let role = value?["role"] as? String ?? ""
            
            let profile = AuthenticationProfile(id: userUid, email: email, name: name, phone: phone, role: role)
            
            completion(profile)
        })
    }
}
