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
                Text("Settings")
                    .font(.title)
                    .bold()
                VStack(alignment: .leading, spacing: 4) {
                    Text("Student")
                    TextField("Name", text: $viewModel.studentName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                GradePickerView(grade: $viewModel.gradeLevel)

                VStack(alignment: .leading, spacing: 4) {
                    Text("Assembly Teacher")
                    TextField("Name", text: $viewModel.advisoryTeacher)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                ForEach(viewModel.periods) { period in
                    Divider()
                    PeriodConfigurationView(period: period)
                }

                    Button(
                        action: { viewModel.saveTapped() },
                        label: {
                            Text("Save Changes")
                                .padding([.leading, .trailing])
                                .padding([.top, .bottom], 8.0)
                                .foregroundColor(.white)
                        }
                    )
                    .background(Color.accentColor)
                    .cornerRadius(4.0)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .tabItem {
            Image(systemName: "gear")
            Text("Settings")
        }
    }
}

struct ConfigView_Previews: PreviewProvider {

    static var vm = ConfigViewModel(storage: StorageService())

    static var previews: some View {
        TabView {
            ConfigView(viewModel: vm)
        }
        .preferredColorScheme(.dark)
    }
}
