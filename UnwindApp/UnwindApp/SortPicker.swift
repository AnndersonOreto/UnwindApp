//
//  SortPicker.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 07/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

struct SortPicker: View {
    @Binding var selected: Int
    
    let options = ["Alfabético", "Data de adição", "Data de modificação"]
    
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
                    Spacer()
                    Text("Ordenamento")
                        .foregroundColor(.secondary)
                        .frame(alignment: .center)
                    Spacer()
                    Text("\(self.selected)")
                        .foregroundColor(.primary)
                        .frame(alignment: .center)
                    Spacer()
                }
                Picker(selection: self.$selected, label: Text("Ordenamento")) {
                    ForEach(0 ..< self.options.count) {
                        Text(self.options[$0]).tag($0)
                    }
                }.labelsHidden()
                    .frame(height: 200)
            }
            
        }
    }
}

struct SortPicker_Previews: PreviewProvider {
    static var previews: some View {
        SortPicker(selected: .constant(0))
    }
}
