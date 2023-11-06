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
    var timerView: TimerView! // inited in WordView.swift
    
    init(viewModel: CategoryViewModel) {
        self.categoryViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews() // in WordView.swift
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
            // TODO: "checked if get value" so change text in lbl
            print("Team changed to \(team?.name ?? "")")
        }
    }
}
