//
//  TeamsCellViewModel.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 20.11.2023.
//

import UIKit

import Foundation

protocol TeamsCellViewModelDelegate: AnyObject {
    func deleteButtonTapped(at indexPath: IndexPath)
}

class TeamsCellViewModel {
    var team: TeamModel
    weak var delegate: TeamsCellViewModelDelegate?

    init(team: TeamModel) {
        self.team = team
    }

    var name: String {
        return team.name
    }

    func deleteButtonTapped(at indexPath: IndexPath) {
        delegate?.deleteButtonTapped(at: indexPath)
    }

}
