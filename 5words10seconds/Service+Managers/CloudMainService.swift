//
//  CloudMainService.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 10.01.2024.
//

import CloudKit
import SwiftData
import Foundation

final class CloudKitManager {
    static let shared = CloudKitManager()
    private var dataBase: CKDatabase
    private let localDatabase = LocalDatabaseManager.shared
    
    private init() {
        dataBase = CKContainer(identifier: "iCloud.com.d3f0ld.5words10seconds").publicCloudDatabase
    }
    
    // Fetch categories from CloudKit and sync with local database
    func syncCategories() async throws {
        let currentLanguage = Locale.current.language.languageCode?.identifier ?? "en"
        let predicate = NSPredicate(format: "%K == %@", CategoryRecordKeys.language.rawValue, currentLanguage)
        let query = CKQuery(recordType: CategoryRecordKeys.type.rawValue, predicate: predicate)
        
        // Fetch records from CloudKit
        let result = try await dataBase.records(matching: query)
        var cloudRecords: [CategoryModel] = []
        
        for record in result.matchResults.compactMap({ try? $0.1.get() }) {
            if let category = CategoryModel(record: record) {
                cloudRecords.append(category)
            }
        }
        
        // Fetch local categories
        var localCategories = try await localDatabase.fetchCategories()
        
        // Sync categories
        for cloudCategory in cloudRecords {
            if let existingLocalCategory = localCategories.first(where: { $0.name == cloudCategory.name }) {
                if existingLocalCategory.recordId != cloudCategory.recordId {
                    // If a local category with the same name but different recordId exists, delete older one
                    try await localDatabase.deleteCategory(existingLocalCategory)
                    localCategories.removeAll(where: { $0.name == cloudCategory.name })
                }
            }
            // Insert/Update the new or updated CloudKit category in the local database
            _ = try await localDatabase.addCategory(name: cloudCategory.name, level: cloudCategory.level, language: cloudCategory.language)
        }
    }
    
    // Add a new category to CloudKit
    func addCategoryToCloud(_ category: CategoryModel) async throws {
        let record = category.record
        let savedRecord = try await dataBase.save(record)
        guard let newCategory = CategoryModel(record: savedRecord) else { return }
        try await syncCategories()
    }
    
    // Update an existing category in CloudKit
    func updateCategoryInCloud(_ category: CategoryModel) async throws {
        guard let recordId = category.recordId else { return }
        let record = try await dataBase.record(for: CKRecord.ID(recordName: recordId))
        
        record[CategoryRecordKeys.name.rawValue] = category.name
        record[CategoryRecordKeys.level.rawValue] = category.level
        record[CategoryRecordKeys.language.rawValue] = category.language.rawValue
        
        _ = try await dataBase.save(record)
        try await syncCategories()
    }
    
    // Delete a category from CloudKit and sync with local
    func deleteCategoryFromCloud(_ category: CategoryModel) async throws {
        guard let recordId = category.recordId else { return }
        try await dataBase.deleteRecord(withID: CKRecord.ID(recordName: recordId))
        try await syncCategories()
    }
}
