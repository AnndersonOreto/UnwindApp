//
//  ProfilesStructs.swift
//  UnwindApp
//
//  Created by Marcus Vinicius Vieira Badiale on 23/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import Foundation
import SwiftUI

struct ProfileButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
        .padding(.horizontal, UIScreen.main.bounds.width * 0.029)
        .frame(height: UIScreen.main.bounds.width * 0.09)
        .contentShape(Rectangle())
    }
}

struct Divider: View {
    let color: Color = Color(red: 184/255, green: 188/255, blue: 201/255)
    let width: CGFloat = 1
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .padding(.horizontal, UIScreen.main.bounds.width * 0.029)
    }
}

struct BackgroundAlert<Content: View>: View {
    private var content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        Color.black.opacity(0.4)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .overlay(content)
    }
}

struct ProfilePickerButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(.horizontal, UIScreen.main.bounds.width * 0.039)
        .padding(.vertical, UIScreen.main.bounds.width * 0.021)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(red: 217/255, green: 219/255, blue: 226/255), lineWidth: 1.5)
        )
        .foregroundColor(Color(red: 184/255, green: 188/255, blue: 201/255))
    }
}
