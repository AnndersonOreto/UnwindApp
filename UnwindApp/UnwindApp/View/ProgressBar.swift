//
//  ProgressBar.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 07/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

struct ProgressBar: View {
    
    @State var currentProgress: CGFloat = 0.0
    
    var currentPage: CGFloat
    var totalPages: CGFloat
    
    init(currentPage: CGFloat, totalPages: CGFloat) {
        self.currentPage = currentPage
        self.totalPages = totalPages
        self.currentProgress = self.currentPage/self.totalPages
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            GeometryReader { geometry in
                Group {
                    RoundedRectangle(cornerRadius: 100)
                        .foregroundColor(.gray)
                        .frame(width: geometry.size.width*0.75)
                    RoundedRectangle(cornerRadius: 100)
                        .foregroundColor(.yellow)
                        .frame(width: geometry.size.width*0.75*self.currentProgress)
                }.frame(height: 20)
            }
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(currentPage: 1, totalPages: 5)
    }
}
