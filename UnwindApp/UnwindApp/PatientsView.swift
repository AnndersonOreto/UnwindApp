//
//  PatientsView.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 06/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

struct PatientsView: View {
    @EnvironmentObject var viewModel: PatientsViewModel
    @State var showPicker: Bool = false
    @State var selectedSort: Int = 0
    
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
                            Divider()
                            List(self.viewModel.patients, id: \.id) { (patient) in
                                PatientRow(name: patient.name, phoneNumber: patient.phoneNumber, email: patient.email)
                            }
                        }
                    }.frame(width: geometry.size.width*0.9)
                    .background(Color.white)
                }
                if self.showPicker {
                    SortPicker(selected: self.$selectedSort)
                }
            }
        }.background(Color(.sRGB, red: 248/256, green: 250/256, blue: 255/256, opacity: 1))
    }
}

struct PatientsView_Previews: PreviewProvider {
    static var previews: some View {
        PatientsView()
    }
}
