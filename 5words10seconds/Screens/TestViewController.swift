//
//  TestViewController.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 28.11.2023.
//
// ViewController for testing sounds with textfield and button

import AudioToolbox
import UIKit

class TestViewController: UIViewController {
    let textField = UITextField()
    let button = UIButton()
    let plusButton = UIButton()
    let minusButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }

    private func setupSubviews() {
        view.backgroundColor = .white
        view.addSubview(textField)
        view.addSubview(button)
        view.addSubview(plusButton)
        view.addSubview(minusButton)

        textField.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        minusButton.translatesAutoresizingMaskIntoConstraints = false

        textField.backgroundColor = .gray
        button.backgroundColor = .darkGray
        plusButton.backgroundColor = .cyan
        minusButton.backgroundColor = .orange

        textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true

        button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 50).isActive = true
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true

        plusButton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 50).isActive = true
        plusButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        plusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        plusButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        minusButton.topAnchor.constraint(equalTo: plusButton.bottomAnchor, constant: 50).isActive = true
        minusButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        minusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        minusButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
    }

    @objc private func buttonTapped() {
        guard let text = textField.text else { print("no text"); return }
        if let number = Int(text) {
            AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(number), nil)
            print(number)
        }
    }

    // MARK: Plus button adds one to text, saving text and playing sound

    @objc private func plusButtonTapped() {
        guard let text = textField.text else { print("no text"); return }
        if let number = Int(text) {
            AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(number), nil)
            textField.text = String(number + 1)
            print(number)
        }
    }

    // MARK: Minus button subtracts one from text, saving text and playing sound

    @objc private func minusButtonTapped() {
        guard let text = textField.text else { print("no text"); return }
        if let number = Int(text) {
            AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(number), nil)
            textField.text = String(number - 1)
            print(number)
        }
    }
}
