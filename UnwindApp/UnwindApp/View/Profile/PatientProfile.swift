//
//  PatientProfile.swift
//  UnwindApp
//
//  Created by Marcus Vinicius Vieira Badiale on 22/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

class PatientProfileViewModel: ObservableObject {
    
    @Published var userName: String = "Julia Souza"
    @Published var userEmail: String = "julia.souza@gmail.com"
    @Published var userPhone: String = "51 99165 7809"
    @Published var userNameTitle: String = "Nome"
    @Published var userEmailTitle: String = "E-mail"
    @Published var userPhoneTitle: String = "Telefone"
    @Published var userTypeTitle: String = "Qual melhor representa você"
    @Published var userType: UserTypeOptions = .patient
    
    @Published var showAlert: Bool = false
}

struct PatientProfile: View {
    
    @ObservedObject var viewModel: PatientProfileViewModel = PatientProfileViewModel()
    
    var paddingAccordingDevice: CGFloat {
        return idiom == .pad ? (UIScreen.main.bounds.width * 0.18) : (UIScreen.main.bounds.width * 0.05)
    }
    var textFieldTitleSize: CGFloat {
        return idiom == .pad ? (UIScreen.main.bounds.width * 0.017) : (UIScreen.main.bounds.width * 0.025)
    }
    var textFieldTextSize: CGFloat {
        return idiom == .pad ? (UIScreen.main.bounds.width * 0.024) : (UIScreen.main.bounds.width * 0.04)
    }
    var textFieldPadding: CGFloat {
        return idiom == .pad ? (UIScreen.main.bounds.width * 0.02) : (UIScreen.main.bounds.width * 0.045)
    }
    
    var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack() {
                
                VStack (spacing: 20){
                    HStack {
                        Text("Meu")
                        .kerning(0.8)
                        .font(.system(size: 40))
                        .foregroundColor(Color.white)
                        Text("Perfil")
                        .kerning(0.8)
                        .font(.system(size: 40)).bold()
                        .foregroundColor(Color.white)
                        Spacer()
                    }
                    
                    VStack(spacing: geometry.size.width * 0.04) {
                        Image("default")
                        .resizable()
                        .frame(width: geometry.size.width * 0.21, height: geometry.size.width * 0.21)
                        .clipShape(Circle())
                        VStack(spacing: geometry.size.width * 0.02) {
                            PatientProfileTextField(text: self.$viewModel.userName, title: self.viewModel.userNameTitle, idiom: self.idiom)
                                PatientProfileTextField(text: self.$viewModel.userEmail, title: self.viewModel.userEmailTitle, idiom: self.idiom)
                                PatientProfileTextField(text: self.$viewModel.userPhone, title: self.viewModel.userPhoneTitle, idiom: self.idiom)
                                Button(action: {
                                }) {
                                    ZStack{
                                        HStack{
                                            Text(self.viewModel.userTypeTitle)
                                                .font(.system(size: self.textFieldTitleSize))
                                            .foregroundColor(Color(red: 184/255, green: 188/255, blue: 201/255))
                                            Spacer()
                                        }.offset(y: -UIScreen.main.bounds.width * 0.02)
                                        HStack{
                                            Text(self.viewModel.userType.rawValue)
                                                .font(.system(size: self.textFieldTextSize))
                                            Spacer()
                                        }.padding(.top, self.textFieldPadding)
                                    }
                                }.buttonStyle(PatientPickerButtonStyle())
                            }
                        }
                        .padding(.horizontal, self.paddingAccordingDevice)
                        .padding(.top, geometry.size.width * 0.077)
                        .padding(.bottom, geometry.size.width * 0.09)
                        .background(
                            Color.white
                                .cornerRadius(10)
                                .shadow(color: Color(red: 15/255, green: 36/255, blue: 83/255, opacity: 0.04), radius: 10, x: 0, y: 2)
                        )
                    
                    VStack{
                        Button(action: {
                            self.viewModel.showAlert.toggle()
                        }) {
                            HStack(spacing: geometry.size.width * 0.019){
                                Image("ic_logout")
                                    .resizable()
                                    .frame(width: geometry.size.width * 0.029, height: geometry.size.width * 0.029)
                                Text("Cadastrar Medico")
                                Spacer()
                                Image(systemName: "chevron.right")
                                .foregroundColor(Color(red: 199/255, green: 203/255, blue: 213/255))
                            }
                        }.buttonStyle(ProfileButtonStyle())
                        
                        Divider()
                        
                        Button(action: {
                            
                        }) {
                            HStack(spacing: geometry.size.width * 0.019){
                                Image("ic_medico")
                                .resizable()
                                .frame(width: geometry.size.width * 0.029, height: geometry.size.width * 0.029)
                                Text("Sair")
                                Spacer()
                            }
                        }.buttonStyle(ProfileButtonStyle())
                        
                    }
                    .padding()
                    .background(
                        Color.white
                            .cornerRadius(10)
                            .shadow(color: Color(red: 15/255, green: 36/255, blue: 83/255, opacity: 0.04), radius: 10, x: 0, y: 2)
                    )
                }
                .padding(.horizontal, geometry.size.width * 0.06)
                
                if self.viewModel.showAlert {
                    BackgroundAlert {
                        AlertsView(alertType: .confirmation)
                    }.onTapGesture {
                        self.viewModel.showAlert.toggle()
                    }
                }
                
            }
        }.background(BackgroundWithShape())
            
    }
}

