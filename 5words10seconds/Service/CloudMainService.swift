//
//  CloudMainService.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 10.01.2024.
//

import CloudKit
import Foundation

// @MainActor
final class CloudMainModel: ObservableObject {
    public static let shared = CloudMainModel()

    private var dataBase = CKContainer(identifier: "iCloud.com.d3f0ld.5words10seconds").publicCloudDatabase
    @Published var categoriesDictionary: [CKRecord.ID: CategoryModel] = [:]

    var categories: [CategoryModel] {
        let evDict = categoriesDictionary.values.compactMap { $0 }
//        let dict = evDict.sorted { $0.startTime < $1.startTime }

        return evDict
    }
}

extension CloudMainModel {
    func addCategory(theItem: CategoryModel) async throws {
        let record = try await dataBase.save(theItem.record)
//        let record = try await db.modifyRecords(saving: eventItem.record, deleting: eventItem.recordId!)
        guard let event = CategoryModel(record: record) else { return }
        categoriesDictionary[event.recordId!] = event
    }

    func updateCategory(editedCategory: CategoryModel, recId: CKRecord.ID) async throws {
        categoriesDictionary[recId] = editedCategory
        categoriesDictionary[recId]?.recordId = recId

//        let record = try await dataBase.modifyRecords(saving: [editedEventItem.record], deleting: [recId])
        do {
            let record = try await dataBase.record(for: recId)
            record[CategoryRecordKeys.name.rawValue] = editedCategory.name
            record[CategoryRecordKeys.level.rawValue] = editedCategory.level
            record[CategoryRecordKeys.language.rawValue] = editedCategory.language.rawValue
            try await dataBase.save(record)
        } catch {
            //
        }
    }

    func populateCategories(byDate _: String = "") async throws {
        
        let currentLanguage = Locale.current.language.languageCode?.identifier ?? "en"
        let predicate = NSPredicate(format: "%K == %@", CategoryRecordKeys.language.rawValue, currentLanguage)

        let query = CKQuery(recordType: CategoryRecordKeys.type.rawValue, predicate: predicate)
        
//        let predicate = NSPredicate(value: true)
//        let predicate = NSPredicate(format: "dayOfMonth BEGINSWITH %@", "\(byDate)")

//        let query = CKQuery(recordType: CategoryRecordKeys.type.rawValue, predicate: predicate)
//        query.sortDescriptors = [NSSortDescriptor(key: "startTime", ascending: true)]

        let result = try await dataBase.records(matching: query)
        let records = result.matchResults.compactMap {
            try? $0.1.get()
        }
        categoriesDictionary = [:]
        records.forEach { record in
//            print("my record:::::::: \(record)")
//            print("START adding dictionary event")
//            print("all events list: \(events)")
//            print("all dictianry: \(categoriesDictionary)")

            categoriesDictionary[record.recordID] = CategoryModel(record: record)

//            print("END adding dictionary event")
//            print("all events list: \(events)")
//            print("all dictianry: \(categoriesDictionary)")
        }
        print("\n-----------")
//        print(categoriesDictionary)
//
    }

    func deleteEvent(indexSet: IndexSet) {
        let normalIndex = indexSet.startIndex.description.split(separator: " ")[1]
        let recId = categories[Int(normalIndex)!].recordId
        categoriesDictionary.removeValue(forKey: recId!)

        dataBase.delete(withRecordID: recId!) { _, error in
            if let error = error {
                print(error)
                print(error.localizedDescription)
            }
        }
    }

    func addDiverseCategoriesUA() async {
        for category in diverseCategoriesUa {
            do {
                try await addCategory(theItem: category)
            } catch {
                print("Failed to add category: \(category.name). Error: \(error)")
            }
        }
        print("All UA categories UA added successfully")
    }
    
    func addDiverseCategoriesEN() async {
        for category in diverseCategoriesEn {
            do {
                try await addCategory(theItem: category)
            } catch {
                print("Failed to add EN category: \(category.name). Error: \(error)")
            }
        }
        print("All EN categories added successfully")
    }
}

extension CloudMainModel {
    func removeAllCategories() async {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: CategoryRecordKeys.type.rawValue, predicate: predicate)

        do {
            let result = try await dataBase.records(matching: query)
            let records = result.matchResults.compactMap {
                try? $0.1.get()
            }

            for record in records {
                try await dataBase.delete(withRecordID: record.recordID) { _, error in
                    if let error = error {
                        print(error)
                        print(error.localizedDescription)
                    }
                }
            }

            categoriesDictionary.removeAll()
        } catch {
            print("Failed to remove all categories: \(error)")
        }
        print("All categories removed successfully")
    }
}

//extension CloudMainModel {
//    private func copyRecordsToProductionEnvironment() {
//        let container = CKContainer(identifier: "iCloud.com.d3f0ld.5words10seconds")
//        let publicDatabase = container.publicCloudDatabase
//
//        // Fetch records from the development environment
//        let predicate = NSPredicate(value: true)
//        let query = CKQuery(recordType: "CategoryModel", predicate: predicate)
//
//        publicDatabase.perform(query, inZoneWith: nil) { records, error in
//            if let error = error {
//                // Handle error
//                print("Error fetching records: \(error)")
//            } else if let records = records {
//                // Switch to the production environment
//                let productionContainer = CKContainer(identifier: "iCloud.com.d3f0ld.5words10seconds")
//                let productionDatabase = productionContainer.publicCloudDatabase
//
//                // Save records to the production environment
//                let operation = CKModifyRecordsOperation(recordsToSave: records, recordIDsToDelete: nil)
//                operation.modifyRecordsCompletionBlock = { _, _, error in
//                    if let error = error {
//                        // Handle error
//                        print("Error saving records: \(error)")
//                    } else {
//                        print("Records successfully copied to the production environment")
//                    }
//                }
//                productionDatabase.add(operation)
//            }
//        }
//    }
//}
