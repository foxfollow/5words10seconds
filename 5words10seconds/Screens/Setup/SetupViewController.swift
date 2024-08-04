//
//  SetupViewController.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 20.05.2024.
//

import UIKit

class SetupViewController: RootViewController {
    
    let howToPlayButton = AditionalButton()
    let feedbackButton = AditionalButton()
    let donateButton = AditionalButton()
    
    let hintLangugeTtl = UILabel()
    let languagePicker = UIPickerView()
    
    let setupViewModel = SetupViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupButtons()
        setupsSubviews() // in SetupView.swift
        setupLanguagePicker() // in SetupLanguagePickerView.swift
        
        addConstraints() // in SetupView.swift
    }
    
    private func setupButtons() {
        howToPlayButton.addTarget(self, action: #selector(howToPlayButtonTapped), for: .touchUpInside)
        feedbackButton.addTarget(self, action: #selector(feedbackButtonTapped), for: .touchUpInside)
    }
    
    @objc private func howToPlayButtonTapped() {
        let vc = HowToPlayViewController()
        self.navigationController?.present(vc, animated: true)
    }
    
    @objc private func feedbackButtonTapped() {
        let vc = FeedbackViewController()
        self.navigationController?.present(vc, animated: true)
    }
    
}
