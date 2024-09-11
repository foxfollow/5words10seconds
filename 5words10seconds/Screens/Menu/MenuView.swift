//
//  MenuView.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 30.10.2023.
//

import UIKit
import SnapKit

extension MenuViewController {
    
    
    func setupSubviews() {
        setupBackgroundView()
        setupButtonsView()
        
        addButtonConstraints()
    }
    
    private func setupBackgroundView() {
        title = "Game"
        
        backgroundViewUpper.backgroundColor = .purple
        backgroundViewLower.backgroundColor = .purple
        view.addSubview(backgroundViewUpper)
        view.addSubview(backgroundViewLower)
        
    }
    
    // MARK: Menu buttons
    private func setupButtonsView() {
        game5w10sBtn.setTitle(String(localized: "Start 5words10sec"), for: .normal)
        game3w5sBtn.setTitle(String(localized: "Start 3words5sec") + "\n" + String(localized: "Doesn't work yet (in dev)"), for: .normal)
        
        game5w10sBtn.titleLabel?.textAlignment = .center
        game3w5sBtn.titleLabel?.textAlignment = .center
        game5w10sBtn.setTitleColor(AppAssetsConfigs.Colors.textMain, for: .normal)
        game3w5sBtn.setTitleColor(AppAssetsConfigs.Colors.textMain, for: .normal)
        game5w10sBtn.setTitleColor(.purple, for: .highlighted)
        game5w10sBtn.titleLabel?.numberOfLines = 3
        game3w5sBtn.titleLabel?.numberOfLines = 3
        game5w10sBtn.backgroundColor = AppAssetsConfigs.Colors.cellBackground
        game3w5sBtn.backgroundColor = AppAssetsConfigs.Colors.cellBackground
        game5w10sBtn.layer.cornerRadius = 16
        game3w5sBtn.layer.cornerRadius = 16
        
        view.addSubview(game5w10sBtn)
        view.addSubview(game3w5sBtn)
        
    }
    

    private func addButtonConstraints() {
        let padding: CGFloat = 20

        game5w10sBtn.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.left.equalToSuperview().offset(padding)
            make.right.equalToSuperview().offset(-padding)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(padding)
        }

        game3w5sBtn.snp.makeConstraints { make in
            make.height.equalTo(game5w10sBtn.snp.height)
            make.left.right.equalTo(game5w10sBtn)
            make.top.equalTo(game5w10sBtn.snp.bottom).offset(padding)
        }

    }
}
