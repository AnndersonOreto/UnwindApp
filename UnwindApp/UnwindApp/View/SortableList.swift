//
//  SortableList.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 15/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

struct SortableList<T: ViewModelProtocol>: View {
    @ObservedObject var viewModel: T
    @State var showPicker: Bool = false
    @State var sortSelected: SortOptions = .alphabetically
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    ListTitle(regularText: self.viewModel.regularTitle, boldText: self.viewModel.boldTitle)
                    Spacer().frame(minHeight: 0, maxHeight: 10)
                    Group {
                        VStack(alignment: .leading) {
                            SortButton(showPicker: self.$showPicker)
                            Divider()
                            List(0 ..< self.viewModel.content.count) { (index) in
                                ListRow(text1: self.viewModel.rowTitle[index], text2: self.viewModel.rowSubtitle[index])
                            }.padding(.horizontal)
                        }
                    }.frame(width: geometry.size.width*0.9)
                    .customListStyle()
                }.onTapGesture { if self.showPicker { self.showPicker.toggle() } }
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

struct SortableList_Previews: PreviewProvider {
    static var previews: some View {
        SortableList(viewModel: PatientsViewModel())
    }
}
