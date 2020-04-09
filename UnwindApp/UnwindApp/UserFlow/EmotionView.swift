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
    
    let array: [[Emotion]] = [
        [Emotion(name: "emocao1"), Emotion(name: "emocao2"), Emotion(name: "emocao3"), Emotion(name: "emocao4")],
        [Emotion(name: "emocao5"), Emotion(name: "emocao6"), Emotion(name: "emocao7"), Emotion(name: "emocao8")],
        [Emotion(name: "emocao9"), Emotion(name: "emocao10"), Emotion(name: "emocao11"), Emotion(name: "emocao12")],
        [Emotion(name: "emocao13"), Emotion(name: "emocao14"), Emotion(name: "emocao15"), Emotion(name: "emocao16")]
    ]
    
}

struct EmotionView: View {
    
    @ObservedObject var viewModel = EmotionViewModel()
    
    @State var selectedRows = Set<UUID>()
    
    var body: some View {
        VStack(spacing: 100){
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
            
            //==============================
            //USE CODE BELLOW TO SAVE THE EMOTIONS
            //Use emotionTest.name to get emotion
            //==============================
            
//            Button(action: {
//                for item in self.selectedRows {
//                    for emotion in self.viewModel.array{
//                        for emotionTest in emotion {
//                            if emotionTest.id == item {
//                                print(emotionTest.name)
//                            }
//                        }
//                    }
//                }
//            }) {
//                Text("Button")
//            }
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
            .foregroundColor(Color.fontColorBlue)
        }.background(
            Group{
                if self.isSelected{
                    Color.lightGreen
                }
            }
        )
        .overlay(
            Group{
                if self.isSelected {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.strokeGreen, lineWidth: 5)
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.strokeGray, lineWidth: 2)
                }
            }
        )
        .buttonStyle(EmotionButtonStyle())
    }
}
