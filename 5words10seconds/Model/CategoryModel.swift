//
//  Model.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 30.10.2023.
//  Changed to confirm SwiftData on 06.09.2024.
//

import Foundation
import CloudKit
import SwiftData

enum CategoryRecordKeys: String {
    case type = "CategorySwiftModel"
    case name
    case level
    case language
}

@Model
final class CategoryModel: Identifiable, Codable {
    @Attribute var id: UUID = UUID()
    var recordId: String?
    var name: String = ""
    var level: Int = 0
    var language: String = SupportedLanguages.english.rawValue
    var modificationDate: Date = Date()
    
    // Initializer
    init(id: UUID = UUID(), recordId: String? = nil, name: String, level: Int, language: String, modificationDate: Date = Date()) {
        self.id = id
        self.recordId = recordId
        self.name = name
        self.level = level
        self.language = language
        self.modificationDate = modificationDate
    }

    // Computed property to convert to CKRecord
    var record: CKRecord {
        let record = CKRecord(recordType: CategoryRecordKeys.type.rawValue)
        record["id"] = id.uuidString as CKRecordValue
        record[CategoryRecordKeys.name.rawValue] = name as CKRecordValue
        record[CategoryRecordKeys.level.rawValue] = level as CKRecordValue
        record[CategoryRecordKeys.language.rawValue] = language as CKRecordValue
        return record
    }

    // Initializer to create CategoryModel from CKRecord
    convenience init?(record: CKRecord) {
        guard let idString = record["id"] as? String,
              let id = UUID(uuidString: idString),
              let name = record[CategoryRecordKeys.name.rawValue] as? String,
              let level = record[CategoryRecordKeys.level.rawValue] as? Int,
              let languageString = record[CategoryRecordKeys.language.rawValue] as? String,
              let language = record[CategoryRecordKeys.language.rawValue] as? String
        else { return nil }
        let modificationDate = record.modificationDate ?? Date.distantPast
        
        self.init(id: id, recordId: record.recordID.recordName, name: name, level: level, language: language, modificationDate: modificationDate)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case recordId
        case name
        case level
        case language
        case modificationDate
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        recordId = try container.decodeIfPresent(String.self, forKey: .recordId)
        name = try container.decode(String.self, forKey: .name)
        level = try container.decode(Int.self, forKey: .level)
        language = try container.decode(String.self, forKey: .language)
        modificationDate = try container.decode(Date.self, forKey: .modificationDate)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encodeIfPresent(recordId, forKey: .recordId)
        try container.encode(name, forKey: .name)
        try container.encode(level, forKey: .level)
        try container.encode(language, forKey: .language)
        try container.encode(modificationDate, forKey: .modificationDate)
    }
}
