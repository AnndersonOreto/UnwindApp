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
                FeelingsView()
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
