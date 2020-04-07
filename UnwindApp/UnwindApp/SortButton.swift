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
    
    let sortTypes = ["Alfabética", "Data de adição", "Data de modificação"]
    
    @State var sortAlphabetically: Bool = false
    @State var selectedSort = 0
    @State var showList = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Button(action: {
                self.showList.toggle()
            }) {
                HStack(alignment: .center) {
                    Text("Ordenamento")
                    Image(systemName: "chevron.down")
                        .colorMultiply(.secondary)
                }.padding([.top, .leading])
            }
            if showList {
                Picker("", selection: $selectedSort) {
                    ForEach(0 ..< sortTypes.count) {
                        Text(self.sortTypes[$0])
                    }
                }
            }
        }
        
//        Button(action: {
//            self.sortAlphabetically.toggle()
//            if self.sortAlphabetically {
//                self.viewModel.sortPatientsAlphabetically()
//            } else {
//                self.viewModel.sortPatientsAlphabeticallyReverse()
//            }
//        }) {
//            HStack(alignment: .center) {
//                Text("Ordenamento")
//                Image(systemName: "chevron.down")
//                    .colorMultiply(.secondary)
//            }.padding([.top, .leading])
//        }
    }
}

struct SortButton_Previews: PreviewProvider {
    static var previews: some View {
        SortButton()
    }
}
