//
//  BackgroundPath.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 13/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

struct BackgroundShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            var height = min(rect.size.height, UIScreen.main.bounds.height)
            let width = rect.size.width
            let yScale: CGFloat = 0.221
            height *= yScale
            let yOffset: CGFloat = height*0.15
            
            path.move(to: CGPoint(x: 0, y: height))
            path.addLine(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: width, y: 0))
            path.addLine(to: CGPoint(x: width, y: height))
            path.addQuadCurve(to: CGPoint(x: 0, y: height), control: CGPoint(x: width/2, y: height+yOffset))
            path.closeSubpath()
        }
    }
}

struct BackgroundWithShape: View {
    
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(CustomColor.background.color)
            BackgroundShape()
                .fill(Color.blue)
                .shadow(color: CustomColor.shadow.color, radius: 10)
        }.edgesIgnoringSafeArea(.all)
    }
}

struct BackPath_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundWithShape()
    }
}

struct SendReportStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
    }
}
