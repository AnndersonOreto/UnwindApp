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
    static let fontColorBlue = Color(red: 81/255, green: 154/255, blue: 255/255)
    static let fontColorBlack = Color(red: 37/255, green: 46/255, blue: 72/255)
    static let sendButtonColor = Color(red: 81/255, green: 154/255, blue: 255/255)
}

class FeelingsViewModel: ObservableObject {
    
    @Published var feelingName = ""
    @Published var feelingImageName = "default"
    @Published var selected = ""
    
    let array: [[String]] = [
        ["Muito Feliz", "Feliz", "Neutro"],
        ["Triste", "Muito Triste", "Outro"]
    ]
    
    func changeImage(imageName: String) {
        self.feelingImageName = imageName
    }
    
    func changeName(feelingName: String) {
        self.feelingName = feelingName
    }
}


struct FeelingsView: View {
    
    @ObservedObject var viewModel = FeelingsViewModel()
    @State var progress: CGFloat = 0.25
    
    var body: some View {
        NavigationView {
            VStack(spacing: 50){
                VStack{
                    HStack{
                       Text("Julia, como você está se")
                        .font(.system(size: 40))
                        .foregroundColor(Color.fontColorBlack)
                        Text("sentindo?")
                        .font(.system(size: 40)).bold()
                        .foregroundColor(Color.fontColorBlack)
                    }
                    Image(viewModel.feelingImageName)
                    Text(viewModel.feelingName)
                        .font(.system(size: 30))
                        .fontWeight(.medium)
                        .foregroundColor(Color.fontColorBlue)
                }
                VStack{
                    ForEach(viewModel.array, id: \.self) { row in
                        SelectFeelings(array: row, viewModel: self.viewModel)
                    }
                }
            }.navigationBarItems(leading:
                ProgressBar(currentProgress: self.$progress)
                    .offset(x: UIScreen.main.bounds.width/12)
            , trailing:
                NavigationLink(destination: DetailView(), label: {
                    Image(systemName: "xmark")
                        .imageScale(.large)
                        .colorMultiply(.secondary)
                })
            )
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct FeelingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FeelingsView().previewDevice(PreviewDevice(rawValue: "iPhone 11"))
            FeelingsView().previewDevice(PreviewDevice(rawValue: "iPad Pro (9.7-inch)"))
        }
    }
}

struct FeelingButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
        .frame(width: UIScreen.main.bounds.width * 0.29, height: UIScreen.main.bounds.width * 0.24)
        .contentShape(RoundedRectangle(cornerRadius: 8))
    }
}

struct SelectFeelings: View {
    
    @State var array: [String]
    @ObservedObject var viewModel: FeelingsViewModel
    
    var body: some View {
        HStack(spacing: 10){
            ForEach(array, id: \.self) { feeling in
                Button(action: {
                    self.viewModel.selected = feeling
                    self.viewModel.changeImage(imageName: "img_big")
                    self.viewModel.changeName(feelingName: feeling)
                }) {
                    VStack{
                        Image("img_")
                            .resizable()
                            .frame(width: self.feelingSize(isWidth: true), height: self.feelingSize(isWidth: false))
                        Text(feeling)
                            .font(.system(size: 25))
                            .fontWeight(.medium)
                            .foregroundColor(Color.fontColorBlue)
                    }
                }
                .background(
                    Group{
                        if self.viewModel.selected == feeling {
                            Color.lightGreen
                        }
                    }
                )
                .overlay(
                    Group{
                        if self.viewModel.selected == feeling {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.strokeGreen, lineWidth: 5)
                        } else {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.strokeGray, lineWidth: 2)
                        }
                    }
                )
                .buttonStyle(FeelingButtonStyle())
            }
        }
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
