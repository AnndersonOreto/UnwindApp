//
//  CustomDetailView.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 22/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI
import MessageUI

struct CustomDetailView: View {
    @EnvironmentObject var authStatus: AuthenticationManager
    @ObservedObject var viewModel = DetailViewModel()
    @State var showDatePicker: Bool = false
    @State var selectedDate: Date = Date()
    @State var showMailView: Bool = false
    @State var mailResult: Result<MFMailComposeResult, Error>? = nil
    var index: Int
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    init(index: Int) {
        self.index = index
    }
    
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
                                    Text("\(self.authStatus.profile?.feelings?.user_array[self.index].date ?? "")")
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
                                ImageAndTextWithBorder(imageName: self.authStatus.profile?.feelings?.user_array[self.index].image ?? "", text: self.authStatus.profile?.feelings?.user_array[self.index].user_feeling ?? "")
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
                            ForEach(0 ..< getEmotionsCount()) { (index) in
                                EmotionTextWithBorder(text: "\(self.authStatus.profile?.feelings?.user_array[self.index].user_emotions.split(separator: ",")[index] ?? "erro")")
                            }
                            Spacer()
                            NavigationLink(destination: EmotionView(feeling: self.viewModel.feeling)){
                                Image(systemName: "pencil")
                                    .colorMultiply(.secondary)
                            }
                        }.asCard()
                        HStack {
                            TitleAndText(title: "Qual foi a situação?", text: self.authStatus.profile?.feelings?.user_array[self.index].user_situation ?? "")
                            Spacer()
                            NavigationLink(destination: DescribeView(state: .situation)) {
                                Image(systemName: "pencil")
                                    .colorMultiply(.secondary)
                            }
                        }.asCard()
                        HStack {
                            TitleAndText(title: "Qual foi seu pensamento?", text: self.authStatus.profile?.feelings?.user_array[self.index].user_thoughts ?? "")
                            Spacer()
                            NavigationLink(destination: DescribeView(state: .thoughts)){
                                Image(systemName: "pencil")
                                    .colorMultiply(.secondary)
                            }
                        }.asCard()
                        HStack {
                            TitleAndText(title: "Qual foi sua ação?", text: self.authStatus.profile?.feelings?.user_array[self.index].user_action ?? "")
                            Spacer()
                            NavigationLink(destination: DescribeView(state: .action)){
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
    }
}

extension CustomDetailView {
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
    
    func getEmotionsCount() -> Int {
        
        let val = self.authStatus.profile?.feelings?.user_array[self.index].user_emotions.split(separator: ",").count ?? 0
        
        if val > 3 {
            return 3
        } else {
            return val
        }
    }
}

struct CustomDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CustomDetailView(index: 0)
    }
}
