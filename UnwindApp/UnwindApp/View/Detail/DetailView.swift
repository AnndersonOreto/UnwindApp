//
//  DetailView.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 08/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            HStack(alignment: .center) {
                Group {
                    Text("Julia, confira")
                    Text("suas emoções")
                        .fontWeight(.bold)
                }.font(.largeTitle)
                Spacer()
                Button(action: edit) {
                    Text("Enviar relatório")
                        .fontWeight(.bold)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(Color.blue, lineWidth: 2)
                    )
                }
            }.padding([.top,.horizontal])
            VStack(alignment: .center, spacing: 15) {
                HStack(alignment: .center, spacing: 15) {
                    HStack(alignment: .center) {
                        VStack(alignment: .leading) {
                            Text("Data e Hora:")
                                .foregroundColor(.secondary)
                            Text("Hoje às 15:25")
                                .foregroundColor(.primary)
                                .fontWeight(.semibold)
                        }
                        Spacer()
                        Button(action: edit) {
                            Image(systemName: "pencil")
                                .colorMultiply(.secondary)
                        }
                    }.padding()
                    .frame(height: 205)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    HStack(alignment: .center) {
                        Text("Como estava \nse sentindo?")
                            .foregroundColor(.primary)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                        Spacer()
                        ImageAndTextWithBorder(imageName: "image", text: "Muito Feliz")
                        Spacer()
                        Button(action: { self.edit() }) {
                            Image(systemName: "pencil")
                                .colorMultiply(.secondary)
                        }
                    }.padding()
                    .frame(height: 205)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                }
                HStack(alignment: .center) {
                    Text("Qual foi \nsua emoção?")
                        .foregroundColor(.primary)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    ImageAndTextWithBorder(imageName: "image", text: "Alegre")
                    ImageAndTextWithBorder(imageName: "image", text: "Amoroso")
                    ImageAndTextWithBorder(imageName: "image", text: "Feliz")
                    Spacer()
                    Button(action: { self.edit() }) {
                        Image(systemName: "pencil")
                            .colorMultiply(.secondary)
                    }
                }.padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment: .leading) {
                    Text("Qual foi a situação?")
                    .foregroundColor(.primary)
                    .fontWeight(.semibold)
                    Text("It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using ‘Content here, content here’, making it look like.")
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                }.padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                VStack(alignment: .leading) {
                    Text("Qual foi seu pensamento?")
                    .foregroundColor(.primary)
                    .fontWeight(.semibold)
                    Text("It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using ‘Content here, content here’, making it look like.")
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }.padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                VStack(alignment: .leading) {
                    Text("Qual foi sua ação?")
                    .foregroundColor(.primary)
                    .fontWeight(.semibold)
                    Text("It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using ‘Content here, content here’, making it look like.")
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                }.padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }.padding()
        }.background(Color(red: 248/256, green: 250/256, blue: 255/256))
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}

extension DetailView {
    func edit() {
        print(self.width)
        print(self.height)
    }
}
