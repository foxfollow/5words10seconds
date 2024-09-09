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
        var cloudRecords: [(category: CategorySwiftModel, record: CKRecord)] = []
        
        // Fetch the records and convert them to CategoryModel
        for record in result.matchResults.compactMap({ try? $0.1.get() }) {
            if let category = CategorySwiftModel(record: record) {
                cloudRecords.append((category: category, record: record))
            }
        }
        
        // Dictionary to track the newest category by name
        var uniqueCategories: [String: (category: CategorySwiftModel, record: CKRecord)] = [:]
        var duplicates: [CKRecord.ID] = []
        
        // Identify duplicates in CloudKit and mark them for deletion
        for cloudCategory in cloudRecords {
            if let existingCategory = uniqueCategories[cloudCategory.category.name] {
                // Compare based on modification date (newer takes priority)
                if cloudCategory.record.modificationDate ?? Date() > existingCategory.record.modificationDate ?? Date() {
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
        
        // Fetch categories from local database
        let localCategories = try await localDatabase.fetchCategories()
        
        // Check if there are any differences between local and cloud data
        var cloudHasChanges = false
        for cloudCategory in uniqueCategories.values {
            if !localCategories.contains(where: { $0.name == cloudCategory.category.name }) {
                cloudHasChanges = true
                break
            }
        }
        
        // Sync categories from CloudKit to local database only if there are changes
        if cloudHasChanges || localCategories.isEmpty {
            for cloudCategory in uniqueCategories.values {
                try await localDatabase.addCategory(from: cloudCategory.category)
            }
            // Save the final state in the local database
            try await localDatabase.save()
        }
    }


    // Add a new category to CloudKit
    func addCategoryToCloud(_ category: CategorySwiftModel) async throws {
        let record = category.record
        let savedRecord = try await dataBase.save(record)
        guard CategorySwiftModel(record: savedRecord) != nil else { return }
        try await syncCategories()
    }
    
    // Update an existing category in CloudKit
    func updateCategoryInCloud(_ category: CategorySwiftModel) async throws {
        guard let recordId = category.recordId else { return }
        let record = try await dataBase.record(for: CKRecord.ID(recordName: recordId))
        
        record[CategoryRecordKeys.name.rawValue] = category.name
        record[CategoryRecordKeys.level.rawValue] = category.level
        record[CategoryRecordKeys.language.rawValue] = category.language
        
        _ = try await dataBase.save(record)
        try await syncCategories()
    }
    
    // Delete a category from CloudKit and sync with local
    func deleteCategoryFromCloud(_ category: CategorySwiftModel) async throws {
        guard let recordId = category.recordId else { return }
        try await dataBase.deleteRecord(withID: CKRecord.ID(recordName: recordId))
        try await syncCategories()
    }
}

extension CloudKitManager {
    func addFastCategoriesUA() async {
        for category in diverseCategoriesUa {
            do {
                try await addCategoryToCloud(category)
            } catch {
                print("Failed to add category: \(category.name). Error: \(error)")
            }
        }
        print("All UA categories added successfully")
    }
    
    func addDiverseCategoriesUA() async {
        for category in diverseCategoriesUa {
            do {
                try await addCategoryToCloud(category)
            } catch {
                print("Failed to add category: \(category.name). Error: \(error)")
            }
        }
        print("All UA categories UA added successfully")
    }
    
    func addDiverseCategoriesEN() async {
        for category in diverseCategoriesEn {
            do {
                try await addCategoryToCloud(category)
            } catch {
                print("Failed to add EN category: \(category.name). Error: \(error)")
            }
        }
        print("All EN categories added successfully")
    }
}
