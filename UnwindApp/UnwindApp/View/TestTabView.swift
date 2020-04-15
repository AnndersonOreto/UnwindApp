//
//  TabView.swift
//  UnwindApp
//
//  Created by Marcus Vinicius Vieira Badiale on 15/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

struct TestTabView: View {
    var body: some View {
        TabView {
            DescribeView().tabItem({
                VStack{
                    Image(systemName: "heart")
                    .font(.largeTitle)
                    Text("Emoção")
                        .font(.largeTitle)
                }
                }).tag(0)
            
            FeelingsView().tabItem({
                VStack{
                    Image(systemName: "calendar")
                    .font(.largeTitle)
                    Text("Histórico")
                    .font(.largeTitle)
                }
            }).tag(0)
            
            FeelingsView().tabItem({
                VStack{
                    Image(systemName: "person")
                    .font(.largeTitle)
                    Text("Perfil")
                    .font(.largeTitle)
                }
            }).tag(0)
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TestTabView()
    }
}
