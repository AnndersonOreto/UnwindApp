//
//  PatientsView.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 06/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

enum PatientsViewColor {
    case background
    case shadow
    
    var color: Color {
        switch self {
        case .background: return Color(red: 248/255, green: 250/255, blue: 255/255)
        case .shadow: return Color(red: 15/255, green: 36/255, blue: 83/255, opacity: 0.05)
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
                    .shadow(color: PatientsViewColor.shadow.color, radius: 10, x: 0, y: 2)
                }.onTapGesture { if self.showPicker { self.showPicker.toggle() } }
                if self.showPicker {
                    SortPicker(selected: self.$sortSelected)
                        .onDisappear {
                            self.viewModel.sortPatients(by: self.sortSelected)
                    }
                }
            }
        }.background(PatientsViewColor.background.color)
    }
}

struct PatientsView_Previews: PreviewProvider {
    static var previews: some View {
        PatientsView()
    }
}
