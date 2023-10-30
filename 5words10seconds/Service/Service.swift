//
//  Service.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 30.10.2023.
//

import Foundation

struct Service {
    
    static func fetchGameLevels(_ completion: @escaping (Result<[GameLevelModel], Error>) -> ()) {
        completion(.success(gameLevels))
    }

    static func fetchTeams(_ completion: @escaping (Result<[TeamModel], Error>) -> ()) {
        completion(.success(teams))
    }
    
    static func fetchCategories(_ completion: @escaping (Result<[CategoryModel], Error>) -> ()) {
        completion(.success(categories))
    }

}

let gameLevels: [GameLevelModel] = []

let teams: [TeamModel] = []

let categories: [CategoryModel] = []
