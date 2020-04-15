//
//  UserHistoryViewModel.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 15/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import Foundation

class UserHistoryViewModel: ViewModelProtocol {
    typealias ContentType = UserReport
    
    @Published var content: [ContentType]
    @Published var regularTitle: String
    @Published var boldTitle: String
    @Published var rowTitle: [String]
    @Published var rowSubtitle: [String]
    
    init() {
        self.content = fakeReports
        self.regularTitle = ""
        self.boldTitle = "Júlia"
        self.rowTitle = [String]()
        self.rowSubtitle = [String]()
        
        self.regularTitle = makeRegularTitle()
        self.rowTitle = makeRowTitle()
        self.rowSubtitle = makeRowSubtitle()
    }
    
//    func makeRegularTitle() -> String {
//        var regularTitle: String
//        
//        let date = Date()
//        let calendar = Calendar.current
//        let hour = calendar.component(.hour, from: date)
//        
//        if hour > 5 && hour < 12 {
//            regularTitle = "Bom dia, "
//        } else if hour >= 12 && hour < 18 {
//            regularTitle = "Boa tarde, "
//        } else {
//            regularTitle = "Boa noite, "
//        }
//        return regularTitle
//    }
    
    func makeRowTitle() -> [String] {
        var texts = [String]()
        self.content.forEach { (report) in
            texts.append(report.feeling.description)
        }
        return texts
    }
    
    func makeRowSubtitle() -> [String] {
        var texts = [String]()
        
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        
        self.content.forEach { (report) in
            texts.append(formatter.string(from: report.date))
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
