//
//  Class.swift
//  mtka-schedule
//
//  Created by Joshua Sullivan on 9/13/20.
//

import Foundation

public struct Class: CustomStringConvertible, Identifiable {
    var name: String
    var teacher: String
    let duration: Int?

    init(name: String, teacher: String, duration: Int? = nil) {
        self.name = name
        self.teacher = teacher
        self.duration = duration
    }

    public var description: String {
        teacher.isEmpty ? name : "\(name) - \(teacher)"
    }

    var reservedTime: Int { duration ?? 0 }

    public var id: String { description }
}

extension Class {
    static func lunch(grade: Grade) -> Class {
        return Class(name: "Lunch", teacher: "", duration: grade.lunchDuration)
    }

    static let checkAndConnect = Class(name: "Check & Connect", teacher: "", duration: 15)

    static let empty = Class(name: "", teacher: "")
}
