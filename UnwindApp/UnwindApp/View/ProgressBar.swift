//
//  ProgressBar.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 07/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

struct ProgressBar: View {
    
    var currentPage: CGFloat
    @State var currentProgress: CGFloat = 0
    
    let totalPages: CGFloat = 5
    
    let width = UIScreen.main.bounds.width*0.75
    let height = UIScreen.main.bounds.width*0.75*0.0268
    
    var body: some View {
        ZStack(alignment: .leading) {
            Group {
                RoundedRectangle(cornerRadius: self.height/2)
                    .foregroundColor(CustomColor.progressBarBottom.color)
                    .frame(width: self.width)
                RoundedRectangle(cornerRadius: self.height/2)
                    .foregroundColor(CustomColor.progressBarTop.color)
                    .frame(width: self.minWidth())
                    .animation(.linear)
            }.frame(height: self.height)
        }
    }
}

extension ProgressBar {
    func calculateProgress() {
        DispatchQueue.main.async {
            self.currentProgress = self.currentPage/self.totalPages
        }
    }
    
    func minWidth() -> CGFloat {
        calculateProgress()
        return min(width, width*currentProgress)
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(currentPage: 1)
    }
}
