//
//  ViewModelProtocol.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 15/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import Foundation

protocol ViewModelProtocol: ObservableObject {
    associatedtype ContentType
    
    var content: [ContentType] { get }
    var regularTitle: String { get }
    var boldTitle: String { get }
    var rowTitle: [String] { get }
    var rowSubtitle: [String] { get }
    var rowImage: [String] { get }
    
    func makeRowTitle() -> [String]
    func makeRowSubtitle() -> [String]
    func makeRowImage() -> [String]
    func sortList(by option: SortOptions)
}

extension ViewModelProtocol {
    func makeRegularTitle() -> String {
        var regularTitle: String
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        if hour > 5 && hour < 12 {
            regularTitle = "Bom dia, "
        } else if hour >= 12 && hour < 18 {
            regularTitle = "Boa tarde, "
        } else {
            regularTitle = "Boa noite, "
        }
        return regularTitle
    }
}
