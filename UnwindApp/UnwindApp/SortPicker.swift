//
//  SortPicker.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 07/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

enum SortOptions: String, CaseIterable, Identifiable {
    var id: SortOptions { self }
    
    case alphabetically = "Alfabético"
    case addedData = "Data de adição"
    case modifiedData = "Data de modificação"
}

struct SortPicker: View {
    @Binding var selected: SortOptions
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .foregroundColor(.white)
                .frame(height: 250)
                .shadow(radius: 50)
            Rectangle()
                .foregroundColor(Color(red: 250/256, green: 251/256, blue: 250/256))
                .frame(height: 200)
            VStack(alignment: .center) {
                HStack(alignment: .bottom) {
                    Text("Ordenamento")
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity)
                    Text("\(self.selected.rawValue)")
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity)
                }
                Picker(selection: self.$selected, label: Text("Ordenamento")) {
                    ForEach(SortOptions.allCases) { (element) in
                        Text(element.rawValue)
                    }
                }.labelsHidden()
                    .frame(height: 200)
            }
        }
    }
}

struct SortPicker_Previews: PreviewProvider {
    static var previews: some View {
        SortPicker(selected: .constant(.alphabetically))
    }
}
