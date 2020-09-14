//
//  ConfigView.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/10/20.
//

import SwiftUI

struct ConfigView<ViewModel: ConfigViewModelProtocol>: View {

    @ObservedObject var viewModel: ViewModel

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 16) {
                VStack(spacing: 4) {
                    Text("Student")
                    TextField("Name", text: $viewModel.studentName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                GradePickerView(grade: $viewModel.gradeLevel)

                ForEach(viewModel.periods) { period in
                    Divider()
                    PeriodConfigurationView(period: period)
                }

                Spacer()
            }
        }
        .padding()
        .navigationBarTitle(viewModel.screenTitle)
        .navigationBarItems(trailing: Button(action: {
            self.viewModel.saveTapped()
        }) {
            Text("Save")
        })
    }
}

struct ConfigView_Previews: PreviewProvider {

    static var vm = ConfigViewModel()

    static var previews: some View {
        NavigationView {
            ConfigView(viewModel: vm)
        }
    }
}
