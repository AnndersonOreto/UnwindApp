//
//  PatientList.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 22/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

struct PatientListView: View {
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
                    ListTitle(regularText: "", boldText: self.viewModel.doctorName)
                        .padding(.top, geometry.size.height*0.09)
                        .padding(.leading)
                    Spacer().frame(minHeight: 0, maxHeight: 10)
                    Group {
                        List {
                            Section(header: HeaderView(showPicker: self.$showPicker)) {
                                ForEach(self.viewModel.patients) { patient in
                                    NavigationLink(destination: UserHistoryView()) {
                                        ListRow(imageName: patient.imageName, text1: patient.name, text2: "\(patient.phoneNumber) | \(patient.email)")
                                    }
                                }
                            }
                        }.listStyle(GroupedListStyle())
                            .environment(\.horizontalSizeClass, .compact)
                    }
                    .padding(.horizontal)
                    
                }
                if self.showPicker {
                    SortPicker(selected: self.$sortSelected)
                        .onDisappear {
                            self.viewModel.sortList(by: self.sortSelected)
                    }
                }
            }
        }.background(BackgroundWithShape())
    }
}

struct HeaderView: View {
    @Binding var showPicker: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                SortButton(showPicker: $showPicker)
                Spacer()
            }
            Divider()
        }.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .background(Color.white)
    }
}

struct PatientListView_Previews: PreviewProvider {
    static var previews: some View {
        PatientListView()
        .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch) (2nd generation)"))
    }
}
