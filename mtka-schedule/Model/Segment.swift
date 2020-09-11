//
//  Segment.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/10/20.
//

import Foundation

struct Segment {
    enum SegmentType {
        case normal
        case a
        case b
        case lunch
    }

    let index: Int
    let type: SegmentType
    let start: TimeOfDay
    let end: TimeOfDay
    let classDescription: ClassDescription
}
