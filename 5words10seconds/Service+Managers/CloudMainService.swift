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
    
    func syncCategories() async throws {
        let currentLanguage = Locale.current.language.languageCode?.identifier ?? "en"
        let predicate = NSPredicate(format: "%K == %@", CategoryRecordKeys.language.rawValue, currentLanguage)
        let query = CKQuery(recordType: CategoryRecordKeys.type.rawValue, predicate: predicate)
        
        // Fetch records from CloudKit
        let result = try await dataBase.records(matching: query)
        var cloudRecords: [(category: CategoryModel, record: CKRecord)] = []
        
        for record in result.matchResults.compactMap({ try? $0.1.get() }) {
            if let category = CategoryModel(record: record) {
                cloudRecords.append((category: category, record: record))
            }
        }

//        cloudRecords.forEach { print($0.category.name) }

        // Dictionary to track the newest category by name
        var uniqueCategories: [String: (category: CategoryModel, record: CKRecord)] = [:]
        var duplicates: [CKRecord.ID] = []
        
        // Identify duplicates in CloudKit and mark them for deletion
        for cloudCategory in cloudRecords {
            if let existingCategory = uniqueCategories[cloudCategory.category.name] {
                // Compare based on modification date (newer takes priority)
                if cloudCategory.category.modificationDate > existingCategory.category.modificationDate {
                    duplicates.append(existingCategory.record.recordID) // Mark older record for deletion
                    uniqueCategories[cloudCategory.category.name] = cloudCategory
                } else {
                    duplicates.append(cloudCategory.record.recordID) // Mark this record for deletion
                }
            } else {
                uniqueCategories[cloudCategory.category.name] = cloudCategory
            }
        }
        
        // Delete duplicates from CloudKit
        for recordID in duplicates {
            try await dataBase.deleteRecord(withID: recordID)
        }
        
        // Sync categories from CloudKit to local database
        for cloudCategory in uniqueCategories.values {
            try await localDatabase.addCategory(from: cloudCategory.category)
        }
        
        // Save the final state in the local database
        try await localDatabase.save()
    }

    
    // Add a new category to CloudKit
    func addCategoryToCloud(_ category: CategoryModel) async throws {
        let record = category.record
        let savedRecord = try await dataBase.save(record)
        guard CategoryModel(record: savedRecord) != nil else { return }
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
