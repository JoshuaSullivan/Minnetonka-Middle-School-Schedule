//
//  ShortDayBanner.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/20/20.
//

import SwiftUI

struct ShortDayBanner: View {
    var body: some View {
            Text("Shortened school day.")
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 10))
                .background(Color.purple)
                .cornerRadius(16)
    }
}

struct ShortDayBanner_Previews: PreviewProvider {
    static var previews: some View {
        ShortDayBanner()
    }
}
