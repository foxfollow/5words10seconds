//
//  TimeViewModel.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 04.11.2023.
//

import Foundation

class TimerViewModel: NSObject {
    @objc dynamic var timerValue: Int = 10
    private var timer: Timer?

    override init() {
        super.init()
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    @objc private func updateTimer() {
        if timerValue > 0 {
            timerValue -= 1
        } else {
            timer?.invalidate()
            timer = nil
        }
    }
}
