//
//  EmotionScreen.swift
//  UnwindApp
//
//  Created by Marcus Vinicius Vieira Badiale on 07/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

class EmotionViewModel: ObservableObject {
    
    @EnvironmentObject var authStatus: AuthenticationManager
    @Published var selected = ""
    @Published var emotionsToSend: [Emotion] = []
    @State var currentPage: CGFloat = 2
    
    @Published var array: [[Emotion]] = []
    
    let happyArray: [[Emotion]] = [
    [Emotion(name: "Ansioso"), Emotion(name: "Alegre"), Emotion(name: "Amoroso"), Emotion(name: "Feliz")],
    [Emotion(name: "Otimista"), Emotion(name: "Calmo"), Emotion(name: "Leve"), Emotion(name: "Especial")],
    [Emotion(name: "Orgulhoso"), Emotion(name: "Excitado"), Emotion(name: "Constrangido")],
    ]
    
    let neutralArray: [[Emotion]] = [
        [Emotion(name: "Medo"), Emotion(name: "Ansioso"), Emotion(name: "Calmo"), Emotion(name: "Envergonhado")],
        [Emotion(name: "Indiferente"), Emotion(name: "Constrangido"), Emotion(name: "Inseguro"), Emotion(name: "Aborrecido")],
        [Emotion(name: "Assustado"), Emotion(name: "Frustado")],
    ]
    
    let sadArray: [[Emotion]] = [
        [Emotion(name: "Medo"), Emotion(name: "Triste"), Emotion(name: "Ansioso"), Emotion(name: "Raiva")],
        [Emotion(name: "Envergonhado"), Emotion(name: "Constrangido"), Emotion(name: "Inseguro"), Emotion(name: "Assustado")],
        [Emotion(name: "Frustado"), Emotion(name: "Deprimido"), Emotion(name: "Irritado"), Emotion(name: "Magoado")],
        [Emotion(name: "Culpado"), Emotion(name: "Humilhado")],
    ]
    
    func sendButtonText() -> String {
        
        //IF IS EDITING RETURN "SALVAR"
        
        return "Proximo"
    }
    
    func saveEmotions() {
        //==============================
        //INSERT CODE TO SAVE EMOTIONS
        //==============================
        
        //USE emotionsToSend
        let  emotions = emotionsToSend.map( { $0.name } )
        
        FeelingsInfo.sharedInstance.user_emotions = emotions
        
        //authStatus.setUserEmotions(user_emotions: emotions)
    }
    
    func setArray(feeling: Feeling) {
        
        switch feeling.description {
        case "Muito Feliz", "Feliz":
            array = happyArray
        case "Neutro":
            array = neutralArray
        case "Muito Triste", "Triste":
            array = sadArray
        default:
            array = happyArray
        }
    }
}

struct EmotionView: View {
    
    @ObservedObject var viewModel = EmotionViewModel()
    @State var teste: Bool = false
    @State var selectedRows = Set<UUID>()
    @State var feeling: Feeling
    
    var body: some View {
        
        VStack{
            NavigationLink("", destination: DescribeView(state: .situation), isActive: $teste)
            Spacer()
            VStack(spacing: 77){
                Text("Qual foi sua emoção neste momento?")
                .font(.system(size: 40))
                .foregroundColor(Color.fontColorBlack)
                
                VStack(spacing:15){
                    ForEach(viewModel.array, id: \.self) { row in
                        HStack(spacing:15){
                            ForEach(row, id: \.self) { emotion in
                                EmotionButtonView(emotion: emotion, viewModel: self.viewModel, selectedItems: self.$selectedRows)
                            }
                        }
                    }
                }
            }
            Spacer()
            Button(action: {
                for item in self.selectedRows {
                    for row in self.viewModel.array{
                        for emotion in row {
                            if emotion.id == item {
                                self.viewModel.emotionsToSend.append(emotion)
                            }
                        }
                    }
                }
                self.viewModel.saveEmotions()
                self.teste.toggle()
            }) {
                Text(viewModel.sendButtonText())
                .kerning(0.3)
                .font(.system(size: 30)).bold()
            }.buttonStyle(SendButtonStyle())
        }.navigationBarItems(trailing:
            ProgressBar(currentPage: self.viewModel.currentPage).padding(.trailing, UIScreen.main.bounds.width*0.1)
                .onAppear{
                    self.viewModel.setArray(feeling: self.feeling)
            }
        )
    }
}

struct EmotionScreen_Previews: PreviewProvider {
    static var previews: some View {
        EmotionView(feeling: Feeling(id: 0, imageName: "", description: "", color: .happy)).environmentObject(AuthenticationManager())
    }
}

struct EmotionButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
        .frame(width: UIScreen.main.bounds.width * 0.21, height: UIScreen.main.bounds.width * 0.19)
        .contentShape(RoundedRectangle(cornerRadius: 8))
    }
}

struct EmotionButtonView: View {
    
    var emotion: Emotion
    @ObservedObject var viewModel: EmotionViewModel
    @Binding var selectedItems: Set<UUID>
    
    var isSelected: Bool {
        selectedItems.contains(emotion.id)
    }
    
    var body: some View {
        Button(action: {
            
            if self.isSelected {
                self.selectedItems.remove(self.emotion.id)
            }else {
                self.selectedItems.insert(self.emotion.id)
            }
            
            
        }) {
            Text(self.emotion.name)
            .font(.system(size: 25))
            .fontWeight(.medium)
            .foregroundColor(Color.fontColorGreen)
        }
        .overlay(
            Group{
                if self.isSelected {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.strokeBlue, lineWidth: 5)
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.strokeGray, lineWidth: 2)
                }
            }
        )
        .buttonStyle(EmotionButtonStyle())
    }
}
