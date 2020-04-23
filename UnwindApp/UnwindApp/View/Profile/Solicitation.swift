//
//  Solicitation.swift
//  UnwindApp
//
//  Created by Marcus Vinicius Vieira Badiale on 23/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

struct SolicitationView: View {
    @EnvironmentObject var authStatus: AuthenticationManager
    
    var body: some View {
        VStack {
            Text(self.authStatus.profile?.pending ?? "")
            if authStatus.profile?.pending != "" {
                Button(action: { self.authStatus.acceptPending() }, label: { Text("Aceitar") })
            } else {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

struct Solicitation_Previews: PreviewProvider {
    static var previews: some View {
        SolicitationView()
    }
}
