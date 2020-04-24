//
//  Alerts.swift
//  UnwindApp
//
//  Created by Marcus Vinicius Vieira Badiale on 09/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

enum AlertType {
    case report
    case confirmation
    case otherFeeling
    case otherEmotion
    case registerPatient
    
    var title: String {
        switch self{
        case .otherFeeling:
            return "O que está"
        case .otherEmotion:
            return "Qual sua"
        default:
            return ""
        }
    }
    
    var wordBold: String {
        switch self{
        case .otherFeeling:
            return "sentindo?"
        case .otherEmotion:
            return "emoção?"
        default:
            return ""
        }
    }
}

struct AlertsView: View {
    
//MARK:- Alerts Variables
    @State var nameText = ""
    @State var emailText = ""
    @State var alertType: AlertType
    @State var otherText = ""
    
    var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    
    var body: some View {
        ZStack{
                self.showAlert()
            }
            .edgesIgnoringSafeArea(.all)
            .onTapGesture{
                UIApplication.shared.endEditing()
            }
    }
    
    //Function to show the right alert view
    func showAlert() -> AnyView {
        
        switch self.alertType {
        case .report:
            return AnyView(Report(nameText: self.$nameText, emailText: self.$emailText, idiom: self.idiom))
        case .confirmation:
            return AnyView(Confirmation())
        case .otherFeeling, .otherEmotion :
            return AnyView(OtherFeelingOrEmotion(text: self.otherText, feelingOrEmotion: self.alertType))
        case .registerPatient:
            return AnyView(RegisterPatient(emailText: self.$emailText, idiom: self.idiom))
        }
    }
}
//MARK:- RegisterPatient AlertView
struct RegisterPatient: View {
    
    @EnvironmentObject var authStatus: AuthenticationManager
    @Binding var emailText: String
    var idiom: UIUserInterfaceIdiom

    var emailTextIsValid: Bool {
        return !emailText.isEmpty
    }
    
    var paddingAccordingDevice: CGFloat {
        return idiom == .pad ? (UIScreen.main.bounds.width * 0.029) : (UIScreen.main.bounds.width * 0.049)
    }
    
    var textFieldHeightAccordingDevice: CGFloat {
        return idiom == .pad ? (UIScreen.main.bounds.width * 0.08) : (UIScreen.main.bounds.width * 0.11)
    }
    
    var body: some View{
        VStack(spacing: paddingAccordingDevice){
            HStack{
                Spacer()
                Button(action: {
                    //==============================
                    //CLOSE THE VIEW HERE
                    //==============================
                    print("Close")
                }) {
                    Image(systemName: "xmark")
                    .font(.system(size: UIScreen.main.bounds.width * 0.044))
                    .foregroundColor(Color(red: 149/255, green: 156/255, blue: 175/255))
                }.padding(.top, UIScreen.main.bounds.width * 0.03)
            }.offset(x: UIScreen.main.bounds.width * 0.036)
            HStack{
                Text("Cadastrar")
                    .kerning(0.8)
                    .font(.system(size: UIScreen.main.bounds.width * 0.05))
                    .foregroundColor(Color.fontColorBlack)
                Text("paciente")
                    .kerning(0.8)
                    .font(.system(size: UIScreen.main.bounds.width * 0.05)).bold()
                    .foregroundColor(Color.fontColorBlack)
                Spacer()
            }
            TextField("E-mail", text: $emailText)
                .padding(UIScreen.main.bounds.width * 0.039)
                .frame(height: self.textFieldHeightAccordingDevice)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.strokeGray, lineWidth: 1.5)
                )
            Button(action: {
                //==============================
                //REGISTER PATIENT LOGIC HERE
                //Use nameText and emailText
                //==============================
                self.authStatus.sendPending(email: self.emailText)
                print(self.emailText)
            }) {
                Text("Cadastrar")
                .kerning(0.8)
                .font(.system(size: UIScreen.main.bounds.width * 0.039)).bold()
                }
//            .
                .buttonStyle(AlertsButtonStyle(nameIsValid: true, emailIsValid: emailTextIsValid, idiom: self.idiom))
                .disabled(self.emailText == "")
        }
            .padding(.horizontal, 70)
            .frame(width: getStackSize(isWidth: true))
            .background(
                Color.white
                .cornerRadius(10)
            )
            .onAppear{
                print(UIScreen.main.bounds.width)
        }
    }
    
    func getStackSize(isWidth: Bool) -> CGFloat{
        
        var size: CGFloat
        
        if isWidth{
            size = UIScreen.main.bounds.width * 0.74
        }else {
            size = UIScreen.main.bounds.width * 0.50
        }
        
        return size
    }
}

