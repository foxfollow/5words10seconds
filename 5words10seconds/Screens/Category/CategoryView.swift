//
//  CategoryView.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 04.11.2023.
//

import UIKit

extension CategoryViewController {
    
    func setupSubviews() {
        initView()
        setupLabels()
        setupTimer()

        addConstraints()
    }
    
    private func initView() {
        title = "Teams"
        view.backgroundColor = .lightGray
    }
    
    private func setupLabels() {
        descriptionLbl.text = "Tell 5 words related to"
        categoryLbl.text = "Board Games"
        
        view.addSubview(descriptionLbl)
        view.addSubview(categoryLbl)

    }
    
    private func setupTimer() {
        timerView = TimerView(timerViewModel)
        view.addSubview(timerView)
    }

    
    private func addConstraints() {
        descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        categoryLbl.translatesAutoresizingMaskIntoConstraints = false
        timerView.translatesAutoresizingMaskIntoConstraints = false
        
        let sALG = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            descriptionLbl.topAnchor.constraint(equalTo: sALG.topAnchor, constant: 20),
            descriptionLbl.centerXAnchor.constraint(equalTo: sALG.centerXAnchor),
            
            categoryLbl.centerXAnchor.constraint(equalTo: sALG.centerXAnchor),
            categoryLbl.centerYAnchor.constraint(equalTo: sALG.centerYAnchor, constant: -60),
            
            timerView.centerYAnchor.constraint(equalTo: sALG.centerYAnchor, constant: -1),
//            timerView.bottomAnchor.constraint(equalTo: sALG.bottomAnchor, constant: -50),
            timerView.centerXAnchor.constraint(equalTo: sALG.centerXAnchor),
          
        ])
    }
}
