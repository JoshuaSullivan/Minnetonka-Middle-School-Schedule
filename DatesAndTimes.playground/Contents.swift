import Foundation


func dayOfWeek(for date: Date) -> Int {
    return Calendar.current.component(.weekday, from: date)
}

let now = dayOfWeek(for: Date())
let tomorrow = dayOfWeek(for: Date().addingTimeInterval(86400))