//MARK:- Report Alert View

struct Report: View {
    
    @Binding var nameText: String
    @Binding var emailText: String
    var idiom: UIUserInterfaceIdiom
    
    var nameTextIsValid: Bool {
        return !nameText.isEmpty
    }
    var emailTextIsValid: Bool {
        return !emailText.isEmpty
    }
    
    var body: some View{
        VStack(spacing:20){
            HStack{
                Spacer()
                Button(action: {
                    //==============================
                    //CLOSE THE VIEW HERE
                    //==============================
                    print("Close")
                }) {
                    Image(systemName: "xmark")
                    .font(.system(size: 34))
                    .foregroundColor(Color(red: 149/255, green: 156/255, blue: 175/255))
                }.padding(.top, UIScreen.main.bounds.width * 0.03)
            }.offset(x: UIScreen.main.bounds.width * 0.036)
            HStack{
                Text("Enviar")
                    .kerning(0.8)
                    .font(.system(size: 40))
                    .foregroundColor(Color.fontColorBlack)
                Text("relatório")
                    .kerning(0.8)
                    .font(.system(size: 40)).bold()
                    .foregroundColor(Color.fontColorBlack)
                Spacer()
            }
            TextField("Nome", text: $nameText)
                .padding(30)
                .frame(height: UIScreen.main.bounds.width * 0.08)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.strokeGray, lineWidth: 1.5)
                )
            TextField("E-mail", text: $emailText)
                .padding(30)
                .frame(height: UIScreen.main.bounds.width * 0.08)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.strokeGray, lineWidth: 1.5)
                )
            Button(action: {
                //==============================
                //SAVE THE REPORT INFORMATIONS HERE
                //Use nameText and emailText
                //==============================
                print(self.nameText, self.emailText)
            }) {
                Text("Enviar")
                .kerning(0.8)
                .font(.system(size: 30)).bold()
                }
//            .
                .buttonStyle(AlertsButtonStyle(nameIsValid: nameTextIsValid, emailIsValid: emailTextIsValid, idiom: self.idiom))
                .disabled(self.nameText  ==  ""  || self.emailText == "")
        }
            .padding(.horizontal, 70)
            .frame(width: getStackSize(isWidth: true), height: getStackSize(isWidth: false))
            .background(
                Color.white
                .cornerRadius(10)
            )
    }
    
    func getStackSize(isWidth: Bool) -> CGFloat{
        
        var size: CGFloat
        
        if isWidth{
            size = UIScreen.main.bounds.width * 0.74
        }else {
            size = UIScreen.main.bounds.width * 0.50
        }
        
        return size
    }
}

//MARK:- Confirmation Alert View

struct Confirmation: View {
    
    var body: some View {
        VStack(spacing:25){
            Image("ic_parabens")
                .resizable()
                .frame(width: self.getImageSize(), height: self.getImageSize())
            Text("Júlia, o relatório foi enviado com sucesso!")
            .kerning(0.76)
            .font(.system(size: 38))
            .foregroundColor(Color.fontColorBlack)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 100)
            Button(action: {
                print("Ok")
                //==============================
                //TOGGLE THE VIEW TO HIDE HERE
                //==============================
            }) {
                Text("Continuar")
                    .kerning(0.3)
                    .font(.system(size: 30)).bold()
            }.buttonStyle(ConfirmationButtonStyle())
        }
            .frame(width: getStackSize(isWidth: true), height: getStackSize(isWidth: false))
            .background(
                Color.white
                .cornerRadius(10)
            )
    }
    
    func getStackSize(isWidth: Bool) -> CGFloat{
        var size: CGFloat
        if isWidth{
            size = UIScreen.main.bounds.width * 0.74
        }else {
            size = UIScreen.main.bounds.width * 0.65
        }
        return size
    }
    
    func getImageSize() -> CGFloat {
        
        let size = UIScreen.main.bounds.width * 0.26
        return size
    }
}

//MARK:- Other Feeling or Emotion Alert View

struct OtherFeelingOrEmotion: View {
    
    @State var text: String
    @State var feelingOrEmotion: AlertType
    
