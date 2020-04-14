//
//  ProgressBar.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 07/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

struct ProgressBar: View {
    
    @Binding var currentProgress: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 20) {
                ZStack(alignment: .leading) {
                    Group {
                        RoundedRectangle(cornerRadius: geometry.size.height/2)
                            .foregroundColor(.gray)
                            .opacity(0.3)
                            .frame(width: geometry.size.width*0.75)
                        RoundedRectangle(cornerRadius: geometry.size.height/2)
                            .foregroundColor(.yellow)
                            .frame(width: self.minWidth(geometry.size.width))
                            .animation(.linear)
                    }.frame(height: 20)
                }
            }
        }
    }
}

extension ProgressBar {
    func minWidth(_ base: CGFloat) -> CGFloat {
        return min(base*0.75, base*0.75*currentProgress)
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(currentProgress: .constant(0.2))
    }
}
