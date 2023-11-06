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
    
    func chooseLevel(integet: Int) { // todo level of categories
        
    }
    
    func getLevel() -> Int? { // very much to do
        return level
    }
    
    func fetchTeams(_ completion: @escaping (Result<[TeamModel], Error>) -> ()) {
        completion(.success(teamsTMP))
    }
    
    func fetchCategories(_ completion: @escaping (Result<[CategoryModel], Error>) -> ()) {
        completion(.success(categoriesTMP))
    }

    // useless things from exmaple:
//    static func fetchGameLevels(_ completion: @escaping (Result<[GameLevelModel], Error>) -> ()) {
//        completion(.success(gameLevels))
//    }
//

}

//let gameLevels: [GameLevelModel] = []
//
let teamsTMP: [TeamModel] = [
    TeamModel(name: "Tomatoes", score: 0),
    TeamModel(name: "Sleepwalkers", score: 0),
]

let allTeams: Set = [ // TODO: realise that Service will took 1 random, etc...
    TeamModel(name: "Tomatoes", score: 0),
    TeamModel(name: "Sleepwalkers", score: 0),
    TeamModel(name: "Penguins", score: 0),
    TeamModel(name: "Pineapples", score: 0),
    TeamModel(name: "Pirates", score: 0),
    TeamModel(name: "Murlocs", score: 0),

]
//
let categoriesTMP: [CategoryModel] = [
    CategoryModel(name: "European countries", level: 0),
    CategoryModel(name: "Bad Habits", level: 0),
    CategoryModel(name: "Green fruits and vagitables", level: 0),
    CategoryModel(name: "Colors", level: 0),
]
