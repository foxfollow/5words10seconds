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
    
    private let container: ModelContainer
    
    private init() {
        // Initialize the ModelContainer with the CategoryModel
        container = try! ModelContainer(for: CategoryModel.self)
    }
    
    // Fetch all categories using FetchDescriptor
    @MainActor func fetchCategories() throws -> [CategoryModel] {
        let context = container.mainContext
        let request = FetchDescriptor<CategoryModel>() // No predicate, fetching all
        return try context.fetch(request)
    }
    
    // Add a new category
    @MainActor func addCategory(name: String, level: Int, language: SupportedLanguages) throws -> CategoryModel {
        let context = container.mainContext
        let category = CategoryModel(name: name, level: level, language: language)
        context.insert(category)
        try context.save()
        return category
    }
    
    // Update an existing category
    @MainActor func updateCategory(_ category: CategoryModel) throws {
        let context = container.mainContext
        // Assuming category is already fetched and modified
        try context.save()
    }
    
    // Delete a category
    @MainActor func deleteCategory(_ category: CategoryModel) throws {
        let context = container.mainContext
        context.delete(category)
        try context.save()
    }
    
    // Save context
    @MainActor func save() throws {
        let context = container.mainContext
        if context.hasChanges {
            try context.save()
        }
    }
}
