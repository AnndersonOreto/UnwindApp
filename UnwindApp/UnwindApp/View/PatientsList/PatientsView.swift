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
    case feelingBorder
    case feelingText
    case pickerBackground
    case shadow
    case veryHappy, happy, neutral, sad, verySad, other
    
    var color: Color {
        switch self {
        case .background: return Color(red: 248/255, green: 250/255, blue: 255/255)
        case .feelingBorder: return Color(red: 214/255, green: 222/255, blue: 232/255)
        case .feelingText: return Color(red: 53/255, green: 208/255, blue: 148/255)
        case .pickerBackground: return Color(red: 250/255, green: 251/255, blue: 250/255)
        case .shadow: return Color(red: 15/255, green: 36/255, blue: 83/255, opacity: 0.05)
        case .veryHappy: return Color(red: 232/255, green: 135/255, blue: 175/255)
        case .happy: return Color(red: 249/255, green: 199/255, blue: 85/255)
        case .neutral: return Color(red: 171/255, green: 140/255, blue: 221/255)
        case .sad: return Color(red: 103/255, green: 198/255, blue: 198/255)
        case .verySad: return Color(red: 139/255, green: 200/255, blue: 234/255)
        case .other: return Color(red: 186/255, green: 189/255, blue: 211/255)
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
                    .shadow(color: CustomColor.shadow.color, radius: 10, x: 0, y: 2)
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
