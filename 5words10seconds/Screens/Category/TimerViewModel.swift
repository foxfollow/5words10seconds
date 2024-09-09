//
//  TimeViewModel.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 04.11.2023.
//

import Foundation

class TimerViewModel {
    var timerValue = ObservableObjectCustom<Int>(0)
    var timerDidEnd = ObservableObjectCustom<Bool>(true)

    private var timer: Timer?

    
    func setupTimer() {
        timerDidEnd.value = false
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    @objc private func updateTimer() {
        if timerValue.value > 0 {
            timerValue.value -= 1
        } else {
            timer?.invalidate()
            timer = nil
            self.timerDidEnd.value = true
        }
    }
}
