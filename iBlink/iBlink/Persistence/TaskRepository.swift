//
//  TaskRepository.swift
//  iBlink
//
//  Created by Gerard Serra Rodríguez on 6/12/24.
//

import Foundation
import CoreData

class TaskRepository {
    private let context = PersistenceController.shared.context
    
    // Fetch all tasks
    func fetchAllTasks() -> [TaskEntity] {
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch tasks: \(error.localizedDescription)")
            return []
        }
    }
    
    // Add a new task
    func addTask(text: String) {
        let newTask = TaskEntity(context: context)
        newTask.taskId = UUID()
        newTask.text = text
        newTask.isCompleted = false
        newTask.createdAt = Date()
        saveContext()
    }
    
    // Delete a task
    func deleteTask(task: TaskEntity) {
        context.delete(task)
        saveContext()
    }
    
    // Toggle completion state
    func toggleTaskCompletion(task: TaskEntity) {
        task.isCompleted.toggle()
        saveContext()
    }
    
    // Save context
    private func saveContext() {
        PersistenceController.shared.saveContext()
    }
}

