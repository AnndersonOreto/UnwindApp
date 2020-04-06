//
//  FeelingsScreen.swift
//  UnwindApp
//
//  Created by Marcus Vinicius Vieira Badiale on 06/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

struct FeelingsScreen: View {
    
    let array = ["Muito Feliz", "Feliz", "Neutro"]
    
    var body: some View {
        VStack(spacing: 50){
            VStack{
                Text("Julia, como você está se sentindo?")
                Image("default")
                Text("Muito Feliz")
                    .font(.system(size: 12))
            }
            VStack{
                SelectFeelings(array: array)
                SelectFeelings(array: array)
            }
        }
    }
}

struct FeelingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        FeelingsScreen()
    }
}

struct SelectFeelings: View {
    
    @State var array: [String]
    
    var body: some View {
        HStack(spacing: 10){
            ForEach(array, id: \.self) { teste in
                Button(action: {
                    print("apertou")
                }) {
                    VStack{
                        Image("default")
                            .resizable()
                            .frame(width: self.feelingSize(isWidth: true), height: self.feelingSize(isWidth: false))
                        Text(teste)
                    }.padding(.horizontal, 30)
                        .padding(.vertical, 20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(.systemGray3), lineWidth: 1)
                        )
                }.buttonStyle(PlainButtonStyle())
            }
        }
    }
    
    func feelingSize(isWidth: Bool) -> CGFloat{
        
        var size: CGFloat
        
        if isWidth{
            size = UIScreen.main.bounds.width / 5
        } else {
            size = UIScreen.main.bounds.width / 6
        }
        return size
    }
}
