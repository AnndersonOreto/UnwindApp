//
//  UserHistoryViewModel.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 15/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import Foundation
import SwiftUI

class UserHistoryViewModel: ObservableObject {
    
    @Published var feelings: [Feelings]
    @Published var userName: String
    
    init() {
        self.feelings = fakeReports
        self.userName = "Júlia"
    }
    
    func sortList(by option: SortOptions) {
        switch option {
        case .addedData:
            break
        case .alphabetically:
            break
        case .modifiedData:
            break
        }
    }
}
