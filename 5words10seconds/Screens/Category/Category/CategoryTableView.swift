//
//  CategoryTableView.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 18.11.2023.
//

import UIKit

extension CategoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return categoryViewModel.teams.value.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")

        let nameLabel = createLabel(withText: categoryViewModel.teams.value[indexPath.row].name)
        cell.contentView.addSubview(nameLabel)

        let scoreLabel = createLabel(withText: "\(categoryViewModel.teams.value[indexPath.row].score)")
        cell.contentView.addSubview(scoreLabel)

        let plusButton = createButton(withTitle: "+1")
        plusButton.tag = indexPath.row
        plusButton.addTarget(self, action: #selector(plusButtonAction), for: .touchUpInside)
        cell.contentView.addSubview(plusButton)

        let minusButton = createButton(withTitle: "-1")
        minusButton.tag = indexPath.row
        minusButton.addTarget(self, action: #selector(minusButtonAction), for: .touchUpInside)
        cell.contentView.addSubview(minusButton)

        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 10),

            scoreLabel.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: minusButton.leadingAnchor, constant: -10),

            plusButton.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            plusButton.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -10),

            minusButton.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            minusButton.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: -10),
        ])

        return cell
    }

    func createLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    func createButton(withTitle title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

    @objc func plusButtonAction(sender: UIButton) {
        categoryViewModel.changeScore(isIncrement: true, index: sender.tag)
        print("Score for \(categoryViewModel.teams.value[sender.tag].name): \(categoryViewModel.teams.value[sender.tag].score)")
    }

    @objc func minusButtonAction(sender: UIButton) {
        categoryViewModel.changeScore(isIncrement: false, index: sender.tag)
//        categoryViewModel.teams.value[sender.tag].score -= 1
//        categoryViewModel.teams.value = categoryViewModel.teams.value
        print("Score for \(categoryViewModel.teams.value[sender.tag].name): \(categoryViewModel.teams.value[sender.tag].score)")
    }
}
