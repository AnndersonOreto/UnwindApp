//
//  DescribeView.swift
//  UnwindApp
//
//  Created by Marcus Vinicius Vieira Badiale on 08/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

enum DescribeState {
    case situation
    case thoughts
    case action
    
    var title: String {
        switch self {
        case .situation:
            return "Júlia, em que situação isso fez despertar essas emoções?"
        case .thoughts:
            return "Que pensamentos você teve neste momento?"
        case .action:
            return "Júlia, qual foi sua ação nesse momento?"
        }
    }
}

class DescribeViewModel: ObservableObject {
    
    //This state is for differentiate the views (Situation, Thoughts and Action)
    @Published var state: DescribeState = .situation
    
    func setState(state: DescribeState) {
        self.state = state
    }
}

struct DescribeView: View {
    
    @EnvironmentObject var authStatus: AuthenticationManager
    @State var text = ""
    @State var value: CGFloat = 0
    @ObservedObject var viewModel = DescribeViewModel()
    
    var body: some View {
        
        Background {
            VStack(spacing: 130){
                Text("ProgressBAR") 
                Text(self.viewModel.state.title)
                    .kerning(0.8)
                .font(.system(size: 40))
                .foregroundColor(Color.fontColorBlack)
                .padding(.horizontal, 128)
                MultiLineTextField(text: self.$text)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.strokeGray, lineWidth: 2)
                    )
                    .frame(width: self.getTextFieldSize(isWidth: true), height: self.getTextFieldSize(isWidth: false))
                Spacer()
                Button(action: {
                    
                    switch self.viewModel.state {
                    case .situation:
                        //Save the situation text here and change the state for thoughts
                        FeelingsInfo.sharedInstance.user_situation = self.text
//                        self.authStatus.setUserFeeling(user_feeling: self.text, feelingType: "user_situation")
                        break
                    case .thoughts:
                        //Save the thoughts text here and change the state for action
                        FeelingsInfo.sharedInstance.user_thoughts = self.text
//                        self.authStatus.setUserFeeling(user_feeling: self.text, feelingType: "user_thoughts")
                        break
                    case .action:
                        //Save the action text here and pass to next screen
                        FeelingsInfo.sharedInstance.user_action = self.text
//                        self.authStatus.setUserFeeling(user_feeling: self.text, feelingType: "user_action")
                        break
                    }
                    
                    self.text = ""
                    
                    if self.viewModel.state == DescribeState.situation {
                        self.viewModel.state = DescribeState.thoughts
                    } else if self.viewModel.state == DescribeState.thoughts {
                        self.viewModel.state = DescribeState.action
                    } else {
                        self.authStatus.saveFeelingsPackage()
                    }
                }) {
                    Text("Salvar")
                        .kerning(0.3)
                    .font(.system(size: 30)).bold()
                }.buttonStyle(SendButtonStyle())
                    .offset(y: -self.value)
                        .animation(.spring())
                        .onAppear {
                            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti) in
                                
                                let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                                let height = value.height
                                
                                self.value = height
                            }
                            
                            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti) in
                                
                                self.value = 0
                            }
                        }
            }
        }.onTapGesture {
            UIApplication.shared.endEditing()
        }
        
    }
    
    
    func getTextFieldSize(isWidth: Bool) -> CGFloat{
        
        var size: CGFloat
        
        if isWidth{
            size = UIScreen.main.bounds.width * 0.89
        }else {
            size = UIScreen.main.bounds.width * 0.34
        }
        
        return size
    }
    
}

struct SendButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
        .frame(width: UIScreen.main.bounds.width * 0.89, height: UIScreen.main.bounds.width * 0.08)
        .background(Color.sendButtonColor)
        .cornerRadius(100)
        .foregroundColor(Color.white)
        .padding(.bottom, UIScreen.main.bounds.width * 0.07)
    }
}


//A background to get the tap gesture and close the keyboard
struct Background<Content: View>: View {
    private var content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        Color.white
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .overlay(content)
    }
}

//MARK:- MultiTextField (TextView)

struct MultiLineTextField: UIViewRepresentable {
    
    @Binding var text: String
    var placeHolderText = "Descreva aqui"
    
    func makeUIView(context: UIViewRepresentableContext<MultiLineTextField>) -> UITextView {
        let textView = UITextView()
        
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        textView.textContainerInset = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        textView.text = placeHolderText
        textView.textColor = .placeholderText
        textView.font = UIFont.systemFont(ofSize: 25)
        textView.delegate = context.coordinator
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<MultiLineTextField>) {
        
    }
    
    func makeCoordinator() -> MultiLineTextField.Coordinator {
        return MultiLineTextField.Coordinator(parent1: self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        
        var parent: MultiLineTextField
        
        init(parent1: MultiLineTextField) {
            self.parent = parent1
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == parent.placeHolderText {
                textView.text = ""
            }
            textView.textColor = .label
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text == "" {
                textView.text = parent.placeHolderText
                textView.textColor = .placeholderText
            }
        }
    }
}

struct DescribeView_Previews: PreviewProvider {
    static var previews: some View {
        DescribeView().environmentObject(AuthenticationManager())
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
