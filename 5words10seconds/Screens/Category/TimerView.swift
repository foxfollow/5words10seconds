//
//  TimerView.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 04.11.2023.
//

import UIKit

class TimerView: UIView {
    var viewModel: TimerViewModel!
    let circle = UIView()
    let label = UILabel()

    init(_ viewModel: TimerViewModel) {
        super.init(frame: .zero)
        self.viewModel = viewModel

        setupCircle()
        setupTimer()
        addConstraints()

        viewModel.timerValue.bind { [weak self] newValue in
            DispatchQueue.main.async {
                self?.label.text = "\(newValue)"
            }
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("TimerView deinitialized")
    }
}

// MARK: - Setup subviews

extension TimerView {
    private func setupCircle() {
        circle.backgroundColor = .orange
        circle.layer.cornerRadius = 50
        circle.layer.masksToBounds = true
        circle.layer.borderWidth = 2
        circle.layer.borderColor = UIColor.black.cgColor
        addSubview(circle)
    }

    private func setupTimer() {
        label.text = "\(viewModel.timerValue.value)"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        addSubview(label)
    }

    private func addConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        circle.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            circle.centerXAnchor.constraint(equalTo: centerXAnchor),
            circle.centerYAnchor.constraint(equalTo: centerYAnchor),
            circle.widthAnchor.constraint(equalToConstant: 120),
            circle.heightAnchor.constraint(equalToConstant: 120),

            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
