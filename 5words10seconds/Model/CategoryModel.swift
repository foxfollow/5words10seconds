//
//  Model.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 30.10.2023.
//

import Foundation
import CloudKit

enum CategoryRecordKeys: String {
    case type = "CategoryModel"
    case name
    case level
}

struct CategoryModel {
    var recordId: CKRecord.ID?
    var name: String
    var level: Int // todo change int to GameLevelModel
}

extension CategoryModel {
    var record: CKRecord {
        let record = CKRecord(recordType: CategoryRecordKeys.type.rawValue)
        record[CategoryRecordKeys.name.rawValue] = name
        record[CategoryRecordKeys.level.rawValue] = level
        return record
    }
}

extension CategoryModel {
    init?(record: CKRecord) {
        guard let name = record[CategoryRecordKeys.name.rawValue] as? String,
              let level = record[CategoryRecordKeys.level.rawValue] as? Int else { return nil }
        
        self.init(recordId: record.recordID, name: name, level: level)
    }
    
}
