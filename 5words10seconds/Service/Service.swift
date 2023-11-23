//
//  Service.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 30.10.2023.
//

import Foundation

struct Service {
    static let shared = Service()

    private var level: Int?

    private init() {}

    func chooseLevel(integet _: Int) { // todo level of categories
    }

    func getLevel() -> Int? { // very much to do
        return level
    }

    func fetchTeams(_ completion: @escaping (Result<Set<TeamModel>, Error>) -> Void) {
        completion(.success(allTeams))
    }

    func fetchCategories(_ completion: @escaping (Result<[CategoryModel], Error>) -> Void) {
        completion(.success(categoriesTMP))
    }
    

//     useless things from exmaple:
//    static func fetchGameLevels(_ completion: @escaping (Result<[GameLevelModel], Error>) -> ()) {
//        completion(.success(gameLevels))
//    }

}

// let gameLevels: [GameLevelModel] = []

let allTeams: Set = [
    TeamModel(name: "Tomatoes", score: 0),
    TeamModel(name: "Sleepwalkers", score: 0),
    TeamModel(name: "Penguins", score: 0),
    TeamModel(name: "Pineapples", score: 0),
    TeamModel(name: "Pirates", score: 0),
    TeamModel(name: "Angels", score: 0),
]

let categoriesTMP: [CategoryModel] = [
    CategoryModel(name: "European countries", level: 0),
    CategoryModel(name: "Bad Habits", level: 0),
    CategoryModel(name: "Green fruits and vagitables", level: 0),
    CategoryModel(name: "Colors", level: 0),
]
