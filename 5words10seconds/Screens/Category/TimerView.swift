//
//  TimeView.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 04.11.2023.
//

import UIKit

class TimerView: UILabel {
    var viewModel: TimerViewModel!

    init(_ viewModel: TimerViewModel) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        
        viewModel.timerValue.bind { [weak self] newValue in
            DispatchQueue.main.async {
                self?.text = "\(newValue)"
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
