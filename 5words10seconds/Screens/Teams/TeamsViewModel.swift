//
//  TeamsViewModel.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 02.11.2023.
//

import Foundation

class TeamsViewModel {
    
    var cellDataSourceTeams: ObservableObject<[TeamModel]?> = ObservableObject(nil)
    var dataSourceTeams: [TeamModel]? {
        didSet {
            reloadTableView?()
        }
    }
    
    var reloadTableView: (() -> Void)?
    
    func numberOfRows() -> Int {
        dataSourceTeams?.count ?? 0
    }
    
    func fetchTeams() {
        Service.shared.fetchTeams { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.dataSourceTeams = data
            case .failure(let err):
                print(err.localizedDescription)
                // maybe: complition(nil, err.localizedDescription)
            }
        }
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> TeamModel {
        guard let dataSourceTeams else { return TeamModel(name: "", score: 0)}
        return dataSourceTeams[indexPath.row]
    }
}
