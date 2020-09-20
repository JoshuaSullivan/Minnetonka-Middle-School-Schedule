//
//  ConferenceDayBanner.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/20/20.
//

import SwiftUI

struct ConferenceDayBanner: View {
    var body: some View {
        Text("Parent/teacher conferences today.")
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 10))
            .background(Color.orange)
            .cornerRadius(16)

    }
}

struct ConferenceDayBanner_Previews: PreviewProvider {
    static var previews: some View {
        ConferenceDayBanner()
    }
}
