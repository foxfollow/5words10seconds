//
//  SetupView.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 20.05.2024.
//

import UIKit
import SnapKit

extension SetupViewController {
    
    func setupPickerSubviews() {
        hintLangugeTtl.text = "Please reload App to apply changes"
        hintLangugeTtl.numberOfLines = 0
        hintLangugeTtl.font = UIFont.systemFont(ofSize: 20)
        hintLangugeTtl.textAlignment = .center
        hintLangugeTtl.textColor = AppAssetsConfigs.Colors.textMain
        hintLangugeTtl.backgroundColor = AppAssetsConfigs.Colors.cellBackground
        hintLangugeTtl.layer.cornerRadius = 8
        hintLangugeTtl.clipsToBounds = true
        hintLangugeTtl.isHidden = true
        
        view.addSubview(hintLangugeTtl)
        view.addSubview(languagePicker)
        
        addConstraints()
    }
    
    private func addConstraints() {
        let padding: CGFloat = 20
        
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
