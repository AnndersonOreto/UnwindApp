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
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(.vertical, showsIndicators: false) {
                Group {
                    HStack(alignment: .center) {
                        Group {
                            Text("\(authStatus.profile?.name ?? ""), confira ")
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
                                    Text("\(FeelingsInfo.sharedInstance.date)")
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
                                ImageAndTextWithBorder(imageName: FeelingsInfo.sharedInstance.image, text: FeelingsInfo.sharedInstance.user_feeling)
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
                            ForEach(FeelingsInfo.sharedInstance.user_emotions, id: \.self) { emotion in
                                EmotionTextWithBorder(text: "\(emotion)")
                            }
                            Spacer()
                            NavigationLink(destination: EmotionView(feeling: self.viewModel.feeling)){
                                Image(systemName: "pencil")
                                    .colorMultiply(.secondary)
                            }
                        }.asCard()
                        HStack {
                            TitleAndText(title: "Qual foi a situação?", text: FeelingsInfo.sharedInstance.user_situation)
                            Spacer()
                            NavigationLink(destination: DescribeView(state: .situation)) {
                                Image(systemName: "pencil")
                                    .colorMultiply(.secondary)
                            }
                        }.asCard()
                        HStack {
                            TitleAndText(title: "Qual foi seu pensamento?", text: FeelingsInfo.sharedInstance.user_thoughts)
                            Spacer()
                            NavigationLink(destination: DescribeView(state: .thoughts)){
                                Image(systemName: "pencil")
                                    .colorMultiply(.secondary)
                            }
                        }.asCard()
                        HStack {
                            TitleAndText(title: "Qual foi sua ação?", text: FeelingsInfo.sharedInstance.user_action)
                            Spacer()
                            NavigationLink(destination: DescribeView(state: .action)){
                                Image(systemName: "pencil")
                                    .colorMultiply(.secondary)
                            }
                        }.asCard()
                    }.padding()
                }.background(BackgroundWithShape())
            }.background(Color.clear)
            if showDatePicker {
                DateAndHourPicker(selected: $selectedDate)
                    .onDisappear { print(self.selectedDate) }
            }
        }.navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button(action: {
                self.authStatus.selectedTab = 1
            }, label: {
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
