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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .navigationBarTitle(viewModel.screenTitle)
            .navigationBarItems(
                trailing:
                    NavigationLink(
                        destination: ConfigView(viewModel: viewModel.configViewModel),
                        label: {
                            Image(systemName: "gear")
                                .font(.title)
                        })

            )
    }
}


struct HomeView_Previews: PreviewProvider {

    static var today: String {
        let df = DateFormatter()
        df.dateFormat = "EEEE"
        return df.string(from: Date())
    }

    static var previews: some View {
        NavigationView {
            HomeView(viewModel: HomeViewModel())
        }
        .preferredColorScheme(.dark)
    }
}
