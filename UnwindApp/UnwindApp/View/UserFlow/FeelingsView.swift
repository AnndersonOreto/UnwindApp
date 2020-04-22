//
//  FeelingsScreen.swift
//  UnwindApp
//
//  Created by Marcus Vinicius Vieira Badiale on 06/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

extension Color {
    static let lightGreen = Color(red: 245 / 255, green: 255 / 255, blue: 246 / 255)
    static let strokeGreen = Color(red: 132 / 255, green: 219 / 255, blue: 49 / 255)
    static let strokeGray = Color(red: 217/255, green: 219/255, blue: 226/255)
    static let fontColorGreen = Color(red: 72/255, green: 78/255, blue: 95/255)
    static let selectFeelingFontColor = Color(red: 53/255, green: 208/255, blue: 148/255)
    static let fontColorBlack = Color(red: 37/255, green: 46/255, blue: 72/255)
    static let sendButtonColor = Color(red: 52/255, green: 126/255, blue: 227/255)
    static let strokeBlue = Color(red: 52/255, green: 126/255, blue: 227/255)
    static let disabledTextColor = Color(red: 72/255, green: 78/255, blue: 95/255)
}

class FeelingsViewModel: ObservableObject {
    
    @EnvironmentObject var authStatus: AuthenticationManager
    @State var currentPage: CGFloat = 1
    @Published var feeling: Feeling = Feeling(id: 0, imageName: "ic_muito_feliz", description: "Muito Feliz", color: .veryHappy)
    @Published var linkActivate = false
    
    let array: [[Feeling]] = [
        [Feeling(id: 0, imageName: "ic_muito_feliz", description: "Muito Feliz", color: .veryHappy), Feeling(id: 1, imageName: "ic_feliz", description: "Feliz", color: .happy), Feeling(id: 2, imageName: "ic_neutro", description: "Neutro", color: .neutral)],
        [Feeling(id: 3, imageName: "ic_triste", description: "Triste", color: .sad), Feeling(id: 4, imageName: "ic_muito_triste", description: "Muito Triste", color: .verySad), Feeling(id: 5, imageName: "ic_outro", description: "Outro", color: .other)],
        
    ]
    
    func changeFeeling(feeling: Feeling) {
        self.feeling = feeling
    }
    
    func getBigImage() -> String {
        return "\(feeling.imageName)_big"
    }
    
    func sendButtonText() -> String {
        
        //IF IS EDITING RETURN "SALVAR"
        
        return "Proximo"
    }
    
    func saveFeeling() {
        //==============================
        //INSERT CODE TO SAVE THE FEELING
        //==============================
        
        FeelingsInfo.sharedInstance.user_feeling = feeling.description
        FeelingsInfo.sharedInstance.image = getBigImage()
        //authStatus.setUserFeeling(user_feeling: feeling.description, feelingType: "user_feeling")
    }
    
}


struct FeelingsView: View {
    @EnvironmentObject var authStatus: AuthenticationManager
    @ObservedObject var viewModel = FeelingsViewModel()
    @State var teste: Bool = false
    
    var body: some View {

        VStack(){
            NavigationLink("", destination: EmotionView(feeling: viewModel.feeling), isActive: $teste)
            VStack(spacing: 50){
                VStack(spacing:15){
                    HStack{
                        Text("\(self.authStatus.profile?.name ?? ""), como você está se")
                        .font(.system(size: 40))
                        .foregroundColor(Color.fontColorBlack)
                        Text("sentindo?")
                        .font(.system(size: 40)).bold()
                        .foregroundColor(Color.fontColorBlack)
                    }
                    Image(viewModel.getBigImage())
                        .resizable()
                        .frame(width: getImageSize(), height: getImageSize())
                    Text(viewModel.feeling.description)
                        .font(.system(size: 30))
                        .fontWeight(.medium)
                        .foregroundColor(Color.selectFeelingFontColor)
                }
                VStack{
                    ForEach(viewModel.array, id: \.self) { row in
                        HStack(spacing: 10){
                            ForEach(row, id: \.self) { feeling in
                                ButtonFeeling(feeling: feeling, viewModel: self.viewModel)
                            }
                        }
                    }
                }
            }
            Spacer()
            Button(action: {
                self.viewModel.saveFeeling()
                self.teste.toggle()
            }) {
                Text(self.viewModel.sendButtonText())
                .kerning(0.3)
                .font(.system(size: 30)).bold()
            }.buttonStyle(SendButtonStyle())
        }.navigationBarItems(trailing:
            ProgressBar(currentPage: self.viewModel.currentPage).padding(.trailing, UIScreen.main.bounds.width*0.1)
        )
    }
    
    func getImageSize() -> CGFloat {
        var size: CGFloat

        size = UIScreen.main.bounds.width * 0.31

        return size
    }
}

struct FeelingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        FeelingsView().environmentObject(AuthenticationManager())
    }
}

struct FeelingButtonStyle: ButtonStyle {
    
    var feeling: Feeling
    var isSelected: Bool
    
    var opacity: Double {
        return isSelected ? 1 : 0.5
    }
    
    var foregroundColor: Color {
        return isSelected ? Color.white : Color.fontColorGreen
    }
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
        .frame(width: UIScreen.main.bounds.width * 0.29, height: UIScreen.main.bounds.width * 0.24)
        .background(feeling.color.color.opacity(opacity))
        .cornerRadius(8)
        .contentShape(RoundedRectangle(cornerRadius: 8))
        .foregroundColor(foregroundColor)
    }
}

struct ButtonFeeling: View {
    
    @State var feeling: Feeling
    @ObservedObject var viewModel: FeelingsViewModel
    
    var isSelected: Bool {
        feeling.id == viewModel.feeling.id
    }
    
    var body: some View {
        Button(action: {
            self.viewModel.changeFeeling(feeling: self.feeling)
        }) {
            VStack{
                Image(feeling.imageName)
                    .resizable()
                    .frame(width: self.feelingSize(isWidth: true), height: self.feelingSize(isWidth: false))
                Text(feeling.description)
                    .font(.system(size: 25))
                    .fontWeight(.regular)
            }
        }
        .overlay(
            Group{
                if self.viewModel.feeling.id == feeling.id {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.strokeBlue, lineWidth: 5)
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.strokeGray, lineWidth: 0)
                }
            }
        )
            .buttonStyle(FeelingButtonStyle(feeling: feeling, isSelected: isSelected))
    }
    
    func feelingSize(isWidth: Bool) -> CGFloat{
        
        var size: CGFloat
        
        if isWidth{
            size = UIScreen.main.bounds.width * 0.125
        } else {
            size = UIScreen.main.bounds.width * 0.11
        }
        return size
    }
}
