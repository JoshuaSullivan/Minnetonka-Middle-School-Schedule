//
//  ContentView.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/10/20.
//

import SwiftUI

struct RootView: View {

    let homeViewModel: HomeViewModel
    let configViewModel: ConfigViewModel

    var body: some View {
        TabView {
            HomeView(viewModel: homeViewModel)
            ConfigView(viewModel: configViewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let storage = StorageService()

    static var previews: some View {
        RootView(
            homeViewModel: HomeViewModel(storage: storage),
            configViewModel: ConfigViewModel(storage: storage)
        )
    }
}
