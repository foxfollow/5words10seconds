//
//  Model.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 30.10.2023.
//  Changed to confirm SwiftData
//

import Foundation
import CloudKit
import SwiftData

enum CategoryRecordKeys: String {
    case type = "CategoryModel"
    case name
    case level
    case language
}

@Model
final class CategoryModel: Identifiable {
    // SwiftData requires a unique identifier
    @Attribute(.unique) var id: UUID
    
    // Optional CloudKit record ID
    var recordId: String?
    
    // Category properties
    var name: String
    var level: Int
    var language: SupportedLanguages
    
    // Initializer
    init(id: UUID = UUID(), recordId: String? = nil, name: String, level: Int, language: SupportedLanguages) {
        self.id = id
        self.recordId = recordId
        self.name = name
        self.level = level
        self.language = language
    }
    
    // Computed property to convert to CKRecord
    var record: CKRecord {
        let record = CKRecord(recordType: CategoryRecordKeys.type.rawValue)
        record["id"] = id.uuidString as CKRecordValue
        record[CategoryRecordKeys.name.rawValue] = name as CKRecordValue
        record[CategoryRecordKeys.level.rawValue] = level as CKRecordValue
        record[CategoryRecordKeys.language.rawValue] = language.rawValue as CKRecordValue
        return record
    }
    
    // Initializer to create CategoryModel from CKRecord
    convenience init?(record: CKRecord) {
        guard let idString = record["id"] as? String,
              let id = UUID(uuidString: idString),
              let name = record[CategoryRecordKeys.name.rawValue] as? String,
              let level = record[CategoryRecordKeys.level.rawValue] as? Int,
              let languageString = record[CategoryRecordKeys.language.rawValue] as? String,
              let language = SupportedLanguages(rawValue: languageString)
        else { return nil }
        
        self.init(id: id, recordId: record.recordID.recordName, name: name, level: level, language: language)
    }
}