struct BackgroundAlert<Content: View>: View {
    private var content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        Color.black.opacity(0.4)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .overlay(content)
    }
}

struct Divider: View {
    let color: Color = Color(red: 184/255, green: 188/255, blue: 201/255)
    let width: CGFloat = 1
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .padding(.horizontal, UIScreen.main.bounds.width * 0.029)
    }
}

struct PatientPickerButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(.horizontal, UIScreen.main.bounds.width * 0.039)
        .padding(.vertical, UIScreen.main.bounds.width * 0.021)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(red: 217/255, green: 219/255, blue: 226/255), lineWidth: 1.5)
        )
        .foregroundColor(Color(red: 184/255, green: 188/255, blue: 201/255))
    }
}

struct ProfileButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
        .padding(.horizontal, UIScreen.main.bounds.width * 0.029)
        .frame(height: UIScreen.main.bounds.width * 0.09)
    }
}

struct PatientProfileTextField: View {
    
    @Binding var text: String
    var title: String
    var idiom: UIUserInterfaceIdiom
    
    var textFieldTitleSize: CGFloat {
        return idiom == .pad ? (UIScreen.main.bounds.width * 0.017) : (UIScreen.main.bounds.width * 0.025)
    }
    
    var textFieldTextSize: CGFloat {
        return idiom == .pad ? (UIScreen.main.bounds.width * 0.024) : (UIScreen.main.bounds.width * 0.04)
    }
    
    var textFieldPadding: CGFloat {
        return idiom == .pad ? (UIScreen.main.bounds.width * 0.02) : (UIScreen.main.bounds.width * 0.045)
    }
    
    var body: some View {
        ZStack{
            HStack{
                Text(title)
                .font(.system(size: textFieldTitleSize))
//                    .font(.system(size: UIScreen.main.bounds.width * 0.02))
                .foregroundColor(Color(red: 184/255, green: 188/255, blue: 201/255))
                Spacer()
            }.padding(.horizontal, UIScreen.main.bounds.width * 0.035)
                .offset(y: -UIScreen.main.bounds.width * 0.02)
            TextField(title, text: self.$text)
                .disabled(true)
                .foregroundColor(Color(red: 184/255, green: 188/255, blue: 201/255))
                .padding(.horizontal, UIScreen.main.bounds.width * 0.035)
                .padding(.vertical, UIScreen.main.bounds.width * 0.018)
                .padding(.top, textFieldPadding)
                .font(.system(size: textFieldTextSize))
//                .font(.system(size: UIScreen.main.bounds.width * 0.03))
                .overlay(
                    RoundedRectangle(cornerRadius: 6.0)
                        .stroke(Color(red: 217/255, green: 219/255, blue: 226/255), lineWidth: 1.5)
            )
        }
    }
}

struct PatientProfile_Previews: PreviewProvider {
    static var previews: some View {
    
        Group {
            PatientProfile()
                .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
                .previewDisplayName("iPhone 11")
            PatientProfile()
                .previewDevice(PreviewDevice(rawValue: "iPad Pro (9.7-inch)"))
                .previewDisplayName("iPad Pro (9.7-inch)")
        }
    }
}


