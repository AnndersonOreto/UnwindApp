//
//  UserHistoryViewModel.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 15/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import Foundation
import SwiftUI

class UserHistoryViewModel: ViewModelProtocol {
    typealias ContentType = Feelings
    
    @Published var content: [ContentType] = fakeReports
    @Published var regularTitle: String
    @Published var boldTitle: String = profileName
    @Published var rowTitle: [String]
    @Published var rowSubtitle: [String]
    @Published var rowImage: [String]
    
    init() {
        self.regularTitle = ""
        self.rowTitle = [String]()
        self.rowSubtitle = [String]()
        self.rowImage = [String]()
        
        self.regularTitle = makeRegularTitle()
        self.rowTitle = makeRowTitle()
        self.rowSubtitle = makeRowSubtitle()
        self.rowImage = makeRowImage()
    }
    
    func makeRowImage() -> [String] {
        
        var images = [String]()
        self.content.forEach { (report) in
            images.append(report.image)
        }
        return images
    }
    
    func makeRowTitle() -> [String] {
        var texts = [String]()
        self.content.forEach { (report) in
            texts.append(report.user_feeling)
        }
        return texts
    }
    
    func makeRowSubtitle() -> [String] {
        var texts = [String]()
        
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        
        self.content.forEach { (report) in
            texts.append(report.date)
        }
        return texts
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
