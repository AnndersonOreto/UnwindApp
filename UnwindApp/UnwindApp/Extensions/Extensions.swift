//
//  ViewExtensions.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 14/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

extension View {
    // Style for DetailView cells
    func asCard() -> some View {
        padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: CustomColor.shadow.color, radius: 10, x: 0, y: 2)
    }
}

extension UINavigationController {
    open override func viewDidLoad() {
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithTransparentBackground()
        
        let scrollAppearance = UINavigationBarAppearance()
        scrollAppearance.configureWithTransparentBackground()
        
        navigationBar.standardAppearance = standardAppearance
        navigationBar.scrollEdgeAppearance = scrollAppearance
        navigationBar.tintColor = .white
    }
}
