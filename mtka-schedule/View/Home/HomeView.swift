//
//  HomeView.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/10/20.
//

import SwiftUI

struct HomeView<ViewModel: HomeViewModelProtocol>: View {

    @ObservedObject var viewModel: ViewModel

    var body: some View {
        NavigationView {
            VStack {
                AtAGlanceView(viewModel: viewModel.atAGlanceViewModel)
            }
            .navigationBarTitle(viewModel.screenTitle)
        }
        .tabItem {
            Image(systemName: "house")
            Text("Home")
        }
    }
}


struct HomeView_Previews: PreviewProvider {

    static var today: String {
        let df = DateFormatter()
        df.dateFormat = "EEEE"
        return df.string(from: Date())
    }

    static var previews: some View {
        TabView {
            HomeView(viewModel: HomeViewModel(storage: StorageService()))
        }
        .preferredColorScheme(.dark)
    }
}
