//
//  PatientsView.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 06/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

enum CustomColor {
    case background
    case shadow
    
    var color: Color {
        switch self {
        case .background:
            return Color(.sRGB, red: 248/255, green: 250/255, blue: 255/255, opacity: 1)
        case .shadow:
            return Color(.sRGB, red: 15/255, green: 36/255, blue: 83/255, opacity: 0.1)
        }
    }
}

struct PatientsView: View {
    @ObservedObject var viewModel = PatientsViewModel()
    @State var showPicker: Bool = false
    @State var sortSelected: SortOptions = .alphabetically
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    HStack(alignment: .firstTextBaseline) {
                        Text("Boa tarde,")
                            .fontWeight(.regular)
                        Text(self.viewModel.doctorName)
                            .fontWeight(.bold)
                    }.font(.system(size: 40))
                    .lineLimit(1)
                    Group {
                        VStack(alignment: .leading) {
                            SortButton(showPicker: self.$showPicker)
                                .shadow(color: .gray, radius: 20, x: 0, y: 0)
                            Divider()
                            List(self.viewModel.patients, id: \.id) { (patient) in
                                PatientRow(name: patient.name, phoneNumber: patient.phoneNumber, email: patient.email)
                            }.padding(.horizontal)
                        }
                    }.frame(width: geometry.size.width*0.9)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: CustomColor.shadow.color, radius: 30, x: 0, y: 0)
                }.onTapGesture { if self.showPicker { self.showPicker.toggle() } }
                if self.showPicker {
                    SortPicker(selected: self.$sortSelected)
                        .onDisappear {
                            self.viewModel.sortPatients(by: self.sortSelected)
                    }
                }
            }
        }.background(CustomColor.background.color)
    }
}

struct PatientsView_Previews: PreviewProvider {
    static var previews: some View {
        PatientsView()
    }
}
