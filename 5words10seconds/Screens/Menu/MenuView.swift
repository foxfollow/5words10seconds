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
    }
    
    private func setupBackgroundView() {
        title = "Menu"
        view.backgroundColor = .lightGray
    }
    
    // MARK: Menu buttons
    private func setupButtonsView() {
        game5w10sBtn.setTitle("Start \"5 words 10 seconds game\"", for: .normal)
        game3w5sBtn.setTitle("Start \"3 words 5 seconds game\"\nSorry, did released yet", for: .normal)
        
        game5w10sBtn.setTitleColor(.white, for: .normal)
        game3w5sBtn.setTitleColor(.white, for: .normal)
        game5w10sBtn.titleLabel?.numberOfLines = 2
        game3w5sBtn.titleLabel?.numberOfLines = 2
        game5w10sBtn.backgroundColor = .darkGray
        game3w5sBtn.backgroundColor = .darkGray
        game5w10sBtn.layer.cornerRadius = 16
        game3w5sBtn.layer.cornerRadius = 16
                
        view.addSubview(game5w10sBtn)
        view.addSubview(game3w5sBtn)
        
        addButtonConstraints()
    }
    
    private func addButtonConstraints() {
        game5w10sBtn.translatesAutoresizingMaskIntoConstraints = false
        game3w5sBtn.translatesAutoresizingMaskIntoConstraints = false
        
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
        ])
    }
}
