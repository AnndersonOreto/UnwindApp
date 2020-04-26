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
    var image: String = "default"
    
    init() {
        
    }
}

struct Feelings: Identifiable {
    let id = UUID()
    let user_feeling: String
    let user_emotions: String
    let user_situation: String
    let user_thoughts: String
    let user_action: String
    let date: String
    let image: String
}

struct FeelingsInfoArray {
    let user_array: [Feelings]
}
