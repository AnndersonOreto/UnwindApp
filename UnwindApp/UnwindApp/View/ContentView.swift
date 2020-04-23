//
//  ContentView.swift
//  UnwindApp
//
//  Created by Annderson Packeiser Oreto on 02/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authStatus: AuthenticationManager
    
    func getUser() {
        
        authStatus.listen()
    }
    
    var body: some View {
        Group {
            
            if authStatus.profile != nil {
                
                if authStatus.profile?.role == "Paciente" {
                    TabView(selection: $authStatus.selectedTab) {
                        NavigationView {
                            FeelingsView()
                        }.navigationViewStyle(StackNavigationViewStyle())
                        .tabItem {
                            Image(systemName: "heart")
                            Text("Emoção")
                        }.tag(0)
                        
                        NavigationView {
                            UserHistoryView()
                        }.navigationViewStyle(StackNavigationViewStyle())
                        .tabItem {
                            Image(systemName: "calendar")
                            Text("Histórico")
                        }.tag(1)
                        
                        NavigationView{
                            PatientProfile()
                        }.navigationViewStyle(StackNavigationViewStyle())
                        .tabItem {
                            Image(systemName: "person")
                            Text("Perfil")
                        }.tag(2)
                    }
                } else {
                    TabView(selection: $authStatus.selectedTab) {
                        NavigationView {
                            PatientListView()
                        }.navigationViewStyle(StackNavigationViewStyle())
                        .tabItem {
                            Image(systemName: "calendar")
                            Text("Histórico")
                        }.tag(0)
                        
                        NavigationView{
                            DoctorProfile()
                        }.navigationViewStyle(StackNavigationViewStyle())
                        .tabItem {
                            Image(systemName: "person")
                            Text("Perfil")
                        }.tag(1)
                    }

                }
            } else {
                LoginView()
            }
        }.onAppear(perform: getUser)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AuthenticationManager())
    }
}
