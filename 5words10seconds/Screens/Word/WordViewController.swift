//
//  WordViewController.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 30.10.2023.
//

import UIKit

class WordViewController: UIViewController {
    
    let descriptionLbl = UILabel()
    let wordLbl = UILabel()
    let circle = UIView()
    
    let viewModel = WordViewModel()
    
    var timerViewModel = TimerViewModel()
    var timerView: TimerView! // inited in WordView.swift

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews() // in WordView.swift
        
        bindViewModels()
    }
    
    func bindViewModels() {
        
    }
    
}
