//
//  ContentView.swift
//  UnwindApp
//
//  Created by Annderson Packeiser Oreto on 02/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LoginView()
    }
}

struct LoginView: View {
    
    @State private var name: String = "Nome"
    @State private var phone: String = "Telefone"
    @State private var username: String = "E-mail"
    @State private var password: String = "Senha"
    @State private var loginSelected: Bool = true
    
    var body: some View {
        
        GeometryReader { geometry in
            
            // Body of login container
            VStack(alignment: .center, spacing: CGFloat(8.0)) {
                
                // App logo image
                Image(systemName: "star.fill")
                
                // Login switch buttons
                HStack(alignment: .center, spacing: geometry.size.width/2) {
                    
                    Button(action: {
                        
                        self.loginSelected = true
                    }) {
                        Text("Login")
                            .bold()
                            .foregroundColor(Color.black)
                    }
                    
                    Button(action: {
                        
                        self.loginSelected = false
                    }) {
                        Text("Cadastro")
                            .bold()
                            .foregroundColor(Color.gray)
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
                
                // Login or register text fields
                if !self.loginSelected {
                    
                    TextField("Nome", text: self.$name)
                        .textContentType(.emailAddress)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 6.0)
                                .stroke(Color.gray, lineWidth: 0.8)
                    )
                    
                    TextField("Telefone", text: self.$phone)
                        .textContentType(.emailAddress)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 6.0)
                                .stroke(Color.gray, lineWidth: 0.8)
                    )
                    
                }
                
                TextField("E-mail", text: self.$username)
                    .textContentType(.emailAddress)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 6.0)
                            .stroke(Color.gray, lineWidth: 0.8)
                )
                
                TextField("Senha", text: self.$password)
                    .textContentType(.password)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 6.0)
                            .stroke(Color.gray, lineWidth: 0.8)
                ).padding(.bottom, 32.0)
                
                Button(action : {
                    
                }) {
                    Text(self.loginSelected ? "Entrar" : "Cadastrar")
                        .frame(minWidth: geometry.size.width/2, maxWidth: .infinity)
                        .foregroundColor(Color.white)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 32.0).fill(Color.blue))
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .padding(32.0)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
