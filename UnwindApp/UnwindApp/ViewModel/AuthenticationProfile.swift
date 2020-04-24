//
//  AuthenticationProfile.swift
//  UnwindApp
//
//  Created by Annderson Packeiser Oreto on 07/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import Foundation
import Combine

class AuthenticationProfile {
    
    var id: String
    var email: String?
    var name: String = ""
    var phone: String = ""
    var role: String = ""
    var pending: String = ""
    @Published var feelings: FeelingsInfoArray = FeelingsInfoArray(user_array: [])
    @Published var patients: [Patient] = []
    
    init(id: String, email: String?) {
        
        self.id = id;
        self.email = email;
    }
    
    init(id: String, email: String?, name: String, phone: String, role: String, pending: String) {
        
        self.id = id
        self.email = email
        self.name = name
        self.phone = phone
        self.role = role
        self.pending = pending
    }
    
    init(id: String, email: String?, name: String, phone: String, role: String, pending: String, patients: [Patient]) {
        
        self.id = id
        self.email = email
        self.name = name
        self.phone = phone
        self.role = role
        self.pending = pending
        self.patients = patients
    }
    
    func setPatients(_ patients: [Patient]) {
        self.patients = patients
    }
}
