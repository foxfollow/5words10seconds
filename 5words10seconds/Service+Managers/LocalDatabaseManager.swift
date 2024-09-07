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
    
    // Fetch all categories using FetchDescriptor
    @MainActor func fetchCategories() throws -> [CategoryModel] {
        guard let context = container?.mainContext else {
            throw NSError(domain: "LocalDatabaseManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to access the main context"])
        }
        let request = FetchDescriptor<CategoryModel>() // No predicate, fetching all
        return try context.fetch(request)
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
