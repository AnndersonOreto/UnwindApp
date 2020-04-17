//
//  FeelingsInfo.swift
//  UnwindApp
//
//  Created by Annderson Packeiser Oreto on 10/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import Foundation

final class FeelingsInfo {
    
    static let sharedInstance = FeelingsInfo()
    
    var user_feeling: String = ""
    var user_emotions: [String] = []
    var user_situation: String = ""
    var user_thoughts: String = ""
    var user_action: String = ""
    var date: String = ""
    var image: String = ""
    
    init() {
        
    }
}

struct Feelings {
    
    var user_feeling: String = ""
    var user_emotions: String = ""
    var user_situation: String = ""
    var user_thoughts: String = ""
    var user_action: String = ""
    var date: String = ""
    var image: String = ""
}

struct FeelingsInfoArray {
    var user_array: [Feelings]
}
