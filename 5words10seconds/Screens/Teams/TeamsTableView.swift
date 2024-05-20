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
            self.tableView.snp.updateConstraints { make in
                make.height.equalTo(tableViewHeight)
            }

            // Check if addBtn is covering endBtn
            let isAddBtnCoveringEndBtn = tableView.frame.origin.y + tableViewHeight + addBtn.frame.height > endBtn.frame.origin.y
            if isAddBtnCoveringEndBtn {
                // If it is, make addBtn.bottom = endBtn.top
                addBtn.snp.remakeConstraints { make in
                    make.left.right.equalToSuperview()
                    make.bottom.equalTo(endBtn.snp.top)
                    make.height.equalTo(56)
                }
            } else {
                // If it's not, update the constraints of addBtn
                self.tableView.contentInset.bottom = 0
                addBtn.snp.remakeConstraints { make in
                    make.top.equalTo(tableView.snp.bottom)
                    make.left.right.equalToSuperview()
                    make.height.equalTo(56)
                }
            }

            DispatchQueue.main.async {
                self.view.layoutIfNeeded()

                if isAddBtnCoveringEndBtn {
                    // Decrease the bottom inset by the height of a row
                    self.tableView.contentInset.bottom = max(0, self.tableView.contentInset.bottom - self.tableView.rowHeight)
                }
            }
        }
    }
}
