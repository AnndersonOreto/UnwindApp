//
//  TitleAndText.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 09/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

struct TitleAndText: View {
    @State var title: String
    @State var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(.primary)
                .fontWeight(.semibold)
            Spacer()
            Text(text)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
        }
    }
}

struct TitleAndText_Previews: PreviewProvider {
    static var previews: some View {
        TitleAndText(title: "Title", text: "Text")
    }
}
