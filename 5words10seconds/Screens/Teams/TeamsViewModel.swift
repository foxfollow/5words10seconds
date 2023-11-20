//
//  TeamsViewModel.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 02.11.2023.
//

import Foundation

class TeamsViewModel {
    weak var delegate: TeamsCellViewModelDelegate?

    // var teamsCount: ObservableObject<Int> = ObservableObject(nil)
    var cellViewModels: ObservableObject<[TeamsCellViewModel]?> = ObservableObject(nil)
    var dataSourceTeams: [TeamModel]? {
        didSet {
            guard let dataSourceTeams = dataSourceTeams else { return }
            // let teamsCount = dataSourceTeams.count
            cellViewModels.value = dataSourceTeams.enumerated().map { _, team in
                let viewModel = TeamsCellViewModel(team: team)
                viewModel.delegate = delegate
//                viewModel.indexPath = IndexPath(row: index, section: 0)
                return viewModel
            }
            reloadTableView?()
        }
    }

    var reloadTableView: (() -> Void)?

    func deleteTeam(at indexPath: IndexPath) {
        // Remove the team from the data source
        
        guard var cellViewModels = cellViewModels.value else { return }
        if cellViewModels.count > 1 {
            cellViewModels.remove(at: indexPath.row)
            self.cellViewModels.value = cellViewModels
            
            // Refresh the table view
            reloadTableView?()
        }
    }

    func numberOfRows() -> Int {
        cellViewModels.value?.count ?? 0
    }

    func fetchTeams() {
        Service.shared.fetchTeams { [weak self] result in
            switch result {
            case let .success(data):
                self?.dataSourceTeams = data
            case let .failure(error):
                print(error)
            }
        }
    }
}
