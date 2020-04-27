//
//  HeaderView.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 22/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

struct HeaderView: View {
    @Binding var showPicker: Bool
    @Binding var selected: SortOptions
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                SortButton(showPicker: $showPicker, selected: $selected)
                Spacer()
            }
            Spacer()
        }.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .background(Color.white)
            .cornerRadius(10)
            .padding(.bottom)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(showPicker: .constant(false), selected: .constant(.alphabetically))
    }
}
