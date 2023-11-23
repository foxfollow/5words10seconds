//
//  TeamsViewModel.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 02.11.2023.
//

import Foundation

class TeamsViewModel {
    weak var delegate: TeamsCellViewModelDelegate?

    private var allTeams: Set<TeamModel> = []

    var cellViewModels: ObservableObject<[TeamsCellViewModel]?> = ObservableObject(nil)
    var dataSourceTeams: [TeamModel]? {
        didSet {
            guard let dataSourceTeams = dataSourceTeams else { return }
            cellViewModels.value = dataSourceTeams.enumerated().map { _, team in
                let viewModel = TeamsCellViewModel(team: team)
                viewModel.delegate = delegate
                return viewModel
            }
            reloadTableView?()
        }
    }

    var reloadTableView: (() -> Void)?

    func deleteTeam(at indexPath: IndexPath) {
        guard var dataSourceTeams = dataSourceTeams, dataSourceTeams.count > 1 else { return }
        dataSourceTeams.remove(at: indexPath.row)
        self.dataSourceTeams = dataSourceTeams
        reloadTableView?()
    }

    func numberOfRows() -> Int {
        cellViewModels.value?.count ?? 0
    }

    func fetchTeams() {
        Service.shared.fetchTeams { [weak self] result in
            switch result {
            case let .success(data):
                self?.allTeams = Set(data)
                self?.dataSourceTeams = Array(data.shuffled().prefix(2))
            case let .failure(error):
                print(error)
            }
        }
    }

    func addNewTeam() {
        let difference = allTeams.subtracting(dataSourceTeams ?? [])
        if let team = difference.first {
            dataSourceTeams?.append(team)
        }
    }
}
