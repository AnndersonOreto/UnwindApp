//
//  SortButton.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 06/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

struct SortButton: View {
    @Binding var showPicker: Bool
    
    var body: some View {
        
        Group {
            Button(action: {
                self.showPicker.toggle()
            }) {
                HStack(alignment: .center) {
                    Text("Ordenamento")
                    Image(systemName: "chevron.down")
                        .colorMultiply(.secondary)
                }.padding([.top, .leading])
            }
        }
    }
}

struct SortButton_Previews: PreviewProvider {
    static var previews: some View {
        SortButton(showPicker: .constant(false))
    }
}
