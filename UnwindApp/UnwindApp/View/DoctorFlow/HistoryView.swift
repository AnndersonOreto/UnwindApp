//
//  HistoryView.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 22/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var viewModel = HistoryViewModel()
    @State var showPicker: Bool = false
    @State var sortSelected: SortOptions = .alphabetically
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                List {
                    Section(header: HeaderView(showPicker: self.$showPicker, selected: self.$sortSelected)) {
                        ForEach(0 ..< self.viewModel.feelings.count) { index in
                            NavigationLink(destination: CustomDetailView(index: index)) {
                                ListRow(imageName: self.viewModel.feelings[index].image, text1: self.viewModel.feelings[index].user_feeling, text2: self.viewModel.feelings[index].date)
                            }
                        }
                    }
                }.listStyle(GroupedListStyle())
                    .padding(.top, geometry.size.height*0.1)
                if self.showPicker {
                    SortPicker(selected: self.$sortSelected)
                        .onDisappear {
                            self.viewModel.sortList(by: self.sortSelected)
                    }
                }
            }
        }.background(BackgroundWithShape())
        .edgesIgnoringSafeArea(.top)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
