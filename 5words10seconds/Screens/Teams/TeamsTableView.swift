//
//  TeamsTableView.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 02.11.2023.
//

import UIKit

extension TeamsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamsViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellsIdentifiers.TeamsCellView.rawValue,
            for: indexPath
        ) as! TeamsCellView
        let cellVM = teamsViewModel.getCellViewModel(at: indexPath)
//        cell.cellViewModel = cellVM
        cell.teamNameLbl.text = cellVM.name

        return cell
    }
}

// MARK: Set dataSource\delegate; register cell
extension TeamsViewController: UITableViewDelegate {
    func setupTableViewData() {
        tableView.register(TeamsCellView.self, forCellReuseIdentifier: cellsIdentifiers.TeamsCellView.rawValue)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

