//
//  PatientRow.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 06/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

struct PatientRow: View {
    
    let name: String
    let phoneNumber: String
    let email: String
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "person.crop.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 80)
            VStack(alignment: .leading) {
                Text(name)
                    .foregroundColor(.primary)
                    .font(.system(size: 20, weight: .semibold))
                HStack(alignment: .center) {
                    Text(phoneNumber)
                    Text("|")
                    Text(email)
                }.foregroundColor(.secondary)
                    .font(.system(size: 15, weight: .semibold))
                .lineLimit(1)
            }
        }
    }
}

struct PatientRow_Previews: PreviewProvider {
    static var previews: some View {
        PatientRow(name: "Name", phoneNumber: "Phone number", email: "e-mail")
    }
}
