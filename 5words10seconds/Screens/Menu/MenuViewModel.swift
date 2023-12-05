//
//  MenuViewModel.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 30.10.2023.
//

import Foundation

enum SupportedLanguages: String, CaseIterable {
    case ukrainian = "uk"
    case english = "en"
    
    var language: LanguageModel {
        switch self {
        case .ukrainian:
            return LanguageModel(name: "Ukrainian", flag: "🇺🇦")
        case .english:
            return LanguageModel(name: "English", flag: "🇬🇧")
        }
    }

    static var allLanguages: [LanguageModel] {
        return allCases.map { $0.language }
    }
}


class MenuViewModel {   // TODO: create and perfome leveling
    var currentLanguage: ObservableObject<String?> {
        get {
            guard let lang: String = UserDefaults.standard.array(forKey: "AppleLanguages")?[0] as? String else { return ObservableObject(nil) }
            return ObservableObject(lang)
        }
    }

    func changeLanguage(changeTo ChoosenLanguage: SupportedLanguages) {
        UserDefaults.standard.set([ChoosenLanguage.rawValue], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }

//    var level: ObservableObject<Int?> = ObservableObject(nil)
////    func getLevel() {
////        level.value = Service.shared.getLevel()
////    }
    
    
//    func chooseGame() {
//        //
//    }
}