    var textIsValid: Bool {
        return !text.isEmpty
    }
    
    var body: some View {
        VStack(spacing:25){
            
            HStack{
                Spacer()
                Button(action: {
                    //==============================
                    //CLOSE THE VIEW HERE
                    //==============================
                    print("Close")
                }) {
                    Image(systemName: "xmark")
                    .font(.system(size: 34))
                    .foregroundColor(Color(red: 149/255, green: 156/255, blue: 175/255))
                }.padding(.top, UIScreen.main.bounds.width * 0.05)
            }.offset(x: UIScreen.main.bounds.width * 0.036)
            
            HStack{
                Text(self.feelingOrEmotion.title)
                .kerning(0.80)
                .font(.system(size: 40))
                .foregroundColor(Color.fontColorBlack)
                Text(self.feelingOrEmotion.wordBold)
                .kerning(0.80)
                    .font(.system(size: 40)).bold()
                .foregroundColor(Color.fontColorBlack)
                Spacer()
            }
            
            MultiLineTextField(text: self.$text)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.strokeGray, lineWidth: 2)
            )
            .frame(width: self.getTextFieldSize(isWidth: true), height: self.getTextFieldSize(isWidth: false))
            
            Button(action:{
                //==============================
                //SAVE THE OTHER TEXT HERE
                //==============================
                print(self.text)
            }) {
                Text("Salvar")
                .kerning(0.3)
                .font(.system(size: 30)).bold()
            }.buttonStyle(OtherButtonStyle(textIsValid: self.textIsValid))
        }
            .padding(.horizontal, 70)
            .frame(width: getStackSize(isWidth: true), height: getStackSize(isWidth: false))
            .background(
                Color.white
                .cornerRadius(10)
            )
    }
    
    func getTextFieldSize(isWidth: Bool) -> CGFloat{
        var size: CGFloat
        if isWidth{
            size = UIScreen.main.bounds.width * 0.59
        }else {
            size = UIScreen.main.bounds.width * 0.24
        }
        return size
    }
    
    func getStackSize(isWidth: Bool) -> CGFloat{
        var size: CGFloat
        if isWidth{
            size = UIScreen.main.bounds.width * 0.74
        }else {
            size = UIScreen.main.bounds.width * 0.57
        }
        return size
    }
}

//MARK:- Buttons Styles

struct AlertsButtonStyle: ButtonStyle {
    
    var nameIsValid: Bool
    var emailIsValid: Bool
    var idiom: UIUserInterfaceIdiom
    
    var sizeAccordingDevice: CGFloat {
        return idiom == .pad ? (UIScreen.main.bounds.width * 0.08) : (UIScreen.main.bounds.width * 0.11)
    }
    
    var opacity: Double {
        return nameIsValid && emailIsValid ? 1 : 0.6
    }
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
        .frame(width: UIScreen.main.bounds.width * 0.59, height: sizeAccordingDevice)
        .background(Color.sendButtonColor.opacity(self.opacity))
        .cornerRadius(100)
        .foregroundColor(Color.white)
        .padding(.bottom, UIScreen.main.bounds.width * 0.06)
    }
}

struct ConfirmationButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
        .frame(width: UIScreen.main.bounds.width * 0.59, height: UIScreen.main.bounds.width * 0.08)
        .background(Color.sendButtonColor)
        .cornerRadius(100)
        .foregroundColor(Color.white)
        .padding(.bottom, UIScreen.main.bounds.width * 0.06)
    }
}

struct OtherButtonStyle: ButtonStyle {
    
    var textIsValid: Bool
    
    var opacity: Double {
        return textIsValid ? 1 : 0.6
    }
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
        .frame(width: UIScreen.main.bounds.width * 0.59, height: UIScreen.main.bounds.width * 0.08)
        .background(Color.sendButtonColor.opacity(self.opacity))
        .cornerRadius(100)
        .foregroundColor(Color.white)
        .padding(.bottom, UIScreen.main.bounds.width * 0.06)
    }
}

struct Alerts_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AlertsView(alertType: .registerPatient)
                .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
                .previewDisplayName("iPhone 11")
            AlertsView(alertType: .registerPatient)
                .previewDevice(PreviewDevice(rawValue: "iPad Pro (9.7-inch)"))
                .previewDisplayName("iPad Pro (9.7-inch)")
        }
    }
}


