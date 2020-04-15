//
//  AuthenticationProfile.swift
//  UnwindApp
//
//  Created by Annderson Packeiser Oreto on 07/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import Foundation

class AuthenticationProfile {
    
    var id: String
    var email: String?
    var name: String = ""
    var phone: String = ""
    var role: String = ""
    
    init(id: String, email: String?) {
        
        self.id = id;
        self.email = email;
    }
    
    init(id: String, email: String?, name: String, phone: String, role: String) {
        
        self.id = id
        self.email = email
        self.name = name
        self.phone = phone
        self.role = role
    }
}
