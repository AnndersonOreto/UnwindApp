//
//  HistoryViewModel.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 22/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import Foundation
import Combine

class HistoryViewModel: ObservableObject {
    
    @Published var feelings: [Feelings]
    
    init() {
        self.feelings = []
    }
    
    func setFeelings(_ feelings: [Feelings]) {
        
        DispatchQueue.main.async { [weak self] in
            
            guard let self = self else { return }
            
            self.feelings = feelings
        }
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
