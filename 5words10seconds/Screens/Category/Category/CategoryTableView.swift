//
//  CategoryTableView.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 18.11.2023.
//

import UIKit

extension CategoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryViewModel.teams.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        let nameLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 100, height: 30))
        nameLabel.text = categoryViewModel.teams.value[indexPath.row].name
        cell.addSubview(nameLabel)
        
        let scoreLabel = UILabel(frame: CGRect(x: 120, y: 10, width: 50, height: 30))
        scoreLabel.text = "\(categoryViewModel.teams.value[indexPath.row].score)" // TODO: doesn't working in class
        cell.addSubview(scoreLabel)
        // remake minusButton and plusButton for less code
        
        let plusButton = UIButton(frame: CGRect(x: 180, y: 10, width: 30, height: 30))
        plusButton.setTitle("+1", for: .normal)
        plusButton.setTitleColor(.blue, for: .normal)
        plusButton.tag = indexPath.row
        plusButton.addTarget(self, action: #selector(plusButtonAction), for: .touchUpInside)
//        cell.addSubview(plusButton)
        
        let minusButton = UIButton(frame: CGRect(x: 220, y: 10, width: 30, height: 30))
        minusButton.setTitle("-1", for: .normal)
        minusButton.setTitleColor(.blue, for: .normal)
        minusButton.tag = indexPath.row
        minusButton.addTarget(self, action: #selector(minusButtonAction), for: .touchUpInside)
//        cell.addSubview(minusButton)
        
        cell.contentView.addSubview(plusButton)
        cell.contentView.addSubview(minusButton)
        
        
        return cell
    }
    
    @objc func plusButtonAction(sender: UIButton!) {
        categoryViewModel.teams.value[sender.tag].score += 1
        print("Score for \(categoryViewModel.teams.value[sender.tag].name): \(categoryViewModel.teams.value[sender.tag].score)")
    }
    
    @objc func minusButtonAction(sender: UIButton!) {
        categoryViewModel.teams.value[sender.tag].score -= 1
        print("Score for \(categoryViewModel.teams.value[sender.tag].name): \(categoryViewModel.teams.value[sender.tag].score)")
    }
}

