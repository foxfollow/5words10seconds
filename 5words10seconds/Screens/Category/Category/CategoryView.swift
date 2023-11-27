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
        setupBackgroundRectangle()
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
        
        categoryLbl.textAlignment = .center
        categoryLbl.numberOfLines = 0
        
        descriptionLbl.font = .systemFont(ofSize: 20, weight: .medium)
        categoryLbl.font = .systemFont(ofSize: 25, weight: .bold)

        view.addSubview(descriptionLbl)
        view.addSubview(categoryLbl)
    }

    private func setupBackgroundRectangle() {
        backgroundRectangle.backgroundColor = .orange.withAlphaComponent(0.7)
        backgroundRectangle.layer.cornerRadius = 40
        view.addSubview(backgroundRectangle)
    }

    private func setupTimer() {
        timerView = TimerView(timerViewModel)
        view.addSubview(timerView)
    }

    private func addConstraints() {
        descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        categoryLbl.translatesAutoresizingMaskIntoConstraints = false
        timerView.translatesAutoresizingMaskIntoConstraints = false
        backgroundRectangle.translatesAutoresizingMaskIntoConstraints = false

        let sALG = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            descriptionLbl.topAnchor.constraint(equalTo: sALG.topAnchor, constant: 20),
            descriptionLbl.centerXAnchor.constraint(equalTo: sALG.centerXAnchor),


            categoryLbl.widthAnchor.constraint(equalTo: sALG.widthAnchor, constant: -120),
            categoryLbl.centerXAnchor.constraint(equalTo: sALG.centerXAnchor),
            categoryLbl.centerYAnchor.constraint(equalTo: sALG.centerYAnchor, constant: -60),
            
//            timerView.centerYAnchor.constraint(equalTo: sALG.centerYAnchor, constant: -1),
//            timerView.bottomAnchor.constraint(equalTo: sALG.bottomAnchor, constant: -50),
            timerView.centerXAnchor.constraint(equalTo: sALG.centerXAnchor),
            timerView.topAnchor.constraint(equalTo: backgroundRectangle.bottomAnchor, constant: 80 ),

            // Add constraints for the background rectangle
            backgroundRectangle.centerXAnchor.constraint(equalTo: categoryLbl.centerXAnchor),
            backgroundRectangle.centerYAnchor.constraint(equalTo: categoryLbl.centerYAnchor),
            backgroundRectangle.widthAnchor.constraint(equalTo: categoryLbl.widthAnchor, constant: 10),
            backgroundRectangle.heightAnchor.constraint(equalTo: backgroundRectangle.widthAnchor),

        ])
    }
}
