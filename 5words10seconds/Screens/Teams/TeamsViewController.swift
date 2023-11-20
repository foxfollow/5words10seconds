//
//  TeamsViewController.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 30.10.2023.
//

import UIKit

class TeamsViewController: UIViewController {
    
//    let textField = UITextField()
    let tableView = UITableView()
    let addBtn = UIButton()
    let endBtn = UIButton()
    let descriptionLbl = UILabel()

    let teamsViewModel = TeamsViewModel()
    
//    var cellDataSource: [TeamModel]?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        teamsViewModel.fetchTeams()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        bindViewModel()
        setupSubviews()     // TeamsView.swift
        setupTableViewData()    // TeamsTableView.swift
        setupButtonTargets()
        
    }
    
//    private func bindViewModel() {
//        teamsViewModel.cellDataSourceTeams.bind { [weak self] teams in
////            self?.cellDataSource = teams
//            self?.initReload()
//        }
//    }
    
//    func initReload() {
//        teamsViewModel.reloadTableView = { [weak self] in
//            DispatchQueue.main.async {
//                self?.tableView.reloadData()
//            }
//        }
//    }
    
    private func setupButtonTargets() {
        addBtn.addTarget(self, action: #selector(addTeamBtmClick), for: .touchUpInside)
        
        endBtn.addTarget(self, action: #selector(endBtnClick), for: .touchUpInside)
    }
    
    @objc func addTeamBtmClick() {
        print("Do not work yet")
    }
    
    @objc func endBtnClick() {
        guard let teams = teamsViewModel.dataSourceTeams else { return }
        let wordViewModel = CategoryViewModel(teams: teams)
        let controller = CategoryViewController(viewModel: wordViewModel)
        navigationItem.backButtonTitle = "TODO: remove this"
        navigationController?.pushViewController(controller, animated: true)
//        present(controller, animated: true)
    }
}

