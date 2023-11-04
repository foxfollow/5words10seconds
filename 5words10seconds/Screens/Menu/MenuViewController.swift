//
//  ViewController.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 30.10.2023.
//

import UIKit

class MenuViewController: UIViewController {
    
    var game5w10sBtn = UIButton()
    var game3w5sBtn = UIButton()

//    private let viewModel = MenuViewModel() // not using
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews() // in MenuView.swift
        setupButtonTargets()
    }
    
    private func setupButtonTargets() {
        game5w10sBtn.addTarget(self, action: #selector(fiveTenButtonClicked), for: .touchUpInside)
        
        game3w5sBtn.addTarget(self, action: #selector(threeFiveTenButtonClicked), for: .touchUpInside)
    }
    
    @objc func fiveTenButtonClicked() {
        let controller = TeamsViewController()
        navigationItem.backButtonTitle = "Back"
        navigationController?.navigationBar.tintColor = .darkText
        navigationController?.pushViewController(controller, animated: true)
//        present(controller, animated: true)
    }
    
    @objc func threeFiveTenButtonClicked() {
        print("Doesn't work yet (in dev)")
    }
    



}

