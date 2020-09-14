//
//  ClassConfigView.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/12/20.
//

import SwiftUI

struct ClassConfigView: View {

    @ObservedObject var aClass: ClassConfiguration

    var body: some View {
        VStack {
            TextField("Class", text: $aClass.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Teacher", text: $aClass.teacher)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }

    init(aClass: ClassConfiguration) {
        self.aClass = aClass
    }
}

struct ClassConfigView_Previews: PreviewProvider {

    static var aClass = ClassConfiguration(aClass: .checkAndConnect)

    static var previews: some View {
        ClassConfigView(aClass: aClass)
    }
}
