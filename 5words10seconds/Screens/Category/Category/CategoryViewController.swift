//
//  CategoryViewController.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 30.10.2023.
//

import UIKit

class CategoryViewController: UIViewController {
    
    let descriptionLbl = UILabel()
    let categoryLbl = UILabel()
    let circle = UIView()
    
    let categoryViewModel: CategoryViewModel
    
    var timerViewModel = TimerViewModel()
    var timerView: TimerView! // inited in CategoryView.swift - setupTimer()
    
    let tableView = UITableView() // setuped in PopupViewsFuncs.swift - listTeamsTableViewPopup()

    
    init(viewModel: CategoryViewModel) {
        self.categoryViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews() // in CategoryView.swift
        setupBinders()
        isReadyPopup() // in PopupViewsFuncs.swift
    }
    
    private func setupBinders() {
        // MARK: Timer binder
        timerViewModel.timerDidEnd.bind { [weak self] didEnd in
            if didEnd && (self?.categoryViewModel.currentCtgr.value != nil) {
                DispatchQueue.main.async {
                    self?.timerEndPopup()
                    //                    print(Service.shared.)
                }
            }
        }
        
        // MARK: Category-word binder
        categoryViewModel.currentCtgr.bind { [weak self] category in
            self?.categoryLbl.text = category?.name
        }        
        
        // MARK: Team binder
        categoryViewModel.currentTeam.bind { [weak self] team in
            // TODO: "checked if get value" so change text in lbl (score)
            print("Team changed to \(team?.name ?? "")")
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        categoryViewModel.teams.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

            
        // Bind scoreLabel to teams.value[row].score
//        categoryViewModel.teams.bind { [weak self] teams in
//            guard let self = self else { return }
//            let score = teams[indexPath.row].score
//            self.scoreLabel.text = "\(score)"
//        }
    }
}
