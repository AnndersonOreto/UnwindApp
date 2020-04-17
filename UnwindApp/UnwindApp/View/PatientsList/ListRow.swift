//
//  PatientRow.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 06/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

struct ListRow: View {
    
    let imageName: String
    let text1: String
    let text2: String
    
    var body: some View {
        HStack(alignment: .center) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 80)
            VStack(alignment: .leading) {
                Text(text1)
                    .foregroundColor(.primary)
                    .font(.system(size: 20, weight: .semibold))
                Text(text2).foregroundColor(.secondary)
                    .font(.system(size: 15, weight: .semibold))
                    .lineLimit(1)
            }
        }
    }
}

//struct PatientRow_Previews: PreviewProvider {
//    static var previews: some View {
//        ListRow(text1: "Name", text2: "Phone number | e-mail")
//    }
//}
