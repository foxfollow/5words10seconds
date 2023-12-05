//
//  MenuView.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 30.10.2023.
//

import UIKit


extension MenuViewController {
    
    
    func setupSubviews() {
        setupBackgroundView()
        setupButtonsView()
        setupPickerSubviews()
        
        addButtonConstraints()
    }
    
    private func setupBackgroundView() {
        title = "Menu"
        view.backgroundColor = .lightGray

    }
    
    // MARK: Menu buttons
    private func setupButtonsView() {
        game5w10sBtn.setTitle(String(localized: "Start 5words10sec"), for: .normal)
        game3w5sBtn.setTitle(String(localized: "Start 3words5sec") + "\nSorry, did released yet", for: .normal)
        testBtn.setTitle("go to test sounds", for: .normal)
        testBtn.isHidden = true
        
        game5w10sBtn.setTitleColor(.orange, for: .normal)
        game3w5sBtn.setTitleColor(.orange, for: .normal)
        game5w10sBtn.setTitleColor(.red, for: .highlighted)
        testBtn.setTitleColor(.white, for: .normal)
        game5w10sBtn.titleLabel?.numberOfLines = 2
        game3w5sBtn.titleLabel?.numberOfLines = 2
        game5w10sBtn.backgroundColor = .darkGray
        game3w5sBtn.backgroundColor = .darkGray
        game5w10sBtn.layer.cornerRadius = 16
        game3w5sBtn.layer.cornerRadius = 16
        
        view.addSubview(game5w10sBtn)
        view.addSubview(game3w5sBtn)
        view.addSubview(testBtn)
        
    }
    
    private func setupPickerSubviews() {
        hintLangugeTtl.text = "Please reload App to apply changes"
        hintLangugeTtl.numberOfLines = 0
        hintLangugeTtl.font = UIFont.systemFont(ofSize: 20)
        hintLangugeTtl.textAlignment = .center
        hintLangugeTtl.textColor = .orange
        hintLangugeTtl.backgroundColor = .darkGray
        hintLangugeTtl.layer.cornerRadius = 8
        hintLangugeTtl.clipsToBounds = true
        hintLangugeTtl.isHidden = true
        
        view.addSubview(hintLangugeTtl)
        view.addSubview(languagePicker)
    }
    
    private func addButtonConstraints() {
        game5w10sBtn.translatesAutoresizingMaskIntoConstraints = false
        game3w5sBtn.translatesAutoresizingMaskIntoConstraints = false
        testBtn.translatesAutoresizingMaskIntoConstraints = false
        languagePicker.translatesAutoresizingMaskIntoConstraints = false
        hintLangugeTtl.translatesAutoresizingMaskIntoConstraints = false
        
        let sALG = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            game5w10sBtn.heightAnchor.constraint(equalToConstant: 100),
            game5w10sBtn.leftAnchor.constraint(equalTo: sALG.leftAnchor, constant: 20),
            game5w10sBtn.rightAnchor.constraint(equalTo: sALG.rightAnchor, constant: -20),
            game5w10sBtn.topAnchor.constraint(equalTo: sALG.topAnchor, constant: 20),
            
            game3w5sBtn.heightAnchor.constraint(equalTo: game5w10sBtn.heightAnchor),
            game3w5sBtn.leftAnchor.constraint(equalTo: game5w10sBtn.leftAnchor),
            game3w5sBtn.rightAnchor.constraint(equalTo: game5w10sBtn.rightAnchor),
            game3w5sBtn.topAnchor.constraint(equalTo: game5w10sBtn.bottomAnchor, constant: 20),
            
            testBtn.heightAnchor.constraint(equalTo: game5w10sBtn.heightAnchor),
            testBtn.leftAnchor.constraint(equalTo: game5w10sBtn.leftAnchor),
            testBtn.rightAnchor.constraint(equalTo: game5w10sBtn.rightAnchor),
            testBtn.topAnchor.constraint(equalTo: game3w5sBtn.bottomAnchor, constant: 20),
            
            languagePicker.leadingAnchor.constraint(equalTo: sALG.leadingAnchor),
            languagePicker.trailingAnchor.constraint(equalTo: sALG.trailingAnchor),
            languagePicker.bottomAnchor.constraint(equalTo: sALG.bottomAnchor, constant: -20),
            
            hintLangugeTtl.leftAnchor.constraint(equalTo: sALG.leftAnchor, constant: 20),
            hintLangugeTtl.rightAnchor.constraint(equalTo: sALG.rightAnchor, constant: -20),
//            hintLangugeTtl.centerXAnchor.constraint(equalTo: languagePicker.centerXAnchor),
            hintLangugeTtl.bottomAnchor.constraint(equalTo: languagePicker.topAnchor, constant: 16),
            
        ])
    }
}
