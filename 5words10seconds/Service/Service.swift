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
    
    func chooseLevel(integet: Int) {
        
    }
    
    func getLevel() -> Int? { // very much to do
        return level
    }
    
    func fetchTeams(_ completion: @escaping (Result<[TeamModel], Error>) -> ()) {
        completion(.success(teams))
    }
    
    // useless things from exmaple:
//    static func fetchGameLevels(_ completion: @escaping (Result<[GameLevelModel], Error>) -> ()) {
//        completion(.success(gameLevels))
//    }
//
//    static func fetchCategories(_ completion: @escaping (Result<[CategoryModel], Error>) -> ()) {
//        completion(.success(categories))
//    }

}

//let gameLevels: [GameLevelModel] = []
//
let teams: [TeamModel] = [
    TeamModel(name: "Tomatoes", score: 0),
    TeamModel(name: "Sleepwalkers", score: 0),
]

let allTeams: Set = [
    TeamModel(name: "Tomatoes", score: 0),
    TeamModel(name: "Sleepwalkers", score: 0),
    TeamModel(name: "Penguins", score: 0),
    TeamModel(name: "Pineapples", score: 0),
    TeamModel(name: "Pirates", score: 0),
    TeamModel(name: "Murlocs", score: 0),

]
//
//let categories: [CategoryModel] = []
