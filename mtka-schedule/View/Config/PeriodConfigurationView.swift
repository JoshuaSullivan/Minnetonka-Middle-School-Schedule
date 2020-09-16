//
//  PeriodConfigurationView.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/13/20.
//

import SwiftUI

struct PeriodConfigurationView: View {

    @ObservedObject var period: PeriodConfiguration

    var body: some View {
        VStack(alignment: .leading) {
            Text("Period \(period.index)")
                .font(.headline)

            Picker("Period Type", selection: $period.type) {
                Text(PeriodConfiguration.PeriodType.whole.pickerName).tag(PeriodConfiguration.PeriodType.whole)
                Text(PeriodConfiguration.PeriodType.split.pickerName).tag(PeriodConfiguration.PeriodType.split)
            }.pickerStyle(SegmentedPickerStyle())

            HStack {
                if period.type == .split {
                    Text("A")
                        .font(.title)
                        .bold()
                }
                ClassConfigView(aClass: period.firstClass)
            }

            if period.type == .split {
                HStack {
                    Text("B")
                        .font(.title)
                        .bold()
                ClassConfigView(aClass: period.secondClass)
                }
            }
        }
    }
}

struct PeriodConfigurationView_Previews: PreviewProvider {

    @State static var period: PeriodConfiguration = PeriodConfiguration(
        index: 1,
        firstClass: ClassConfiguration(name: "Choir", teacher: "Avid Singer")
    )

    static var previews: some View {
        PeriodConfigurationView(period: period)
            .padding()
    }
}
