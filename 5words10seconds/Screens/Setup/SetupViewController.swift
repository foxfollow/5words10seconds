//
//  SetupViewController.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 20.05.2024.
//

import UIKit

class SetupViewController: RootViewController {
    
    let hintLangugeTtl = UILabel()
    let languagePicker = UIPickerView()
    
    let setupViewModel = SetupViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickerSubviews()
        setupLanguagePicker() // in SetupLanguagePickerView.swift

    }
    
}
