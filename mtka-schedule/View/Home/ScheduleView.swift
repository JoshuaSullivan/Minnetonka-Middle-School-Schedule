//
//  ScheduleView.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/19/20.
//

import SwiftUI

struct ScheduleView<ViewModel: ScheduleViewModelProtocol>: View {

    @ObservedObject var viewModel: ViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ScheduleNavView(viewModel: viewModel)
                VStack {
                    ForEach(viewModel.days) { dayVm in
                        ScheduleDayView(viewModel: dayVm)
                    }
                }.padding()
            }
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static let vm = ScheduleViewModel(scheduleService: ScheduleService(storage: StorageService()))

    static var previews: some View {
        ScheduleView(viewModel: vm)
    }
}
