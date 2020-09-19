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
        VStack {
            ScheduleView(viewModel: viewModel.scheduleViewModel)
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
            HomeView(viewModel: HomeViewModel(scheduleService: ScheduleService(storage: StorageService())))
        }
        .preferredColorScheme(.dark)
    }
}
