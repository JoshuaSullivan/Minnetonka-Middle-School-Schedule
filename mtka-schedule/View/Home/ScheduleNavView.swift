//
//  ScheduleNavView.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/19/20.
//

import SwiftUI

struct ScheduleNavView<ViewModel: ScheduleViewModelProtocol>: View {

    @ObservedObject var viewModel: ViewModel

    var body: some View {
        HStack(alignment: .center, spacing: 20.0) {
            Spacer()

            Button(
                action: { viewModel.prevWeekTapped() },
                label: { Image(systemName: "backward").font(.headline) }
            ).frame(width: 40, height: 40).accentColor(.white)

            Text("Week of \(viewModel.weekName)")
                .font(.headline)
                .foregroundColor(.white)

            Button(
                action: { viewModel.nextWeekTapped() },
                label: { Image(systemName: "forward").font(.headline) }
            ).frame(width: 40, height: 40).accentColor(.white)
            
            Spacer()
        }
        .background(Color.accentColor)
    }
}

struct ScheduleNavView_Previews: PreviewProvider {
    static let vm = ScheduleViewModel(scheduleService: ScheduleService(storage: StorageService()))

    static var previews: some View {
        ScheduleNavView(viewModel: vm)
    }
}
