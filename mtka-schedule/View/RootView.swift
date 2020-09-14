//
//  ContentView.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/10/20.
//

import SwiftUI

struct RootView: View {
    var homeViewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            HomeView(viewModel: homeViewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
