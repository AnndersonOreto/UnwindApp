//
//  LoginView.swift
//  UnwindApp
//
//  Created by Annderson Packeiser Oreto on 08/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

struct LoginViewStruct: View {
    
    @EnvironmentObject var authStatus: AuthenticationManager
    @State private var name: String = ""
    @State private var phone: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var error: String = ""
    @State private var role: String = ""
    @State private var loginSelected: Bool = true
    @State private var selectedButton: Bool = false
    @State private var pickerText: String = "Qual melhor representa você?"
    @State var value: CGFloat = 0
    
    @State var showPicker: Bool = false
    @State var userType: UserTypeOptions = .patient
    
    var registerColor: Color {
        return !loginSelected ? Color.strokeBlue : Color.gray
    }
    
    var loginColor: Color {
        return loginSelected ? Color.strokeBlue : Color.gray
    }
    
    var isPlaceHolder: Bool {
        return pickerText == "Qual melhor representa você?" ? true : false
    }
    
    func signIn() {
        
        authStatus.signIn(email: username, password: password) { (result, error) in
            
            if let error = error {
                
                self.error = error.localizedDescription
            } else {
                
                self.username = ""
                self.password = ""
            }
        }
    }
    
    func signUp() {
        
        authStatus.signUp(email: username, password: password, phone: phone, name: name, role: userType.rawValue) { (result, error) in
            
            if let error = error {
                
                self.error = error.localizedDescription
            } else {
                
                self.username = ""
                self.password = ""
                self.phone = ""
                self.name = ""
            }
        }
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack(){
                VStack{
                   Image("bg_Login")
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 0.65)
                    
                    Spacer()
                    
                    HStack(spacing: 30){
                        Button(action: {
                            
                        }) {
                            Image("ic_apple")
                            .resizable()
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.09, height: UIScreen.main.bounds.width * 0.09)
                        .buttonStyle(PlainButtonStyle())
                        Button(action: {
                            
                        }) {
                            Image("ic_google")
                            .resizable()
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.09, height: UIScreen.main.bounds.width * 0.09)
                        .buttonStyle(PlainButtonStyle())
                        Button(action: {
                            
                        }) {
                            Image("ic_facebook")
                            .resizable()
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.09, height: UIScreen.main.bounds.width * 0.09)
                        .buttonStyle(PlainButtonStyle())
                    }.padding(.bottom, 25)
                }
                
                VStack(spacing: 60){
                    Image("logo_login")
                        .frame(width: UIScreen.main.bounds.width * 0.13, height: UIScreen.main.bounds.width * 0.17)
                    // Body of login container
                    VStack(spacing: 15) {
                        
                        // Login switch buttons
                        HStack(spacing: UIScreen.main.bounds.width * 0.15) {
                            
                            Button(action: {
                                
                                self.loginSelected = true
                            }) {
                                Text("Login")
                                    .fontWeight(.semibold)
                                    .bold()
                                    .font(.system(size: 28))
                                    .foregroundColor(self.loginColor)
                            }
                            
                            Button(action: {
                                
                                self.loginSelected = false
                            }) {
                                Text("Cadastro")
                                    .bold()
                                    .font(.system(size: 28))
                                    .foregroundColor(self.registerColor)
                            }
                        }
                        
                        // Divier below switch buttons
                        HStack(spacing: 0.0) {
                            
                            if self.loginSelected {
                                ExDividerSelected()
                                ExDivider()
                            } else {
                                ExDivider()
                                ExDividerSelected()
                            }
                        }.padding(.bottom, 16.0)
                            .padding(.top, 16.0)

                        
                        TextField("E-mail", text: self.$username)
                           .padding(10) .textContentType(.emailAddress)
                            .font(.system(size: 25))
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 6.0)
                                    .stroke(Color(red: 217/255, green: 219/255, blue: 226/255), lineWidth: 1.5)
                        )
                        
                        SecureField("Senha", text: self.$password)
                            .padding(10)
                            .textContentType(.password)
                            .font(.system(size: 25))
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 6.0)
                                    .stroke(Color(red: 217/255, green: 219/255, blue: 226/255), lineWidth: 1.5)
                        )
                        // Login or register text fields
                        if !self.loginSelected {
                            
                            TextField("Nome", text: self.$name)
                               .padding(10) .textContentType(.emailAddress)
                                .font(.system(size: 25))
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6.0)
                                        .stroke(Color(red: 217/255, green: 219/255, blue: 226/255), lineWidth: 1.5)
                            )
                            
                            TextField("Telefone", text: self.$phone)
                               .padding(10) .textContentType(.emailAddress)
                                .font(.system(size: 25))
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6.0)
                                        .stroke(Color(red: 217/255, green: 219/255, blue: 226/255), lineWidth: 1.5)
                            )
                            
                            Button(action: {
                                self.showPicker.toggle()
                            }) {
                                HStack{
                                    Text(self.pickerText)
                                    .font(.system(size: 25))
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                }
                            }.buttonStyle(PickerButtonStyle(isPlaceHolderColor: self.isPlaceHolder))
                        }
                        
                        if self.loginSelected{
                            HStack{
                                Spacer()
                                Button(action: {
                                    //Esqueceu a senha
                                }) {
                                    Text("Esqueceu a senha")
                                        .font(.system(size: 22))
                                        .fontWeight(.medium).italic().underline()
                                }
                            }
                        }
                        Button(action : {
                            if self.loginSelected {
                                self.signIn()
                            } else {
                                self.signUp()
                            }
                            print("teste1")
                        }) {
                            Text(self.loginSelected ? "Entrar" : "Cadastrar")
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .lineLimit(nil)
                                .frame(width: UIScreen.main.bounds.width * 0.59, height: UIScreen.main.bounds.width * 0.05)
                                .foregroundColor(Color.white)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 38.0).fill(Color.blue))
                        }.padding(.top, 20)
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.63)
                    .padding(.horizontal, 70)
                    .padding(.top, 60)
                    .padding(.bottom, 50)
                    .background(
                        Color.white
                        .cornerRadius(10)
                            .shadow(color: Color(red: 15/255, green: 36/255, blue: 83/255, opacity: 0.04), radius: 10, x: 0, y: 2)
                    )
                    
                    Spacer()
                    
                }.padding(.top, 80)
                .offset(y: -self.value)
                .animation(.spring())
                .onAppear {
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti) in
                        
                        let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                        let height = value.height
                        
                        if !self.loginSelected {
                            self.value = height/1.5
                            print(self.value)
                        }
                    }
                    
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti) in
                        
                        self.value = 0
                    }
                }
                
                VStack{
                    
                    Spacer()
                    
                    if self.showPicker {
                        UserTypePicker(selected: self.$userType)
                            .onAppear {
                                self.value = UIScreen.main.bounds.width * 0.22
                            }
                            .onDisappear {
                                self.pickerText = self.userType.rawValue
                                self.value = 0.0
                            }
                        
                    }
                }
                
                
            }
        }
            .edgesIgnoringSafeArea(.all)
            .padding(.horizontal, 130)
            .background(Color(red: 248/255, green: 250/255, blue: 255/255))
            .onTapGesture {
                UIApplication.shared.endEditing()
                if self.showPicker { self.showPicker.toggle() }
            }
    }
    
    struct ExDivider: View {
        let color: Color = .gray
        let width: CGFloat = 1
        var body: some View {
            Rectangle()
                .fill(color)
                .frame(height: width)
                .edgesIgnoringSafeArea(.horizontal)
        }
    }
    
    struct ExDividerSelected: View {
        let color: Color = .blue
        let width: CGFloat = 3.0
        var body: some View {
            Rectangle()
                .fill(color)
                .frame(height: width)
                .edgesIgnoringSafeArea(.horizontal)
        }
    }
}

struct PickerButtonStyle: ButtonStyle {
    
    var isPlaceHolderColor: Bool
    
    var pickerTextColor: Color {
        return isPlaceHolderColor ? Color(red: 184/255, green: 188/255, blue: 201/255) : Color.black
    }
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
        .padding(25)
        .frame(width: UIScreen.main.bounds.width * 0.63, height: UIScreen.main.bounds.width * 0.1)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(red: 217/255, green: 219/255, blue: 226/255), lineWidth: 1.5)
        )
        .foregroundColor(pickerTextColor)
    }
}
struct LoginView: View {
    var body: some View {
        LoginViewStruct()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(AuthenticationManager())
    }
}
