//
//  SortButton.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 06/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

struct SortButton: View {
    @EnvironmentObject var viewModel: PatientsViewModel
    @State var sortAlphabetically: Bool = false
    
    var body: some View {
        Button(action: {
            self.sortAlphabetically.toggle()
            if self.sortAlphabetically {
                self.viewModel.sortPatientsAlphabetically()
            } else {
                self.viewModel.sortPatientsAlphabeticallyReverse()
            }
        }) {
            HStack(alignment: .center) {
                Text("Ordem alfabética")
                Image(systemName: "chevron.down")
                    .colorMultiply(.secondary)
            }.padding([.top, .leading])
        }
    }
}

struct SortButton_Previews: PreviewProvider {
    static var previews: some View {
        SortButton()
    }
}
