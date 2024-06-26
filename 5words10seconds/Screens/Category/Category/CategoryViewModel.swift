//
//  CategoryViewModel.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 04.11.2023.
//

import Foundation

class CategoryViewModel {
    var teams: ObservableObjectCustom<[TeamModel]>
    
    var currentTeam: ObservableObjectCustom<TeamModel?> = ObservableObjectCustom(nil)
    var currentCtgr: ObservableObjectCustom<CategoryModel?> = ObservableObjectCustom(nil)
    
    var playedCategories = [CategoryModel]()
    var allCategories: [CategoryModel]?

    init(teams: [TeamModel]) {
        self.teams = ObservableObjectCustom(teams)
    }
    
    func fetchCategory() {
        // If allCategories is nil, fetch categories
        if allCategories == nil {
            // Fetch categories from CloudKit
            Task {
                do {
                    try await CloudMainModel.shared.populateCategories()
                    self.allCategories = CloudMainModel.shared.categories
//                    self.selectRandomCategory()
                } catch {
                    print("Failed to fetch categories: \(error)")
                }
            }
        } else {
            selectRandomCategory()
        }
    }

    // MARK: Fetching from service
//    func fetchCategory() {
//        // If allCategories is nil, fetch categories
//        if allCategories == nil {
//            Service.shared.fetchCategories { [weak self] result in
//                switch result {
//                case let .success(data):
//                    self?.allCategories = data
//                    self?.selectRandomCategory()
//                case let .failure(err):
//                    print(err.localizedDescription)
//                }
//            }
//        } else {
//            selectRandomCategory()
//        }
//    }

    private func selectRandomCategory() {
        guard let allCategories = allCategories, !allCategories.isEmpty else {
            currentCtgr.value = CategoryModel(name: String(localized: "No categories, sorry"), level: 0, language: .english)
            print("Failed to fetch Categories")
            return
        }

        let indexOfCtgr = Int.random(in: 0 ..< allCategories.count)
        let copiedCtgr = allCategories[indexOfCtgr]
        playedCategories.append(copiedCtgr)
        self.allCategories?.remove(at: indexOfCtgr)
        currentCtgr.value = copiedCtgr
    }


    func fetchCurrentTeam() {
        if currentTeam.value == nil || currentTeam.value == teams.value.last {
            currentTeam.value = teams.value.first
        } else {
            if let currentIndex = teams.value.firstIndex(where: { $0 == currentTeam.value }) {
                let nextIndex = (currentIndex + 1) % teams.value.count
                currentTeam.value = teams.value[nextIndex]
            }
        }
    }
    
    func changeScore(isIncrement: Bool) {
        currentCtgr.value = nil
        if isIncrement {
            currentTeam.value?.score += 1
        }
    }
        
    func changeScore(isIncrement: Bool, index: Int) {
        if isIncrement {
            teams.value[index].score += 1
        } else {
            teams.value[index].score -= 1
        }
        teams.value = teams.value
    }
}
