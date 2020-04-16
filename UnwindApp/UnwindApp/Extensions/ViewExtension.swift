//
//  ViewExtensions.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 14/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

extension View {
    
    // Style for the lists of the app
    func customListStyle() -> some View {
        background(Color.white)
            .cornerRadius(10)
            .shadow(color: CustomColor.shadow.color, radius: 10, x: 0, y: 2)
    }
    
    // Style for DetailView cells
    func asCard() -> some View {
        padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: CustomColor.shadow.color, radius: 10, x: 0, y: 2)
    }
}
