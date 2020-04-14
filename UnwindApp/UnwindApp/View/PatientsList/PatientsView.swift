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
    case progressBarBottom
    case progressBarTop
    case shadow
    
    var color: Color {
        switch self {
        case .background: return Color(red: 248/255, green: 250/255, blue: 255/255)
        case .feelingBorder: return Color(red: 214/255, green: 222/255, blue: 232/255)
        case .feelingText: return Color(red: 53/255, green: 208/255, blue: 148/255)
        case .pickerBackground: return Color(red: 250/255, green: 251/255, blue: 250/255)
        case .progressBarBottom: return Color(red: 237/255, green: 241/255, blue: 251/255)
        case .progressBarTop: return Color(red: 255/255, green: 212/255, blue: 33/255)
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
                    ListTitle(regularText: "Boa tarde, ", boldText: self.viewModel.doctorName)
                    Spacer().frame(minHeight: 0, maxHeight: 10)
                    Group {
                        VStack(alignment: .leading) {
                            SortButton(showPicker: self.$showPicker)
                            Divider()
                            List(self.viewModel.patients, id: \.id) { (patient) in
                                ListRow(text1: patient.name, text2: patient.phoneNumber)
                            }.padding(.horizontal)
                        }
                    }.frame(width: geometry.size.width*0.9)
                    .customListStyle()
                }.onTapGesture { if self.showPicker { self.showPicker.toggle() } }
                if self.showPicker {
                    SortPicker(selected: self.$sortSelected)
                        .onDisappear {
                            self.viewModel.sortPatients(by: self.sortSelected)
                    }
                }
            }
        }.background(BackgroundWithShape())
    }
}

struct PatientsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PatientsView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
                .previewDisplayName("iPhone 11")
            PatientsView()
                .previewDevice(PreviewDevice(rawValue: "iPad Pro (9.7-inch)"))
                .previewDisplayName("iPad Pro (9.7-inch)")
        }
        
    }
}
