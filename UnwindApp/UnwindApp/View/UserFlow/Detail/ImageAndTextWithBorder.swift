//
//  ImageAndTextWithBorder.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 08/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

struct ImageAndTextWithBorder: View {
    
    @State var imageName: String
    @State var text: String
    
    let width = UIScreen.main.bounds.width
    
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            VStack(alignment: .center) {
                Spacer()
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text(text)
                    .foregroundColor(CustomColor.feelingText.color)
                    .font(.headline)
                Spacer()
            }
            Spacer()
        }
        .overlay (
            RoundedRectangle(cornerRadius: 10)
                .stroke(CustomColor.feelingBorder.color, lineWidth: 1)
        )
        .frame(width: width*0.15, height: width*0.14)
    }
}

struct EmotionTextWithBorder: View {
    
    @State var text: String
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            HStack {
                Spacer()
                Text(text)
                .foregroundColor(CustomColor.feelingText.color)
                .font(.headline)
                Spacer()
            }
            Spacer()
        }
        .overlay (
            RoundedRectangle(cornerRadius: 10)
                .stroke(CustomColor.feelingBorder.color, lineWidth: 1)
        )
        .frame(width: width*0.15, height: width*0.14)
    }
}

struct ImageAndTextWithBorder_Previews: PreviewProvider {
    static var previews: some View {
        ImageAndTextWithBorder(imageName: "image", text: "Muito Feliz")
    }
}
