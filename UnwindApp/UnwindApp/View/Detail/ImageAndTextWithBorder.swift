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
    let height = UIScreen.main.bounds.height
    
    var body: some View {
        VStack(alignment: .center) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(text)
                .foregroundColor(DetailViewColor.feelingText.color)
                .font(.system(size: 18))
                .fontWeight(.semibold)
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 20)
        .overlay (
            RoundedRectangle(cornerRadius: 10)
                .stroke(DetailViewColor.feelingBorder.color, lineWidth: 1)
        )
        .frame(width: width*0.2, height: height*0.14)
    }
}

struct ImageAndTextWithBorder_Previews: PreviewProvider {
    static var previews: some View {
        ImageAndTextWithBorder(imageName: "image", text: "Muito Feliz")
    }
}
