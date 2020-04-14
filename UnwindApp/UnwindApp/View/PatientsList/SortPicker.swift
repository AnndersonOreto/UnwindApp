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
        VStack(alignment: .center, spacing: 0) {
            HStack(alignment: .bottom) {
                Text("Ordenamento")
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity)
                Text("\(self.selected.rawValue)")
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity)
            }.padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .clipped()
            .shadow(radius: 10, x: 1, y: 0)
            Picker(selection: self.$selected, label: Text("Ordenamento")) {
                ForEach(SortOptions.allCases) { (sortOption) in
                    Text(sortOption.rawValue)
                }
            }.labelsHidden()
            .frame(maxWidth: .infinity)
            .background(CustomColor.pickerBackground.color)
        }
    }
}

struct SortPicker_Previews: PreviewProvider {
    static var previews: some View {
        SortPicker(selected: .constant(.alphabetically))
    }
}
