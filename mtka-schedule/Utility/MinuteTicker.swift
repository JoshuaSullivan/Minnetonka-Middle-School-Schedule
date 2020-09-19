import Foundation
import Combine

final class MinuteTicker {
    static let shared = MinuteTicker()

    var ticker: AnyPublisher<TimeOfDay, Never> {
        return $currentTime
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    @Published private var currentTime: TimeOfDay = Date().timeOfDay

    private var timer: Timer = Timer()

    private init(mockTime: TimeOfDay? = nil) {
        if let mockTime = mockTime {
            currentTime = mockTime
        } else {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: handleTimerTick)
        }
    }

    deinit {
        timer.invalidate()
    }

    private func handleTimerTick(_ timer: Timer) {
        let time = Date().timeOfDay
        if time != currentTime {
            currentTime = time
        }
    }
}

extension MinuteTicker {
    static func staticMock(with time: TimeOfDay) -> MinuteTicker {
        return MinuteTicker(mockTime: time)
    }
}
