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
    
    @EnvironmentObject var authStatus: AuthenticationManager
    @ObservedObject var viewModel = DetailViewModel()
    @State var showDatePicker: Bool = false
    @State var selectedDate: Date = Date()
    @State var showMailView: Bool = false
    @State var mailResult: Result<MFMailComposeResult, Error>? = nil
    @State var teste: Bool = false
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(.vertical, showsIndicators: false) {
                Group {
                    HStack(alignment: .center) {
                        Group {
                            Text("\(viewModel.userName), confira ")
                            + Text("suas emoções")
                                .fontWeight(.bold)
                        }.font(.largeTitle)
                            .foregroundColor(.white)
                        Spacer()
                        reportButton
                    }.padding([.top,.horizontal])
                    Spacer().frame(minHeight: 0, maxHeight: 10)
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
                            NavigationLink(destination: EmotionView(feeling: Feeling(id: 0, imageName: "", description: "", color: .happy))){
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
                }.background(BackgroundWithShape())
            }
            .background(Color.clear)
            if showDatePicker {
                DateAndHourPicker(selected: $selectedDate)
                    .onDisappear { print(self.selectedDate) }
            }
        }.navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button(action: { self.authStatus.selectedTab = 1 }, label: {
                Image(systemName: "chevron.left")
                    .colorMultiply(.accentColor)
            })
        )
    }
}

extension DetailView {
    var reportButton: some View {
        Button(action: { self.showMailView.toggle() } ) {
            Text("Enviar relatório")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .overlay(
                RoundedRectangle(cornerRadius: 45)
                    .stroke(Color.white, lineWidth: 2)
            )
        }.disabled(!MFMailComposeViewController.canSendMail())
            .sheet(isPresented: self.$showMailView) {
                MailView(result: self.$mailResult)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView().environmentObject(AuthenticationManager())
    }
}
