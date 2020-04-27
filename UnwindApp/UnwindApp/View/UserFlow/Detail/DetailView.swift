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
    @ObservedObject var viewModel = DetailViewModel()   // -> NÃO ESTÁ SENDO UTILIZADA
    @State var showDatePicker: Bool = false
    @State var selectedDate: Date = Date()
    @State var showMailView: Bool = false
    @State var mailResult: Result<MFMailComposeResult, Error>? = nil
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(.vertical, showsIndicators: false) {
                
                HStack(alignment: .center) {
                    Group {
                        Text("\(authStatus.profile?.name ?? ""), confira ")
                        + Text("suas emoções")
                            .fontWeight(.bold)
                    }.font(.largeTitle)
                        .foregroundColor(.white)
                    Spacer()
                    reportButton
                }.padding(.top, height*0.04)
                    .padding(.horizontal)
                
                Spacer().frame(minHeight: 5, maxHeight: 30)
                
                VStack(alignment: .center, spacing: 15) {
                    HStack(alignment: .center, spacing: 15) {
                        HStack(alignment: .center) {
                            VStack(alignment: .leading) {
                                Text("Data e Hora:")
                                    .foregroundColor(.secondary)
                                    .font(.headline)
                                Text("\(FeelingsInfo.sharedInstance.date)")
                                    .foregroundColor(.primary)
                                    .font(.title)
                                    .fontWeight(.semibold)
                            }
                            Spacer()
                            Button(action: { self.showDatePicker.toggle() }) {
                                Image(systemName: "pencil")
                                    .colorMultiply(.secondary)
                                    .imageScale(.large)
                            }
                        }.frame(height: height*0.14)
                            .padding(.all, width*0.03)
                            .asCard()
                        
                        HStack(alignment: .center) {
                            Text("Como estava \nse sentindo?")
                                .foregroundColor(.primary)
                                .font(.title)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                            Spacer()
                            ImageAndTextWithBorder(imageName: FeelingsInfo.sharedInstance.image, text: FeelingsInfo.sharedInstance.user_feeling)
                            Spacer()
                            NavigationLink(destination: FeelingsView()){
                                Image(systemName: "pencil")
                                    .colorMultiply(.secondary)
                                    .imageScale(.large)
                            }
                        }.frame(width: width*0.48, height: height*0.14)
                            .padding(.all, width*0.03)
                            .asCard()
                    }
                    
                    HStack(alignment: .center) {
                        Text("Qual foi \nsua emoção?")
                            .foregroundColor(.primary)
                            .font(.title)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                        Spacer()
                        ForEach(0 ..< getEmotionsCount()) { index in
                            EmotionTextWithBorder(text: "\(FeelingsInfo.sharedInstance.user_emotions[index])")
                            Spacer()
                        }
                        Spacer()
                        NavigationLink(destination: EmotionView(feeling: self.viewModel.feeling)){
                            Image(systemName: "pencil")
                                .colorMultiply(.secondary)
                                .imageScale(.large)
                        }
                    }.padding(.all, width*0.03)
                        .asCard()
                    
                    HStack {
                        TitleAndText(title: "Qual foi a situação?", text: FeelingsInfo.sharedInstance.user_situation)
                        Spacer()
                        NavigationLink(destination: DescribeView(state: .situation)) {
                            Image(systemName: "pencil")
                                .colorMultiply(.secondary)
                                .imageScale(.large)
                        }
                    }.padding(.horizontal, width*0.03)
                        .padding(.vertical, height*0.03)
                        .asCard()
                    
                    HStack {
                        TitleAndText(title: "Qual foi seu pensamento?", text: FeelingsInfo.sharedInstance.user_thoughts)
                        Spacer()
                        NavigationLink(destination: DescribeView(state: .thoughts)){
                            Image(systemName: "pencil")
                                .colorMultiply(.secondary)
                                .imageScale(.large)
                        }
                    }.padding(.horizontal, width*0.03)
                        .padding(.vertical, height*0.03)
                        .asCard()
                    
                    HStack {
                        TitleAndText(title: "Qual foi sua ação?", text: FeelingsInfo.sharedInstance.user_action)
                        Spacer()
                        NavigationLink(destination: DescribeView(state: .action)){
                            Image(systemName: "pencil")
                                .colorMultiply(.secondary)
                                .imageScale(.large)
                        }
                    }.padding(.horizontal, width*0.03)
                        .padding(.vertical, height*0.03)
                        .asCard()
                    
                }.padding()
            }
            .padding(.horizontal, width*0.025)
            .background(BackgroundWithShape())
            
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
                    .imageScale(.large)
                    .font(.headline)
            })
        )
    }
}

extension DetailView {
    
    var reportButton: some View {
        Button(action: { self.showMailView.toggle() } ) {
            Text("Enviar relatório")
                .font(.system(size: 18))
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
    
    func getEmotionsCount() -> Int {
        let val = FeelingsInfo.sharedInstance.user_emotions.count
        
        if val > 3 {
            return 3
        } else {
            return val
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView().environmentObject(AuthenticationManager())
    }
}
