//
//  AtAGlanceView.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/15/20.
//

import SwiftUI

struct AtAGlanceView<ViewModel: AtAGlanceViewModelProtocol>: View {

    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Right Now")
                    .font(.subheadline)
                Text(viewModel.rightNow)
                    .font(.headline)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text("Up Next")
                    .font(.subheadline)
                Text(viewModel.upNext)
                    .font(.headline)
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.accentColor, lineWidth: 2.0)
        )
    }
}

struct AtAGlanceView_Previews: PreviewProvider {
    static var vm: AtAGlanceViewModel = {
        let vm = AtAGlanceViewModel()
        vm.rightNow = "STEM - Teacher Name"
        vm.upNext = "Geometry - Mathington Teacher"
        return vm
    }()

    static var previews: some View {
        AtAGlanceView(viewModel: vm)
    }
}
