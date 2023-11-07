//
//  PopupViewsFuncs.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 06.11.2023.
//

import UIKit

extension CategoryViewController {
    
    private func listTeamsPopup() {
        let popupViewController = PopupTeamsViewController(teams: generatePopupVM())
        popupViewController.modalPresentationStyle = .overCurrentContext
        present(popupViewController, animated: true, completion: nil)
    }
    
    private func generatePopupVM() -> [PopupTeamsViewModel]{
        var list = [PopupTeamsViewModel]()
        for team in categoryViewModel.teams.value {
            let popupVM = PopupTeamsViewModel(team: team)
            list.append(popupVM)
        }
        return list
    }
    
//    func listTeamsPopup() {
//        let alert = UIAlertController(title: "Teams", message: "", preferredStyle: .alert)
//        
//        alert.addAction(UIAlertAction(title: "Continue", style: .cancel, handler: {(_) in
//            self.isReadyPopup()
////            categoryViewModel.teams // TODO: add tracking a team, change team and to the
//        }))
//        
//        self.present(alert, animated: true, completion: nil)
//    }
    
    // TODO: make func to get currentCtgr with popup windows
    func isReadyPopup() {
        // TODO: add value current team and track it, if nil current = teams[0]
        let alertController = UIAlertController(title: "Is team \(categoryViewModel.teams.value[0].name)", // TODO: track the team
                                                message: "Your turn, it starts immidiatly after your press",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ready", style: .default, handler: {_ in
            self.categoryViewModel.fetchCategory()
            self.timerViewModel.timerValue.value = 10
            self.timerViewModel.setupTimer()
        }))
        
        alertController.addAction(UIAlertAction(title: "Change teams score", style: .default, handler: { _ in
            self.listTeamsPopup()
            self.isReadyPopup()
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func timerEndPopup() {  // TODO: add +1 to team score; if true ask if next team ready
        let alertController = UIAlertController(title: "Timer Ended",
                                                message: "Is the team get + 1 point to score",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: {_ in
            self.categoryViewModel.currentCtgr.value = nil
            self.categoryViewModel.currentTeam.value?.score += 1 // TODO: Check if it works
            self.isReadyPopup()
        }))
        alertController.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
        
    }
    
}
