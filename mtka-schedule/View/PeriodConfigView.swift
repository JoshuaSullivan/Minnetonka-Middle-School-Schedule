//
//  PeriodConfigView.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/10/20.
//

import SwiftUI

struct PeriodConfigView<ViewModel: PeriodConfigViewModel>: View {
    let viewModel: ViewModel

    var body: some View {
        VStack {
            HStack {
                Text("Period \(viewModel.period)")
                Text("")
            }

        }
    }
}

struct PeriodConfigView_Previews: PreviewProvider {
    static let vm = PeriodConfigViewModel(
        period: 1,
        className: "Choir",
        teacherName: "Mrs. Singer",
        gradeLevel: .seventh
    )

    static var previews: some View {
        List {
            PeriodConfigView(viewModel: vm)
        }
    }
}
