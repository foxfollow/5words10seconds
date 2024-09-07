//
//  LocalDatabaseManager.swift
//  5words10seconds
//
//  Created by Heorhii Savoiskyi on 06.09.2024.
//

import Foundation
import SwiftData

class LocalDatabaseManager {
    static let shared = LocalDatabaseManager()
    
    private var container: ModelContainer?
    
    private init() {
        do {
            // Initialize the ModelContainer with the CategoryModel
            container = try ModelContainer(for: CategoryModel.self)
        } catch {
            print("Failed to initialize ModelContainer: \(error)")
            container = nil // Handle gracefully by setting container to nil
        }
    }
    
    // Fetch all categories and delete duplicates
    @MainActor func fetchCategories() throws -> [CategoryModel] {
        guard let context = container?.mainContext else {
            throw NSError(domain: "LocalDatabaseManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to access the main context"])
        }
        
        let request = FetchDescriptor<CategoryModel>() // Fetch all categories
        var categories = try context.fetch(request)
        
        // Determine the current language
        let languageCode = Locale.current.language.languageCode?.identifier ?? "en"
        let language = SupportedLanguages(rawValue: languageCode) ?? .english
        
        // Filter categories by the current language
        categories = categories.filter { $0.language == language }
        
        // Dictionary to store the latest category by name
        var uniqueCategories: [String: CategoryModel] = [:]
        
        // Iterate over the fetched categories
        for category in categories {
            if let existingCategory = uniqueCategories[category.name] {
                // Compare modification dates
                if category.modificationDate > existingCategory.modificationDate {
                    // If the new category is more recent, replace the older one
                    uniqueCategories[category.name] = category
                    try deleteCategory(existingCategory) // Delete the older one
                } else if category.modificationDate == existingCategory.modificationDate {
                    // If modification dates are the same, arbitrarily delete one
                    try deleteCategory(category)
                }
            } else {
                // Add category if no duplicate exists yet
                uniqueCategories[category.name] = category
            }
        }
        
        // Save changes after removing duplicates
        try save()
        
        // Return the unique categories
        return Array(uniqueCategories.values)
    }

    // Add a new category
    @MainActor func addCategory(name: String, level: Int, language: SupportedLanguages) throws -> CategoryModel {
        guard let context = container?.mainContext else {
            throw NSError(domain: "LocalDatabaseManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to access the main context"])
        }
        let category = CategoryModel(name: name, level: level, language: language)
        context.insert(category)
        return category
    }
    
    @MainActor func addCategory(from category: CategoryModel) throws {
        guard let context = container?.mainContext else {
            throw NSError(domain: "LocalDatabaseManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to access the main context"])
        }
        context.insert(category)
    }
    
    // Delete a category
    @MainActor func deleteCategory(_ category: CategoryModel) throws {
        guard let context = container?.mainContext else {
            throw NSError(domain: "LocalDatabaseManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to access the main context"])
        }
        context.delete(category)
    }
    
    // Save context changes
    @MainActor func save() throws {
        guard let context = container?.mainContext else {
            throw NSError(domain: "LocalDatabaseManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to access the main context"])
        }
        if context.hasChanges {
            try context.save()
        }
    }
}
