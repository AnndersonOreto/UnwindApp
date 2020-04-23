//
//  PatientList.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 22/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

struct PatientListView: View {
    @EnvironmentObject var authStatus: AuthenticationManager
    @ObservedObject var viewModel = PatientListViewModel()
    @State var showPicker: Bool = false
    @State var sortSelected: SortOptions = .alphabetically
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    ListTitle(regularText: "Boa tarde, ", boldText: self.authStatus.profile?.name ?? "")
                        .padding(.top, geometry.size.height*0.09)
                        .padding(.leading)
                    Spacer().frame(minHeight: 0, maxHeight: 10)
                    List {
                        Section(header: HeaderView(showPicker: self.$showPicker, selected: self.$sortSelected)) {
                            ForEach(self.viewModel.patients) { patient in
                                NavigationLink(destination: HistoryView()) {
                                    ListRow(imageName: patient.imageName, text1: patient.name, text2: "\(patient.phoneNumber) | \(patient.email)")
                                }
                            }
                        }
                    }.listStyle(GroupedListStyle())
                }
                if self.showPicker {
                    SortPicker(selected: self.$sortSelected)
                        .onDisappear {
                            self.viewModel.sortList(by: self.sortSelected)
                    }
                }
            }
        }.background(BackgroundWithShape())
            .onAppear {
                self.authStatus.profile?.patients
        }
    }
}

struct PatientListView_Previews: PreviewProvider {
    static var previews: some View {
        PatientListView()
        .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch) (2nd generation)"))
    }
}
