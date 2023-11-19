//
//  Teams.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 30.10.2023.
//

import Foundation

struct TeamModel: Hashable {
//    static func == (lhs: TeamModel, rhs: TeamModel) -> Bool {
//        return lhs.name == rhs.name && lhs.score == rhs.score
//    }
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(name)
//        hasher.combine(score)
//    }
    
    var name: String
    var score: Int
    
//    init(name: String, score: Int) {
//        self.name = name
//        self.score = score
//    }
}
