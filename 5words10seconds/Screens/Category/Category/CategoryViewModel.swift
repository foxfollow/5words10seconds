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
        if allCategories == nil  {
            Service.shared.fetchCategories { [weak self] (result) in
                switch result {
                case .success(let data):
                    self?.allCategories = data
                case .failure(let err):
                    print(err.localizedDescription)
                    // maybe: complition(nil, err.localizedDescription)
                }
            }
        }
        if allCategories != nil {
            let indexOfCtgr = Int.random( in: 0..<(allCategories!.count - 1) )
            let copiedCtgr = allCategories![indexOfCtgr]
            playedCategories.append(copiedCtgr)
            allCategories!.remove(at: indexOfCtgr)
            currentCtgr.value = copiedCtgr
        } else {
            print("Failed to fetch Categories")
        }
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
