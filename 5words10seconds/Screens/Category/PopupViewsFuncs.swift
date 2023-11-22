//
//  PopupViewsFuncs.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 06.11.2023.
//

import UIKit

extension CategoryViewController {
    

    private func listTeamsTableViewPopup(_ teamsCount: Int) {
        let alert = UIAlertController(title: "Teams",
                                      message: String(repeating: "\n\n\n", count: teamsCount),
                                      preferredStyle: .alert)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        alert.view.autoresizesSubviews = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false

        alert.view.addSubview(tableView)
        
        let action = UIAlertAction(title: "Close", style: .cancel, handler: { _ in
            self.isReadyPopup()
        })
        alert.addAction(action)
        
        tableView.leftAnchor.constraint(equalTo: alert.view.leftAnchor, constant: 8).isActive = true
        tableView.rightAnchor.constraint(equalTo: alert.view.rightAnchor, constant: -8).isActive = true
        tableView.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 50).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: CGFloat(44 * teamsCount)).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor, constant: -50).isActive = true
//
        self.present(alert, animated: true, completion: nil)
    }
    
    // TODO: make func to get currentCtgr with popup windows
    func isReadyPopup() {
        // TODO: add value current team and track it, if nil current = teams[0]
        if categoryViewModel.currentTeam.value == nil {
            categoryViewModel.fetchCurrentTeam()
        }
        let alertController = UIAlertController(title: "Is team \(categoryViewModel.currentTeam.value?.name ?? "No tracking team")",
                                                message: "Your turn, it starts immidiatly after your press",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ready", style: .default, handler: {_ in
            self.categoryViewModel.fetchCategory()
            self.timerViewModel.timerValue.value = 10
            self.timerViewModel.setupTimer()
        }))
        
        alertController.addAction(UIAlertAction(title: "Change teams score", style: .default, handler: { _ in
            self.listTeamsTableViewPopup(self.categoryViewModel.teams.value.count)
            self.isReadyPopup()
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func timerEndPopup() { 
        let alertController = UIAlertController(title: "Timer Ended",
                                                message: "Is the team \(categoryViewModel.currentTeam.value?.name ?? "No tracking team") get + 1 point to score",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: {_ in
            self.categoryViewModel.currentCtgr.value = nil
            self.categoryViewModel.currentTeam.value?.score += 1 // TODO: currentTeam is n't a link value, fix it
            self.categoryViewModel.fetchCurrentTeam()
            self.isReadyPopup()
        }))
        alertController.addAction(UIAlertAction(title: "No", style: .cancel, handler: {_ in
            self.categoryViewModel.currentCtgr.value = nil
//            self.categoryViewModel.currentTeam.value?.score -= 1
            self.categoryViewModel.fetchCurrentTeam()
            self.isReadyPopup()

        }))
        self.present(alertController, animated: true, completion: nil)
        
    }
    
}
