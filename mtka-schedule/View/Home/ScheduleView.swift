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
        VStack(spacing: 0) {
            ScheduleNavView(viewModel: viewModel)

            ScrollView {
                VStack {
                    ForEach(viewModel.days) { dayVm in
                        ScheduleDayView(viewModel: dayVm)
                    }.padding([.top, .bottom])
                }
            }.padding([.leading, .trailing])
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static let vm = ScheduleViewModel(scheduleService: ScheduleService(storage: StorageService()))

    static var previews: some View {
        ScheduleView(viewModel: vm)
    }
}
