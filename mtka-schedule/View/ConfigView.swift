//
//  ConfigView.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/10/20.
//

import SwiftUI

struct ConfigView<ViewModel: ConfigViewModelProtocol>: View {
    let viewModel: ViewModel

    var body: some View {
        VStack {
            
        }
        .navigationBarTitle(viewModel.screenTitle)
    }
}

struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ConfigView(viewModel: ConfigViewModel())
        }
    }
}
