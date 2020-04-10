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
    
    init(id: String, email: String?) {
        
        self.id = id;
        self.email = email;
    }
}
