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
                ScheduleView(viewModel: viewModel.scheduleViewModel)
            }
            .navigationBarTitle(viewModel.title)
        }
        .tabItem {
            Image(systemName: "house")
            Text("Home")
        }
    }
}


struct HomeView_Previews: PreviewProvider {

    static var previews: some View {
        TabView {
            HomeView(viewModel: HomeViewModel(scheduleService: ScheduleService(storage: StorageService())))
        }
        .preferredColorScheme(.dark)
    }
}
