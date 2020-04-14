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
    @State private var loginSelected: Bool = true
    @State private var selectedButton: Bool = false
    
    var registerColor: Color {
        return !loginSelected ? Color.strokeBlue : Color.gray
    }
    
    var loginColor: Color {
        return loginSelected ? Color.strokeBlue : Color.gray
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
        
        authStatus.signUp(email: username, password: password) { (result, error) in
            
            if let error = error {
                
                self.error = error.localizedDescription
            } else {
                
                self.username = ""
                self.password = ""
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
                }
                
                VStack(spacing: 100){
                    Image("logo_Login")
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
                                    .stroke(Color.strokeGray, lineWidth: 0.8)
                        )
                        
                        SecureField("Senha", text: self.$password)
                            .padding(10)
                            .textContentType(.password)
                            .font(.system(size: 25))
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 6.0)
                                    .stroke(Color.strokeGray
                                        , lineWidth: 0.8)
                        )
                        // Login or register text fields
                        if !self.loginSelected {
                            
                            TextField("Nome", text: self.$name)
                               .padding(10) .textContentType(.emailAddress)
                                .font(.system(size: 25))
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6.0)
                                        .stroke(Color.strokeGray, lineWidth: 0.8)
                            )
                            
                            TextField("Telefone", text: self.$phone)
                               .padding(10) .textContentType(.emailAddress)
                                .font(.system(size: 25))
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6.0)
                                        .stroke(Color.strokeGray, lineWidth: 0.8)
                            )
                                
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
                }.padding(.top, 100)
            }
            
        }
            .edgesIgnoringSafeArea(.all)
            .padding(.horizontal, 130)
            .background(Color(red: 248/255, green: 250/255, blue: 255/255))
            .onTapGesture {
                UIApplication.shared.endEditing()
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

struct LoginView: View {
    var body: some View {
        
//        NavigationView {
            LoginViewStruct()
//        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(AuthenticationManager())
    }
}
