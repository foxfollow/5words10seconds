//
//  PopupTeamsViewController.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 06.11.2023.
//

import UIKit

class PopupTeamsViewController: UIViewController {
    
//    var teams: [PopupTeamsViewModel] //TODO: doesn't work
    var teams = [PopupTeamsViewModel(team: TeamModel(name: "Team 1", score: 0)),
                PopupTeamsViewModel(team: TeamModel(name: "Team 2", score: 0))]
    
    let tableView = UITableView()
    
//    init(teams: [PopupTeamsViewModel]) {
////        self.teams =
//        self.teams = teams
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(PopupTeamsCellView.self, forCellReuseIdentifier: "PopupTeamsCellView")
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
}

// MARK: - TableView setup
extension PopupTeamsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "PopupTeamsCellView",
            for: indexPath
        ) as! PopupTeamsCellView
        cell.teamViewModel = teams[indexPath.row] // teams is an array of PopupTeamsViewModel instances
        cell.incrementBtn.addTarget(self, action: #selector(incrementScore(_:)), for: .touchUpInside)
        cell.decrementBtn.addTarget(self, action: #selector(decrementScore(_:)), for: .touchUpInside)
        cell.incrementBtn.tag = indexPath.row
        cell.decrementBtn.tag = indexPath.row
        return cell
    }
    
    @objc func incrementScore(_ sender: UIButton) {
        teams[sender.tag].incrementScore()
    }
    
    @objc func decrementScore(_ sender: UIButton) {
        teams[sender.tag].decrementScore()
    }
}
