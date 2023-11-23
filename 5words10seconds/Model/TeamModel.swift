//
//  TeamModel.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 30.10.2023.
//

import Foundation

class TeamModel: Hashable {
    static func == (lhs: TeamModel, rhs: TeamModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: UUID
    var name: String
    var score: Int
    
    init(name: String, score: Int) {
        id = UUID()
        self.name = name
        self.score = score
    }
}
