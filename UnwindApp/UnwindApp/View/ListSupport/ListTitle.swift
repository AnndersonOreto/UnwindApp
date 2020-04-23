//
//  ListTitle.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 14/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

struct ListTitle: View {
    @State var regularText: String
    @State var boldText: String
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(regularText)
                .fontWeight(.regular)
            + Text(boldText)
                .fontWeight(.bold)
        }.font(.system(size: 40))
        .foregroundColor(.white)
    }
}

struct ListTitle_Previews: PreviewProvider {
    static var previews: some View {
        ListTitle(regularText: "Boa tarde, ", boldText: "Júlia")
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (9.7-inch)"))
    }
}
