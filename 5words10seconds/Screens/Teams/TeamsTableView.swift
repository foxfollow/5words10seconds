//
//  TeamsTableView.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 02.11.2023.
//

import UIKit
// TODO: make a function for existsing button to add team to tableview from viewmodel (viewmodel gets new values from service)
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
        teamsViewModel.deleteTeam(at: indexPath)
    }
}
