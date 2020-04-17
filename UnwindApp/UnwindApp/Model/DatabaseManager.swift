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
    
    func saveFeelings(userUid: String, completion: @escaping(FeelingsInfoArray)->()) {
        
        let userEmotions: String = FeelingsInfo.sharedInstance.user_emotions.reduce("") { text, name in "\(text),\(name)" }
        
        let date = Date()
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "hh:mm dd/MM/yyyy"
        
        FeelingsInfo.sharedInstance.date = dateFormatter.string(from: date)
        
        let post = ["user_feeling": FeelingsInfo.sharedInstance.user_feeling,
                    "user_emotions": userEmotions,
                    "user_situation": FeelingsInfo.sharedInstance.user_situation,
                    "user_thoughts": FeelingsInfo.sharedInstance.user_thoughts,
                    "user_action": FeelingsInfo.sharedInstance.user_action,
                    "date": dateFormatter.string(from: date),
                    "image": FeelingsInfo.sharedInstance.image]
        
        ref.child("users").child(userUid).child("feelings").childByAutoId().setValue(post) { (error, ret) in
            
            if let error = error {
                
                print(error.localizedDescription)
            } else {
                
                self.getFeelings(userUid: userUid, completion: { data in
                    
                    fakeReports = data.user_array
                    completion(data)
                })
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
    
    func getFeelings(userUid: String, completion: @escaping(FeelingsInfoArray)->()) {
        
        ref.child("users").child(userUid).child("feelings").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let value = snapshot.value as? NSDictionary {
                
                var feelings: [Feelings] = []
                
                for val in value {
                    
                    let feelingDict = val.value as? NSDictionary
                    let user_feeling = feelingDict?["user_feeling"] as? String ?? ""
                    let user_emotions: String = feelingDict?["user_emotions"] as? String ?? ""
                    let user_situation: String = feelingDict?["user_situation"] as? String ?? ""
                    let user_thoughts: String = feelingDict?["user_thoughts"] as? String ?? ""
                    let user_action: String = feelingDict?["user_action"] as? String ?? ""
                    let date: String = feelingDict?["date"] as? String ?? ""
                    let image: String = feelingDict?["image"] as? String ?? ""
                    let feeling = Feelings(user_feeling: user_feeling, user_emotions: user_emotions, user_situation: user_situation, user_thoughts: user_thoughts, user_action: user_action, date: date, image: image)
                    feelings.append(feeling)
                }
                
                let feelingsArray: FeelingsInfoArray = FeelingsInfoArray(user_array: feelings)
                
                completion(feelingsArray)
            } else {
                print("erro")
            }
        })
    }
}
