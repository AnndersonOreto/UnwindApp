//
//  DateAndHourPicker.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 09/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

struct DateAndHourPicker: View {
    
    @Binding var selected: Date
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(alignment: .firstTextBaseline) {
                Text("Data")
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity)
                Text("\(selected, formatter: dateFormatter)")
                    .foregroundColor(.blue)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
            }.padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .clipped()
            .shadow(radius: 10, x: 1, y: 0)
            DatePicker(selection: $selected, in: ...Date()) {
                Text("Data")
            }.labelsHidden()
            .frame(maxWidth: .infinity)
            .background(CustomColor.pickerBackground.color)
        }
    }
}

struct DateAndHourPicker_Previews: PreviewProvider {
    static var previews: some View {
        DateAndHourPicker(selected: .constant(Date()))
    }
}
