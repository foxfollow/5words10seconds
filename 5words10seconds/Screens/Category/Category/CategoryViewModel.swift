//
//  CategoryViewModel.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 04.11.2023.
//

import Foundation

class CategoryViewModel {
    var teams: ObservableObject<[TeamModel]>

    var currentTeam: ObservableObject<TeamModel?> = ObservableObject(nil)
    var currentCtgr: ObservableObject<CategoryModel?> = ObservableObject(nil)

//    var teams: [TeamModel] // TODO: Observable when updates score

    var playedCategories = [CategoryModel]()
    var allCategories: [CategoryModel]?

    init(teams: [TeamModel]) {
        self.teams = ObservableObject(teams)
    }

    func fetchCategory() {
        // If allCategories is nil, fetch categories
        if allCategories == nil {
            Service.shared.fetchCategories { [weak self] result in
                switch result {
                case let .success(data):
                    self?.allCategories = data
                    self?.selectRandomCategory()
                case let .failure(err):
                    print(err.localizedDescription)
                }
            }
        } else {
            selectRandomCategory()
        }
    }

    private func selectRandomCategory() {
        guard let allCategories = allCategories, !allCategories.isEmpty else {
            currentCtgr.value = CategoryModel(name: "No categories, sorry", level: 0)
            print("Failed to fetch Categories")
            return
        }

        let indexOfCtgr = Int.random(in: 0 ..< allCategories.count)
        let copiedCtgr = allCategories[indexOfCtgr]
        playedCategories.append(copiedCtgr)
        self.allCategories?.remove(at: indexOfCtgr)
        currentCtgr.value = copiedCtgr
    }

//    func fetchCurrentTeam(index: Int) {
//        currentTeam.value = teams.value[index]
//    }

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
}
