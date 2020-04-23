//
//  PatientListViewModel.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 22/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import Foundation

class PatientListViewModel: ObservableObject {
    
    @Published var patients: [Patient] = []
    
    func setPatients(_ patients: [Patient]) {
        self.patients = patients
    }
    
    func sortList(by option: SortOptions) {
        switch option {
        case .alphabetically:
            self.patients.sort { (patient0, patient1) in
                patient0.name.lowercased() < patient1.name.lowercased()
            }
        case .addedData:
           break
        case .modifiedData:
            break
        }
    }
}
