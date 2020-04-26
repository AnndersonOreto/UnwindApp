//
//  DoctorDetailView.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 25/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

struct DoctorDetailView: View {
    
    @EnvironmentObject var authStatus: AuthenticationManager
    @ObservedObject var viewModel = DetailViewModel()
    @State var showDatePicker: Bool = false
    @State var selectedDate: Date = Date()
    @State var feeling: Feelings
    @State var patient: Patient
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(.vertical, showsIndicators: false) {
                
                HStack() {
                    Text("Confira as emoções de \(self.patient.name)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
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
                                Text("\(feeling.date )")
                                    .foregroundColor(.primary)
                                    .font(.title)
                                    .fontWeight(.semibold)
                            }
                            Spacer()
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
                            ImageAndTextWithBorder(imageName: self.feeling.image , text: self.feeling.user_feeling )
                            Spacer()
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
                        ForEach(0 ..< getEmotionsCount()) { (index) in
                            EmotionTextWithBorder(text: "\(self.feeling.user_emotions.split(separator: ",")[index] )")
                            Spacer()
                        }
                    }.padding(.all, width*0.03)
                        .asCard()
                    
                    HStack {
                        TitleAndText(title: "Qual foi a situação?", text: self.feeling.user_situation)
                        Spacer()
                    }.padding(.horizontal, width*0.03)
                        .padding(.vertical, height*0.03)
                        .asCard()
                    
                    HStack {
                        TitleAndText(title: "Qual foi seu pensamento?", text: self.feeling.user_thoughts)
                        Spacer()
                    }.padding(.horizontal, width*0.03)
                        .padding(.vertical, height*0.03)
                        .asCard()
                    
                    HStack {
                        TitleAndText(title: "Qual foi sua ação?", text: self.feeling.user_action)
                        Spacer()
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
    }
}

extension DoctorDetailView {
    
    func getEmotionsCount() -> Int {
        let val = self.feeling.user_emotions.split(separator: ",").count
        
        if val > 3 {
            return 3
        } else {
            return val
        }
    }
}
