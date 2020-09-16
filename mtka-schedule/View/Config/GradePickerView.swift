//
//  GradPickerView.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/13/20.
//

import SwiftUI

struct GradePickerView: View {

    @Binding var grade: Grade

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Grade")
            Picker(selection: $grade, label: Text("Grade")) {
                ForEach(Grade.allCases) { grade in
                    Text(grade.rawValue).tag(grade)
                }
            }.pickerStyle(SegmentedPickerStyle())
        }
    }
}

struct GradePickerView_Previews: PreviewProvider {
    @State static var grade = Grade.six
    static var previews: some View {
        GradePickerView(grade: $grade)
            .padding()
    }
}
