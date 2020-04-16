//
//  UserTypePicker.swift
//  UnwindApp
//
//  Created by Marcus Vinicius Vieira Badiale on 14/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import Foundation
import SwiftUI

enum UserTypeOptions: String, CaseIterable, Identifiable {
    
    var id: UserTypeOptions { self }
    
    case patient = "Paciente"
    case psychiatrit = "Psiquiatra"
    case therapist = "Terapeuta"
}

struct UserTypePicker: View {
    
    @Binding var selected: UserTypeOptions

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(alignment: .bottom) {
                Text("Opção")
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity)
                Text("Sou \(self.selected.rawValue)")
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity)
            }.padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .clipped()
            .shadow(radius: 10, x: 1, y: 0)
            Picker(selection: self.$selected, label: Text("Ordenamento")) {
                ForEach(UserTypeOptions.allCases) { (element) in
                    Text(element.rawValue)
                }
            }.labelsHidden()
            .frame(maxWidth: .infinity)
            .background(CustomColor.pickerBackground.color)
        }
    }
}
