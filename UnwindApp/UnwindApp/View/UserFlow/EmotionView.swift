//
//  EmotionScreen.swift
//  UnwindApp
//
//  Created by Marcus Vinicius Vieira Badiale on 07/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

class EmotionViewModel: ObservableObject {
    
    @Published var selected = ""
    @Published var emotionsToSend: [Emotion] = []
    
    let array: [[Emotion]] = [
        [Emotion(name: "emocao1"), Emotion(name: "emocao2"), Emotion(name: "emocao3"), Emotion(name: "emocao4")],
        [Emotion(name: "emocao5"), Emotion(name: "emocao6"), Emotion(name: "emocao7"), Emotion(name: "emocao8")],
        [Emotion(name: "emocao9"), Emotion(name: "emocao10"), Emotion(name: "emocao11"), Emotion(name: "emocao12")],
        [Emotion(name: "emocao13"), Emotion(name: "emocao14"), Emotion(name: "emocao15"), Emotion(name: "emocao16")]
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
    }
    
}

struct EmotionView: View {
    
    @ObservedObject var viewModel = EmotionViewModel()
    
    @State var selectedRows = Set<UUID>()
    
    var body: some View {
        
        VStack{
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
                                print(emotion.name)
                                self.viewModel.emotionsToSend.append(emotion)
                            }
                        }
                    }
                }
                self.viewModel.saveEmotions()
            }) {
                Text(viewModel.sendButtonText())
                .kerning(0.3)
                .font(.system(size: 30)).bold()
            }.buttonStyle(SendButtonStyle())
        }
    }
}

struct EmotionScreen_Previews: PreviewProvider {
    static var previews: some View {
        EmotionView()
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
