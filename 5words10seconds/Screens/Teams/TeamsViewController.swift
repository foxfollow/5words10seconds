//
//  TeamsViewController.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 30.10.2023.
//

import UIKit

class TeamsViewController: UIViewController {
    var tableViewHeightConstraint: NSLayoutConstraint?
    var tableViewHeight: CGFloat = 112
//    let textField = UITextField()
    let tableView = UITableView()
    let addBtn = UIButton()
    let endBtn = UIButton()
    let descriptionLbl = UILabel()

    let teamsViewModel = TeamsViewModel()
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        teamsViewModel.fetchTeams()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()     // TeamsView.swift
        setupTableViewData()    // TeamsTableView.swift
        setupButtonTargets()
        
    }

    private func setupButtonTargets() {
        addBtn.addTarget(self, action: #selector(addTeamBtmClick), for: .touchUpInside)
        
        endBtn.addTarget(self, action: #selector(endBtnClick), for: .touchUpInside)
    }
    
    @objc func addTeamBtmClick() {
        teamsViewModel.addNewTeam()
        teamsViewModel.reloadTableView?()
        
        tableViewHeight += tableView.rowHeight
        
        tableViewHeightConstraint?.constant = tableViewHeight
        
        view.layoutIfNeeded()
        
    }
    
    @objc func endBtnClick() {
        guard let teams = teamsViewModel.dataSourceTeams else { return }
        let wordViewModel = CategoryViewModel(teams: teams)
        let controller = CategoryViewController(viewModel: wordViewModel)
        navigationController?.pushViewController(controller, animated: true)
    }
}

