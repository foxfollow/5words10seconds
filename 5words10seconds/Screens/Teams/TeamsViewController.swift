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

    let viewModel = TeamsViewModel()
    
//    var cellDataSource: [TeamModel]?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchTeams()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        setupSubviews()     // TeamsView.swift
        setupTableViewData()    // TeamsTableView.swift
        setupButtonTargets()
        
    }
    
    private func bindViewModel() {
        viewModel.cellDataSourceTeams.bind { [weak self] teams in
//            self?.cellDataSource = teams
            self?.initReload()
        }
    }
    
    func initReload() {
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func setupButtonTargets() {
        addBtn.addTarget(self, action: #selector(addTeamBtmClick), for: .touchUpInside)
        
        endBtn.addTarget(self, action: #selector(endBtnClick), for: .touchUpInside)
    }
    
    @objc func addTeamBtmClick() {
        print("Do not work yet")
    }
    
    @objc func endBtnClick() {
        let controller = WordViewController()
        navigationItem.backButtonTitle = "TODO: remove this"
        navigationController?.pushViewController(controller, animated: true)
//        present(controller, animated: true)
    }
}

