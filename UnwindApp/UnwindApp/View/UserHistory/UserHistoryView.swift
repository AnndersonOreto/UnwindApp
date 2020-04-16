//
//  UserHistoryView.swift
//  UnwindApp
//
//  Created by Arthur Bastos Fanck on 15/04/20.
//  Copyright © 2020 Annderson Packeiser Oreto. All rights reserved.
//

import SwiftUI

struct UserHistoryView: View {
    @ObservedObject var viewModel = UserHistoryViewModel()
    
    var body: some View {
        SortableList(viewModel: viewModel)
    }
}

struct UserHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        UserHistoryView()
    }
}
