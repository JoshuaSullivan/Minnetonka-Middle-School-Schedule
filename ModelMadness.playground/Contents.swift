import SwiftUI

extension DateFormatter {
    static let dayOfWeekFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = DateFormatter.dateFormat(fromTemplate: "EMd", options: 0, locale: Locale.autoupdatingCurrent)
        return df
    }()
}

extension Date {
    func adding(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
}

enum Grade {
    case six
    case seven
    case eight

    var lunchDuration: Int {
        return self == .eight ? 54 : 53
    }

    var lunchBlockSpacing: Int {
        return self == .eight ? 4 : 5
    }
}

struct Week: CustomStringConvertible {
    let start: Date
    let days: [Day]

    var description: String {
        return days
            .map { $0.description(with: start) }
            .joined(separator: "\n\n")
    }
}

struct Day: CustomStringConvertible {
    typealias DateResolver = (Int) -> Date

    let offset: Int
    let blocks: [Block]

    var description: String {
        let blockDescription = blocks
            .map { $0.description}
            .joined(separator: "\n")
        return "Day \(offset)\n\(blockDescription)"
    }

    func description(with date: Date) -> String {
        let offsetDate = date.adding(days: offset)
        let blockDescription = blocks
            .map { $0.description}
            .joined(separator: "\n")
        return "\(DateFormatter.dayOfWeekFormatter.string(from: offsetDate))\n\(blockDescription)"
    }
}

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

struct Class: CustomStringConvertible {
    let name: String
    let teacher: String
    let duration: Int?

    init(name: String, teacher: String, duration: Int? = nil) {
        self.name = name
        self.teacher = teacher
        self.duration = duration
    }

    var description: String {
        teacher.isEmpty ? name : "\(name) - \(teacher)"
    }

    var reservedTime: Int { duration ?? 0 }
}

extension Class {
    static func lunch(grade: Grade) -> Class {
        return Class(name: "Lunch", teacher: "", duration: grade.lunchDuration)
    }

    static let checkAndConnect = Class(name: "Check & Connect", teacher: "", duration: 15)
}

struct TimeOfDay: CustomStringConvertible {
    let hours: Int
    let minutes: Int

    var description: String {
        let normalizedHours = hours > 12 ? hours - 12 : hours
        return "\(normalizedHours):\(minutes < 10 ? "0\(minutes)" : "\(minutes)")"
    }

    func duration(to otherTime: TimeOfDay) -> Int {
        return (otherTime.hours * 60 - hours * 60) + (otherTime.minutes - minutes)
    }

