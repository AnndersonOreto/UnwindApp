//
//  PatientsViewModel.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 06/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import Foundation

class PatientsViewModel: ObservableObject {
    
    @Published var patients = [Patient]()
    var doctorName = String()
    
    init() {
        self.doctorName = "Carol da Silva"
        self.patients = fakePatients
    }
    
    func sortPatients(by option: SortOptions) {
        switch option {
        case .alphabetically:
            self.patients.sort { (patient0, patient1) in
                patient0.name.lowercased() < patient1.name.lowercased()
            }
        case .addedData:
            self.patients.sort { (patient0, patient1) in
                patient0.name.lowercased() > patient1.name.lowercased()
            }
        case .modifiedData:
            break
        }
    }
}
