//
//  UserHistoryView.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 15/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

struct UserHistoryView: View {
    
    @EnvironmentObject var authStatus: AuthenticationManager
    @ObservedObject var viewModel = HistoryViewModel()
    @State var showPicker: Bool = false
    @State var sortSelected: SortOptions = .alphabetically
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    ListTitle(regularText: "Boa tarde, ", boldText: self.authStatus.profile?.name ?? "")
                        .padding(.top, geometry.size.height*0.06)
                        .padding(.leading)
                    Spacer().frame(minHeight: 0, maxHeight: 20)
                    List {
                        Section(header: HeaderView(showPicker: self.$showPicker, selected: self.$sortSelected)) {
                            ForEach(self.viewModel.feelings) { feeling in
                                NavigationLink(destination: CustomDetailView(feeling: feeling)) {
                                    ListRow(imageName: feeling.image, text1: feeling.user_feeling, text2: feeling.date)
                                }
                            }
                        }
                    }.listStyle(GroupedListStyle())
                }.padding(.horizontal, geometry.size.width*0.025)
                if self.showPicker {
                    SortPicker(selected: self.$sortSelected)
                        .onDisappear {
                            self.viewModel.sortList(by: self.sortSelected)
                    }
                }
            }
        }.background(BackgroundWithShape())
        .navigationBarHidden(true)
        .navigationBarTitle("")
        .onAppear {
            UITableView.appearance().backgroundColor = .clear
        }
        .onReceive(self.authStatus.profile!.$feelings) { (feelings) in
            self.viewModel.setFeelings(feelings.user_array)
        }
        
    }
}

struct UserHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        UserHistoryView()
    }
}
