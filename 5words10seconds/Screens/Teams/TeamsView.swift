//
//  TeamsView.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 30.10.2023.
//

import UIKit

extension TeamsViewController {
    func setupSubviews() {
        setupBackgroundView()
        setupTableView()
        setupLabels()
        setupButtons()
        addConstraints()
    }

    private func setupBackgroundView() {
        title = "Teams"
        view.backgroundColor = .lightGray
    }

    // MARK: TableView

    private func setupTableView() {
        tableView.backgroundColor = #colorLiteral(red: 0.7862124443, green: 0.9268439412, blue: 1, alpha: 1)
        tableView.rowHeight = 56
        view.addSubview(tableView)
    }

    // MARK: Labels

    private func setupLabels() {
        descriptionLbl.text = "Double tab a team name to change it, press and hold to enter a team name"
        view.addSubview(descriptionLbl)
    }

    // MARK: Buttons

    private func setupButtons() {
        addBtn.setTitle("Add new", for: .normal)
        addBtn.backgroundColor = .systemOrange
        endBtn.setTitle("Next", for: .normal)
        endBtn.backgroundColor = .systemOrange

        view.addSubview(addBtn)
        view.addSubview(endBtn)
    }

    // MARK: Constraints

    private func addConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addBtn.translatesAutoresizingMaskIntoConstraints = false
        endBtn.translatesAutoresizingMaskIntoConstraints = false

        let sALG = view.safeAreaLayoutGuide
        tableViewHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: tableViewHeight)
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: sALG.topAnchor),
            tableViewHeightConstraint!, // Use the constraint variable here

            addBtn.leftAnchor.constraint(equalTo: view.leftAnchor),
            addBtn.rightAnchor.constraint(equalTo: view.rightAnchor),
            addBtn.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            addBtn.heightAnchor.constraint(equalToConstant: 50),

            endBtn.leftAnchor.constraint(equalTo: view.leftAnchor),
            endBtn.rightAnchor.constraint(equalTo: view.rightAnchor),
            endBtn.bottomAnchor.constraint(equalTo: sALG.bottomAnchor),
            endBtn.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
