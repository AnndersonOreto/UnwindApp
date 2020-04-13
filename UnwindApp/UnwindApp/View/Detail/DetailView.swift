//
//  DetailView.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 08/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI
import MessageUI

struct DetailView: View {
    
    @ObservedObject var viewModel = DetailViewModel()
    @State var showDatePicker: Bool = false
    @State var selectedDate: Date = Date()
    @State var showMailView: Bool = false
    @State var mailResult: Result<MFMailComposeResult, Error>? = nil
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                ScrollView(.vertical, showsIndicators: false) {
                    HStack(alignment: .center) {
                        Group {
                            Text("\(viewModel.userName), confira")
                            Text("suas emoções")
                                .fontWeight(.bold)
                        }.font(.largeTitle)
                        Spacer()
                        Button(action: { self.showMailView.toggle() } ) {
                            Text("Enviar relatório")
                                .fontWeight(.bold)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(Color.blue, lineWidth: 2)
                            )
                        }.disabled(!MFMailComposeViewController.canSendMail())
                            .sheet(isPresented: $showMailView) {
                                MailView(result: self.$mailResult)
                        }
                    }.padding([.top,.horizontal])
                    VStack(alignment: .center, spacing: 15) {
                        HStack(alignment: .center, spacing: 15) {
                            HStack(alignment: .center) {
                                VStack(alignment: .leading) {
                                    Text("Data e Hora:")
                                        .foregroundColor(.secondary)
                                    Text("\(viewModel.date) às \(viewModel.hour)")
                                        .foregroundColor(.primary)
                                        .fontWeight(.semibold)
                                }
                                Spacer()
                                Button(action: { self.showDatePicker.toggle() }) {
                                    Image(systemName: "pencil")
                                        .colorMultiply(.secondary)
                                }
                            }.frame(height: height*0.14)
                            .asCard()
                            
                            HStack(alignment: .center) {
                                Text("Como estava \nse sentindo?")
                                    .foregroundColor(.primary)
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                                ImageAndTextWithBorder(imageName: viewModel.feeling.imageName, text: viewModel.feeling.description)
                                Spacer()
                                NavigationLink(destination: FeelingsView()){
                                    Image(systemName: "pencil")
                                        .colorMultiply(.secondary)
                                }
                            }.frame(width: width*0.52, height: height*0.14)
                            .asCard()
                            
                        }
                        HStack(alignment: .center) {
                            Text("Qual foi \nsua emoção?")
                                .foregroundColor(.primary)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                            Spacer()
                            ForEach(0 ..< viewModel.numberOfEmotions) { (index) in
                                ImageAndTextWithBorder(imageName: self.viewModel.emotions[index].imageName, text: self.viewModel.emotions[index].name)
                            }
                            Spacer()
                            NavigationLink(destination: EmotionView()){
                                Image(systemName: "pencil")
                                    .colorMultiply(.secondary)
                            }
                        }.asCard()
                        HStack {
                            TitleAndText(title: "Qual foi a situação?", text: viewModel.situation)
                            Spacer()
                            NavigationLink(destination: DescribeView()){
                                Image(systemName: "pencil")
                                    .colorMultiply(.secondary)
                            }
                        }.asCard()
                        HStack {
                            TitleAndText(title: "Qual foi seu pensamento?", text: viewModel.thought)
                            Spacer()
                            NavigationLink(destination: DescribeView()){
                                Image(systemName: "pencil")
                                    .colorMultiply(.secondary)
                            }
                        }.asCard()
                        HStack {
                            TitleAndText(title: "Qual foi sua ação?", text: viewModel.action)
                            Spacer()
                            NavigationLink(destination: DescribeView()){
                                Image(systemName: "pencil")
                                    .colorMultiply(.secondary)
                            }
                        }.asCard()
                    }.padding()
                }.background(CustomColor.background.color)
                if showDatePicker {
                    DateAndHourPicker(selected: $selectedDate)
                        .onDisappear { print(self.selectedDate) }
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}

extension View {
    func asCard() -> some View {
        padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: CustomColor.shadow.color, radius: 10, x: 0, y: 2)
    }
}
