//
//  TeamsTableView.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 02.11.2023.
//

import UIKit

extension TeamsViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return teamsViewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamsCellView", for: indexPath) as! TeamsCellView
        cell.cellViewModel = teamsViewModel.cellViewModels.value?[indexPath.row]
        cell.selectionStyle = .none // Disable cell selection
        cell.indexPath = indexPath
        cell.delegate = self // Set the delegate to self
        cell.bind(to: teamsViewModel) // Bind the cell to the teamsViewModel for counting teams and changing color
        return cell
    }
}

// MARK: Set dataSource\delegate; register cell

extension TeamsViewController: UITableViewDelegate {
    func setupTableViewData() {
        tableView.register(TeamsCellView.self, forCellReuseIdentifier: cellsIdentifiers.TeamsCellView.rawValue)
        tableView.dataSource = self
        tableView.delegate = self

        teamsViewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                print("Reload tableview")
                self?.tableView.reloadData()
            }
        }

        teamsViewModel.fetchTeams()
    }
}

extension TeamsViewController: TeamsCellViewModelDelegate {
    func deleteButtonTapped(at indexPath: IndexPath) {

        if let count = teamsViewModel.dataSourceTeams?.count, count > 1 {
            // Decrease the height of the table view by the height of one row
            self.teamsViewModel.deleteTeam(at: indexPath)

            self.tableViewHeight = CGFloat(count - 1) * 56

            // Update the height constraint of the table view
            self.tableViewHeightConstraint?.constant = self.tableViewHeight
            DispatchQueue.main.async {
                self.view.layoutIfNeeded()
            }
        }
    }
}
