//
//  TeamsViewController.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 30.10.2023.
//

import UIKit

class TeamsViewController: RootViewController {
    var tableViewHeightConstraint: NSLayoutConstraint?
    var tableViewHeight: CGFloat = 112
    //    let textField = UITextField()
    let tableView = UITableView()
    
    let addBtn = UIButton()
    let endBtn = UIButton()
    let descriptionLbl = UILabel()
    
    let teamsViewModel = TeamsViewModel()
    
    var isAddingFirstTime = true
    var isAddingSecondTime = true
    
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
        tableView.snp.updateConstraints { make in
            make.height.equalTo(tableViewHeight)
        }
        
        // Check if addBtn is covering endBtn
        let isAddBtnCoveringEndBtn = tableView.frame.origin.y + tableViewHeight + addBtn.frame.height > endBtn.frame.origin.y
        if isAddBtnCoveringEndBtn {
            // If it is, make addBtn.bottom = endBtn.top
            addBtn.snp.remakeConstraints { make in
                make.left.right.equalToSuperview()
                make.bottom.equalTo(endBtn.snp.top)
                make.height.equalTo(56)
            }
        } else {
            // If it's not, update the constraints of addBtn
            self.tableView.contentInset.bottom = 0
            addBtn.snp.remakeConstraints { make in
                make.top.equalTo(tableView.snp.bottom)
                make.left.right.equalToSuperview()
                make.height.equalTo(56)
            }
        }
        
        view.layoutIfNeeded()
        
        // Reload the table view data
        tableView.reloadData()
        
        if isAddBtnCoveringEndBtn {
            self.tableView.contentInset.bottom += self.tableView.rowHeight
        }
    }
    
    @objc func endBtnClick() {
        guard let teams = teamsViewModel.dataSourceTeams else { return }
        let wordViewModel = CategoryViewModel(teams: teams)
        let controller = CategoryViewController(viewModel: wordViewModel)
        navigationController?.pushViewController(controller, animated: true)
    }
}

