//
//  FeelingsInfo.swift
//  UnwindApp
//
//  Created by Annderson Packeiser Oreto on 10/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import Foundation

struct FeelingsInfo {
    var user_feeling: String
    var user_emotions: [String]
    var user_situation: String
    var user_thoughts: String
    var user_action: String
}

struct FeelingsInfoArray {
    var user_array: [FeelingsInfo]
}
