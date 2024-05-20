//
//  PopupViewsFuncs.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 06.11.2023.
//

import UIKit

extension CategoryViewController {
    

    private func listTeamsTableViewPopup(_ teamsCount: Int) {
//        let alert = UIAlertController(title: String(localized: "Teams"),
//                                      message: String(repeating: "\n\n\n", count: teamsCount),
//                                      preferredStyle: .alert)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        alert.view.autoresizesSubviews = true
//        
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.allowsSelection = false
//
//        alert.view.addSubview(tableView)
//        
//        let action = UIAlertAction(title: "Close", style: .cancel, handler: { _ in
//            self.isReadyPopup()
//        })
//        alert.addAction(action)
//        
//        tableView.leftAnchor.constraint(equalTo: alert.view.leftAnchor, constant: 8).isActive = true
//        tableView.rightAnchor.constraint(equalTo: alert.view.rightAnchor, constant: -8).isActive = true
//        tableView.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 50).isActive = true
//        tableView.heightAnchor.constraint(equalToConstant: CGFloat(44 * teamsCount)).isActive = true
////        tableView.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor, constant: -50).isActive = true
////
//        self.present(alert, animated: true, completion: nil)
        
        if categoryViewModel.currentTeam.value == nil {
            categoryViewModel.fetchCurrentTeam()
        }
        // Alert
        let overlayView = BlurOverlayFactorView(frame: self.tabBarController?.view.bounds ?? self.view.bounds)
        self.tabBarController?.view.addSubview(overlayView) ?? self.view.addSubview(overlayView)
        
        alertCollectionView = AlertCollectionView(frame: CGRect(x: 0, y: 0, width: 350, height: 160), caterogyViewModel: self.categoryViewModel)
        guard let alertView = alertCollectionView else { return }
        alertView.overlayView = overlayView
        alertView.center = overlayView.center
        alertView.titleLabel.text = String(localized: "Teams")
//        alertView.buttonsColor = AppAssetsConfigs.Colors.buttonAccept
        alertView.acceptButton.setTitle(String(localized: "Save"), for: .normal)
//        alertView.declineButton.setTitle(String(localized: "Restore"), for: .normal) // TODO: make a restore changes button
        alertView.adjustAlertHeight()
        alertView.center = self.view.center

        alertView.acceptAction = {
            self.isReadyPopup()
        }
        
//        alertView.declineAction = { // TODO: make a restore changes button
//            self.listTeamsTableViewPopup(self.categoryViewModel.teams.value.count)
//        }
        
//        alertView.collectionView.

        overlayView.addAlert(alertView: alertView)

        
    }
    
    func isReadyPopup() {
        if categoryViewModel.currentTeam.value == nil {
            categoryViewModel.fetchCurrentTeam()
        }
        // Alert
        let overlayView = BlurOverlayFactorView(frame: self.tabBarController?.view.bounds ?? self.view.bounds)
        self.tabBarController?.view.addSubview(overlayView) ?? self.view.addSubview(overlayView)
        
        let alertView = AlertView(frame: CGRect(x: 0, y: 0, width: 350, height: 400), isFullWidthButtons: true)
        alertView.overlayView = overlayView
        alertView.center = overlayView.center
        alertView.titleLabel.text = "\(String(localized: "Is team")) \(categoryViewModel.currentTeam.value?.name ?? "No tracking team") \(String(localized: "ready?"))"
        alertView.messageLabel.text = String(localized: "Your turn, it starts immidiatly after your press")
        alertView.messageLabel.numberOfLines = 0
//        alertView.acceptButtonsColor = AppAssetsConfigs.Colors.buttonAccept
//        alertView.declineButtonsColor = AppAssetsConfigs.Colors.buttonNeutral
        alertView.acceptButton.setTitle(String(localized: "Ready"), for: .normal)
        alertView.declineButton.setTitle(String(localized: "Change teams score"), for: .normal)
//        alertView.adjustAlertViewHeight()
        alertView.center = self.view.center

        alertView.acceptAction = {
            self.categoryViewModel.fetchCategory()
            self.timerViewModel.timerValue.value = 10
            self.timerViewModel.setupTimer()
        }
        
        alertView.declineAction = {
            self.listTeamsTableViewPopup(self.categoryViewModel.teams.value.count)
        }

        overlayView.addAlert(alertView: alertView)

    }
    
    func timerEndPopup() {
        let overlayView = BlurOverlayFactorView(frame: self.tabBarController?.view.bounds ?? self.view.bounds)
        self.tabBarController?.view.addSubview(overlayView) ?? self.view.addSubview(overlayView)
        
        let alertView = AlertView(frame: CGRect(x: 0, y: 0, width: 350, height: 220))
        alertView.overlayView = overlayView
        alertView.center = overlayView.center
        alertView.titleLabel.text = String(localized: "Timer Ended")
        alertView.messageLabel.text = "\(String(localized: "Is the team")) \(categoryViewModel.currentTeam.value?.name ?? "No tracking team") \(String(localized: "get + 1 point to score"))"
        alertView.messageLabel.numberOfLines = 0
//        alertView.acceptButtonsColor = AppAssetsConfigs.Colors.buttonAccept
//        alertView.declineButtonsColor = AppAssetsConfigs.Colors.buttonNeutral
        alertView.acceptButton.setTitle(String(localized: "Yes"), for: .normal)
        alertView.declineButton.setTitle(String(localized: "No"), for: .normal)
        alertView.center = self.view.center

        alertView.acceptAction = {
            self.categoryViewModel.changeScore(isIncrement: true)
            self.categoryViewModel.fetchCurrentTeam()
            self.isReadyPopup()
        }
        
        alertView.declineAction = {
            self.categoryViewModel.changeScore(isIncrement: false)
            self.categoryViewModel.fetchCurrentTeam()
            self.isReadyPopup()
        }

        overlayView.addAlert(alertView: alertView)

    }
    
}
