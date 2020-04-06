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
    
    func sortPatientsAlphabetically() {
        self.patients.sort { (patient0, patient1) in
            patient0.name.lowercased() < patient1.name.lowercased()
        }
    }
    
    func sortPatientsAlphabeticallyReverse() {
        self.patients.sort { (patient0, patient1) in
            patient0.name.lowercased() > patient1.name.lowercased()
        }
    }
}
