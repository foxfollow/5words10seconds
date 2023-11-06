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
        isReadyPopup()
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
            // TODO: "checked if get value" so change text in lbl
            self?.categoryLbl.text = category?.name
        }
    }
    
    // TODO: make func to get currentCtgr with popup windows
    func isReadyPopup() {
        // TODO: add value current team and track it, if nil current = teams[0]
        let alertController = UIAlertController(title: "Is team \(categoryViewModel.teams[0].name)", // TODO: track the team
                                                message: "Your turn, it starts immidiatly after your press",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ready", style: .default, handler: {_ in
            self.categoryViewModel.fetchCategory()
            self.timerViewModel.timerValue.value = 10
            self.timerViewModel.setupTimer()
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func timerEndPopup() {  // TODO: add +1 to team score; if true ask if next team ready, relaunch categorie
        let alertController = UIAlertController(title: "Timer Ended",
                                                message: "Is the team get + 1 point to score",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: {_ in
            self.categoryViewModel.currentCtgr.value = nil
            self.isReadyPopup()
//            categoryViewModel.teams // TODO: add tracking a team then add to score, change team
        }))
        alertController.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
        
    }
    
}
