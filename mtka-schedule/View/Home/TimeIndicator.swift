//
//  TimeIndicator.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/19/20.
//

import SwiftUI

struct TimeIndicator: View {
    var body: some View {
        ZStack(alignment: .leading, content: {
            Circle()
                .fill(Color.red)
                .frame(width: 10, height: 10)
            Rectangle()
                .fill(Color.red)
                .frame(height: 1)
        })
    }
}

struct TimeIndicator_Previews: PreviewProvider {
    static var previews: some View {
        TimeIndicator()
    }
}
