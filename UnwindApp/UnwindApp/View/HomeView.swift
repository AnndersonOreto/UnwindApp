//
//  HomeView.swift
//  UnwindApp
//
//  Created by Annderson Packeiser Oreto on 08/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var authStatus: AuthenticationManager
    
    var body: some View {
        
        HStack {
            
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            
            Button(action: {
                
                self.authStatus.logout()
            }) {
                
                Text("Log Out")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(AuthenticationManager())
    }
}
