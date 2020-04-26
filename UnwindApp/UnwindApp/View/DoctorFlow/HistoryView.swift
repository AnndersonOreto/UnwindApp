//
//  HistoryView.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 22/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

struct HistoryView: View {
    
    @EnvironmentObject var authStatus: AuthenticationManager
    @ObservedObject var viewModel = HistoryViewModel()
    @State var showPicker: Bool = false
    @State var sortSelected: SortOptions = .alphabetically
    @State var patient: Patient
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                List {
                    Section(header: HeaderView(showPicker: self.$showPicker, selected: self.$sortSelected)) {
                        ForEach(self.viewModel.feelings) { feeling in
                            NavigationLink(destination: DoctorDetailView(feeling: feeling, patient: self.patient)) {
                                ListRow(imageName: feeling.image, text1: feeling.user_feeling, text2: feeling.date)
                            }
                        }
                    }
                }.listStyle(GroupedListStyle())
                    .padding(.horizontal, geometry.size.width*0.025)
                
                if self.showPicker {
                    SortPicker(selected: self.$sortSelected)
                        .onDisappear {
                            self.viewModel.sortList(by: self.sortSelected)
                    }
                }
            }
        }.background(BackgroundWithShape())
            .onAppear {
                UITableView.appearance().backgroundColor = .clear
                self.authStatus.getPacientFeelings(email: self.authStatus.replaceEmail(email: self.patient.email), completion: { feelingsArray in
                    self.viewModel.setFeelings(feelings: feelingsArray)
                })
        }
    }
}
