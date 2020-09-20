//
//  ScheduleDayView.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/19/20.
//

import SwiftUI

struct ScheduleDayView<ViewModel: ScheduleDayViewModelProtocol>: View {

    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.name)
                .font(.title)
            ForEach(viewModel.blocks) { blockVm in
                ScheduleBlockView(viewModel: blockVm)
            }
        }
    }
}

struct ScheduleDayView_Previews: PreviewProvider {
    static let schedule = PreviewData.ScheduleMocks.schedule
    static let vm = ScheduleDayViewModel(schedule: schedule)
    static var previews: some View {
        ScheduleDayView(viewModel: vm)
    }
}
