//
//  Block.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/13/20.
//

import Foundation

struct Block: CustomStringConvertible {

    struct Segment: CustomStringConvertible {
        let start: TimeOfDay
        let end: TimeOfDay
        let segmentClass: Class

        var description: String { "[\(start) - \(end)] \(segmentClass)" }
    }

    let start: TimeOfDay
    let end: TimeOfDay
    let classes: [Class]
    let classSpacing: Int
    let classBias: Int

    init(start: TimeOfDay, end: TimeOfDay, classes: [Class], classSpacing: Int = 4, classBias: Int = 0) {
        self.start = start
        self.end = end
        self.classes = classes
        self.classSpacing = classSpacing
        self.classBias = classBias
    }

    var segments: [Segment] {
        let duration = start.duration(to: end)

        guard classes.count > 1 else {
            return [Segment(start: start, end: end, segmentClass: classes[0])]
        }

        let reservedTime = (classes.count - 1) * classSpacing + classes.reduce(0, { $0 + $1.reservedTime })
        let shareCount = classes.filter { $0.duration == nil }.count
        let freeTime = duration - reservedTime
        let sharedClassDuration = freeTime / shareCount
        var rollingStart = start
        var segs: [Segment] = []
        for (index, aClass) in classes.enumerated() {
            let classDuration = aClass.duration ?? sharedClassDuration + classBias
            let endTime: TimeOfDay
            if index == classes.count - 1 {
                endTime = end
            } else {
                endTime = rollingStart.adding(duration: classDuration)
            }
            segs.append(Segment(start: rollingStart, end: endTime, segmentClass: aClass))
            rollingStart = rollingStart.adding(duration: classDuration + classSpacing)
        }
        return segs
    }

    var description: String { segments.map { $0.description }.joined(separator: "\n") }
}
