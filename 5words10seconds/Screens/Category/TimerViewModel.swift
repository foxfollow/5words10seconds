//
//  TimeViewModel.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 04.11.2023.
//

import Foundation

class TimerViewModel: NSObject {
    var timerValue = ObservableObject<Int>(0)
    var timerDidEnd = ObservableObject<Bool>(true)

    private var timer: Timer?

    
    func setupTimer() {
        timerDidEnd.value = false
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    @objc private func updateTimer() {
        if timerValue.value > 0 {
            timerValue.value -= 1
            print("timer val in viewmodel is: \(timerValue.value)")
        } else {
            print("Timer ended")
            timer?.invalidate()
            timer = nil
            self.timerDidEnd.value = true
            print("timerDidEnd value: \(self.timerDidEnd.value)") // Add this line

        }
    }
}