    func adding(duration: Int) -> TimeOfDay {
        let totalMinutes = minutes + duration
        return TimeOfDay(hours: hours + (totalMinutes / 60), minutes: totalMinutes % 60)
    }
}

let choir = Class(name: "Choir", teacher: "Avid Singer")
let gym = Class(name: "PE", teacher:"Sweaty Manz")
let stem = Class(name: "STEM", teacher: "Jakov Alltrades")
let geometry = Class(name: "Geometry", teacher: "Symbolic Proof")
let ss = Class(name: "Social Studies", teacher: "Civic Doody")
let la = Class(name: "Language Arts", teacher: "Rita Book")
let science = Class(name: "Science", teacher: "General Relativity")
let advisory = Class(name: "Advisory", teacher: "Meghan Whatever")
let afternoonBreak = Class(name: "Break", teacher: "")
let mast = Class(name: "MAST/Office Hours", teacher: "")

let t0Start = TimeOfDay(hours: 9, minutes: 15)
let t0End = TimeOfDay(hours: 9, minutes: 30)
let t1Start = TimeOfDay(hours: 9, minutes: 30)
let t1End = TimeOfDay(hours: 11, minutes: 06)
let t2Start = TimeOfDay(hours: 11, minutes: 12)
let t2End = TimeOfDay(hours: 13, minutes: 58)
let t3Start = TimeOfDay(hours: 14, minutes: 05)
let t3End = TimeOfDay(hours: 15, minutes: 40)
let t4Start = TimeOfDay(hours: 15, minutes: 40)
let t4End = TimeOfDay(hours: 15, minutes: 55)

let bMorningCheck = Block(start: t0Start, end: t0End, classes: [.checkAndConnect])
let bAfternoonCheck = Block(start: t4Start, end: t4End, classes: [.checkAndConnect])
let b1 = Block(start: t1Start, end: t1End, classes: [choir, gym], classBias: 1)
let b2 = Block(start: t2Start, end: t2End, classes: [.lunch(grade: .six), stem])
let b3 = Block(start: t3Start, end: t3End, classes: [geometry])
let b4 = Block(start: t1Start, end: t1End, classes: [ss])
let b5 = Block(start: t2Start, end: t2End, classes: [.lunch(grade: .six), la])
let b6 = Block(start: t3Start, end: t3End, classes: [science])

let w1a = Block(start: TimeOfDay(hours: 9, minutes: 15), end: TimeOfDay(hours: 9, minutes: 45), classes: [choir])
let w1b = Block(start: TimeOfDay(hours: 9, minutes: 15), end: TimeOfDay(hours: 9, minutes: 45), classes: [gym])
let w2 = Block(start: TimeOfDay(hours: 9, minutes: 50), end: TimeOfDay(hours: 10, minutes: 20), classes: [stem])
let w3 = Block(start: TimeOfDay(hours: 10, minutes: 25), end: TimeOfDay(hours: 10, minutes: 25), classes: [geometry])
let w4 = Block(start: TimeOfDay(hours: 11, minutes: 00), end: TimeOfDay(hours: 11, minutes: 30), classes: [ss])
let wAdvisory = Block(start: TimeOfDay(hours: 11, minutes: 30), end: TimeOfDay(hours: 12, minutes: 00), classes: [advisory])
let wLunch = Block(start: TimeOfDay(hours: 12, minutes: 00), end: TimeOfDay(hours: 12, minutes: 45), classes: [.lunch(grade: .eight)])
let w5 = Block(start: TimeOfDay(hours: 12, minutes: 45), end: TimeOfDay(hours: 13, minutes: 15), classes: [la])
let w6 = Block(start: TimeOfDay(hours: 13, minutes: 20), end: TimeOfDay(hours: 13, minutes: 50), classes: [science])
let wBreak = Block(start: TimeOfDay(hours: 13, minutes: 50), end: TimeOfDay(hours: 14, minutes: 00), classes: [afternoonBreak])
let wMast = Block(start: TimeOfDay(hours: 14, minutes: 00), end: TimeOfDay(hours: 15, minutes: 55), classes: [mast])

let dayA: [Block] = [bMorningCheck, b1, b2, b3, bAfternoonCheck]
let dayB: [Block] = [bMorningCheck, b4, b5, b6, bAfternoonCheck]
let dayC: [Block] = [w1a, w2, w3, w4, w5, w6, wBreak, wMast]
let dayD: [Block] = [w1b, w2, w3, w4, w5, w6, wBreak, wMast]

let now = Date()
let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: now)!

let weekA = Week(start: tomorrow, days: [
    Day(offset: 0, blocks: dayA),
    Day(offset: 1, blocks: dayB),
    Day(offset: 2, blocks: dayC),
    Day(offset: 3, blocks: dayA),
    Day(offset: 4, blocks: dayB),
])

let weekB = Week(start: tomorrow, days: [
    Day(offset: 0, blocks: dayA),
    Day(offset: 1, blocks: dayB),
    Day(offset: 2, blocks: dayD),
    Day(offset: 3, blocks: dayA),
    Day(offset: 4, blocks: dayB),
])

print("WEEK A\n\(weekA)")
print("\n\n")
print("WEEK B\n\(weekB)")

//let start = TimeOfDay(hours: 9, minutes: 30)
//let end = TimeOfDay(hours: 11, minutes: 06)
//print("Duration: \(start.duration(to: end))")
//
//let startA = TimeOfDay(hours: 9, minutes: 30)
//let endA = TimeOfDay(hours: 10, minutes: 17)
//let startB = TimeOfDay(hours: 10, minutes: 21)
//let endB = TimeOfDay(hours: 11, minutes: 06)
//
//print("A: \(startA.duration(to: endA)) / B: \(startB.duration(to: endB))")
//
//let startC = TimeOfDay(hours: 14, minutes: 05)
//let endC = TimeOfDay(hours: 14, minutes: 50)
//let startD = TimeOfDay(hours: 14, minutes: 54)
//let endD = TimeOfDay(hours: 15, minutes: 40)
//
//print("C: \(startC.duration(to: endC)) / D: \(startD.duration(to: endD))")
