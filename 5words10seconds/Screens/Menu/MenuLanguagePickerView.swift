//
//  MenuLanguagePickerView.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 05.12.2023.
//

import UIKit

extension MenuViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func setupLanguagePicker() {
        languagePicker.delegate = self
        languagePicker.dataSource = self
        
        if let currentLanguageCode = menuViewModel.currentLanguage.value,
           let languageIndex = SupportedLanguages.allCases.firstIndex(where: { $0.rawValue == currentLanguageCode }) {
            languagePicker.selectRow(languageIndex, inComponent: 0, animated: false)
        }
    }

    // UIPickerViewDataSource methods
    func numberOfComponents(in _: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_: UIPickerView, numberOfRowsInComponent _: Int) -> Int {
        return SupportedLanguages.allLanguages.count
    }

    // UIPickerViewDelegate methods
    func pickerView(_: UIPickerView, titleForRow row: Int, forComponent _: Int) -> String? {
        let language = SupportedLanguages.allLanguages[row]
        return "\(language.flag) \(language.name)"
    }

    func pickerView(_: UIPickerView, didSelectRow row: Int, inComponent _: Int) {
        let selectedLanguage = SupportedLanguages.allCases[row]
        menuViewModel.changeLanguage(changeTo: selectedLanguage)
        hintLangugeTtl.isHidden = false
        print("Selected language: \(selectedLanguage.rawValue)")
    }
}
