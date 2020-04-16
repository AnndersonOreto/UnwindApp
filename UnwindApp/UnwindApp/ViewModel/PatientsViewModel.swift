//
//  PatientsViewModel.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 06/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import Foundation

class PatientsViewModel: ObservableObject, ViewModelProtocol {
    typealias ContentType = Patient
    
    @Published var content: [ContentType]
    @Published var regularTitle: String
    @Published var boldTitle: String
    @Published var rowTitle: [String]
    @Published var rowSubtitle: [String]
    
    init() {
        self.content = fakePatients
        self.regularTitle = ""
        self.boldTitle = "Carol da Silva"
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
        self.content.forEach { (patient) in
            texts.append(patient.name)
        }
        return texts
    }
    
    func makeRowSubtitle() -> [String] {
        var texts = [String]()
        self.content.forEach { (patient) in
            let string = patient.phoneNumber + " | " + patient.email
            texts.append(string)
        }
        return texts
    }
    
    func sortList(by option: SortOptions) {
        switch option {
        case .alphabetically:
            self.content.sort { (patient0, patient1) in
                patient0.name.lowercased() < patient1.name.lowercased()
            }
            self.rowTitle = makeRowTitle()
        case .addedData:
           break
        case .modifiedData:
            break
        }
    }
}
