//
//  TimeView.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 04.11.2023.
//

import UIKit

class TimerView: UILabel {
    var viewModel: TimerViewModel!
    private var observation: NSKeyValueObservation?

    init(_ viewModel: TimerViewModel) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        self.observation = viewModel.observe(\.timerValue, options: .new) { [weak self] viewModel, change in
            guard let newValue = change.newValue else { return }
            DispatchQueue.main.async {
                self?.text = "\(newValue)"
                if newValue == 0 {
                    // Timer reached zero, perform your action here
                    print("Timer reached zero")
                }
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
