//
//  SetupView.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 20.05.2024.
//

import UIKit
import SnapKit

extension SetupViewController {
    
    func setupsSubviews() {
        setupFeedbacks()
        setupHowToPlay()
        setupPickerSubviews()
    }
    
    private func setupFeedbacks() {
        feedbackButton.setTitle(String(localized: "Feedback"), for: .normal)
        feedbackButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        feedbackButton.setTitleColor(AppAssetsConfigs.Colors.textMain, for: .normal)
        feedbackButton.backgroundColor = AppAssetsConfigs.Colors.cellBackground
        feedbackButton.layer.cornerRadius = 16
        feedbackButton.clipsToBounds = true
        
        view.addSubview(feedbackButton)
    }
    
    private func setupHowToPlay() {
        howToPlayButton.setTitle(String(localized: "How to play title"), for: .normal)
        howToPlayButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        howToPlayButton.setTitleColor(AppAssetsConfigs.Colors.textMain, for: .normal)
        howToPlayButton.backgroundColor = AppAssetsConfigs.Colors.cellBackground
        howToPlayButton.layer.cornerRadius = 16
        howToPlayButton.clipsToBounds = true
        
        view.addSubview(howToPlayButton)
    }

    
    private func setupPickerSubviews() {
        hintLangugeTtl.text = "Please reload App to apply changes"
        hintLangugeTtl.numberOfLines = 0
        hintLangugeTtl.font = UIFont.systemFont(ofSize: 20)
        hintLangugeTtl.textAlignment = .center
        hintLangugeTtl.textColor = AppAssetsConfigs.Colors.textMain
        hintLangugeTtl.backgroundColor = AppAssetsConfigs.Colors.cellBackground
        hintLangugeTtl.layer.cornerRadius = 16
        hintLangugeTtl.clipsToBounds = true
        hintLangugeTtl.isHidden = true
        
        view.addSubview(hintLangugeTtl)
        view.addSubview(languagePicker)
        
    }
    
    func addConstraints() {
        let padding: CGFloat = 20
        
        howToPlayButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(padding)
            make.height.equalTo(50)
            make.trailing.leading.equalToSuperview().inset(padding)
        }
        
        feedbackButton.snp.makeConstraints { make in
            make.top.equalTo(howToPlayButton.snp.bottom).offset(padding)
            make.height.equalTo(50)
            make.trailing.leading.equalToSuperview().inset(padding)
        }
        
        languagePicker.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-padding)
        }
        
        hintLangugeTtl.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(padding)
            make.right.equalToSuperview().offset(-padding)
            make.bottom.equalTo(languagePicker.snp.top).offset(16)
        }
    }
}
