//
//  DetailViewModel.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 09/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import Foundation

class DetailViewModel: ObservableObject {
    
    @Published var userName: String
    @Published var date = FeelingsInfo.sharedInstance.date
    @Published var feeling: Feeling
    @Published var emotions: [Emotion]
    @Published var situation = FeelingsInfo.sharedInstance.user_situation
    @Published var thought = FeelingsInfo.sharedInstance.user_thoughts
    @Published var action: String = ""
    @Published var numberOfEmotions: Int = 3
    
    init() {
        self.userName = ""
        self.feeling = fakeFeeling
        self.emotions = fakeEmotions
        
        if self.emotions.count < 3 {
            self.numberOfEmotions = self.emotions.count
        }
    }
    
    func sendReport() { }
}
