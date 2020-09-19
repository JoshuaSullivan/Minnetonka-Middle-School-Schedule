//
//  ScheduleBlockView.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/19/20.
//

import SwiftUI

struct ScheduleBlockView<ViewModel: ScheduleBlockViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            HStack(spacing: 0) {
                VStack(alignment: .leading) {
                    Text(viewModel.timespan)
                        .font(.caption)
                    Text(viewModel.title)
                        .font(.headline)
                    if let meetCode = viewModel.meetCode {
                        HStack {
                            Text("Meet code:")
                            Text(meetCode)
                        }
                        .font(.subheadline)
                    }
                }
                .frame(height: max(50.0, CGFloat(viewModel.duration) * 2.0), alignment: .topLeading)
                Spacer()
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 4.0)
                    .stroke()
            )
            .overlay(buildMarker())
        }
    }
    
    @ViewBuilder private func buildMarker() -> some View {
        if let markerTime = viewModel.markerTime {
            TimeIndicator()
                .padding([.leading, .top], -5.0)
                .padding([.top], CGFloat(markerTime) * 2.0)
        }
    }
}

struct ScheduleBlockView_Previews: PreviewProvider {
    static let block = Schedule.Block(
        id: "Test",
        className: "Test Class",
        teacher: "Teacher Name",
        start: TimeOfDay(hours: 9, minutes: 30),
        end: TimeOfDay(hours: 11, minutes: 05)
    )
    
    static let blockTwo = Schedule.Block(
        id: "Test2",
        className: "Lunch",
        teacher: nil,
        start: TimeOfDay(hours: 11, minutes: 10),
        end: TimeOfDay(hours: 11, minutes: 40)
    )
    
    static var vm = ScheduleBlockViewModel(block: block)
    static var vmTwo = ScheduleBlockViewModel(block: blockTwo, ticker: MinuteTicker.staticMock(with: TimeOfDay(hours: 11, minutes: 30)))
    
    static var previews: some View {
        VStack {
            ScheduleBlockView(viewModel: vm)
            ScheduleBlockView(viewModel: vmTwo)
            Spacer()
        }
        .padding()
    }
}
