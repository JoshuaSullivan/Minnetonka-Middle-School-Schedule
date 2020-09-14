//
//  Binding.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/13/20.
//

import SwiftUI

extension Binding: Identifiable where Value == Class {
    public var id: String {
        return wrappedValue.id
    }
}
