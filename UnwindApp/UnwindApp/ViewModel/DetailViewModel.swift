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
    @Published var date: String
    @Published var hour: String
    @Published var feeling: Feeling
    @Published var emotions: [Emotion]
    @Published var situation: String
    @Published var thought: String
    @Published var action: String
    @Published var numberOfEmotions: Int = 3
    
    init() {
        self.userName = "Julia"
        self.date = "Hoje"
        self.hour = "15:25"
        self.feeling = fakeFeeling
        self.emotions = fakeEmotions
        
        self.situation = "Situação: It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using ‘Content here, content here’, making it look like."
        
        self.thought = "Pensamento: It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using ‘Content here, content here’, making it look like."
        
        self.action = "Action: It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using ‘Content here, content here’, making it look like."
        
        if self.emotions.count < 3 {
            self.numberOfEmotions = self.emotions.count
        }
    }
    
    func sendReport() { }
}
