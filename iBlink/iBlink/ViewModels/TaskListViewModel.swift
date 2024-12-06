//
//  TaskViewModel.swift
//  iBlink
//
//  Created by Gerard Serra Rodríguez on 6/12/24.
//

import Foundation

class TaskListViewModel: ObservableObject {
    @Published var tasks: [TaskEntity] = []
    private let taskRepository = TaskRepository()
    
    // Fetch tasks from repository
    func fetchTasks() {
        tasks = taskRepository.fetchAllTasks()
    }
    
    // Add a new task
    func addTask(text: String) {
        taskRepository.addTask(text: text)
        fetchTasks() // Reload tasks after adding
    }
    
    // Delete a task
    func deleteTask(task: TaskEntity) {
        taskRepository.deleteTask(task: task)
        fetchTasks() // Reload tasks after deletion
    }
    
    // Toggle task completion
    func toggleTaskCompletion(task: TaskEntity) {
        taskRepository.toggleTaskCompletion(task: task)
        fetchTasks() // Reload tasks after toggling completion
    }
}

