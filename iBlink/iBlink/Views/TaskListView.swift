//
//  TaskListView.swift
//  iBlink
//
//  Created by Gerard Serra Rodríguez on 6/12/24.
//

import SwiftUI

struct TaskListView: View {
    @StateObject private var viewModel = TaskListViewModel()
    
    @State private var newTaskText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                // Input field for new task
                HStack {
                    TextField("Enter new task", text: $newTaskText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button(action: {
                        if !newTaskText.isEmpty {
                            viewModel.addTask(text: newTaskText)
                            newTaskText = "" // Clear the input after adding the task
                        }
                    }) {
                        Text("Add")
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }
                    .padding()
                }
                
                // Task List
                List {
                    ForEach(viewModel.tasks, id: \.taskId) { task in
                        HStack {
                            Text(task.text ?? "No Title")
                                .strikethrough(task.isCompleted, color: .gray)
                            
                            Spacer()
                            
                            Button(action: {
                                viewModel.toggleTaskCompletion(task: task)
                            }) {
                                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(task.isCompleted ? .green : .gray)
                            }
                            
                            Button(action: {
                                viewModel.deleteTask(task: task)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .onDelete(perform: delete)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("iBlink Tasks")
        }
        .onAppear {
            viewModel.fetchTasks()
        }
    }
    
    private func delete(at offsets: IndexSet) {
        offsets.forEach { index in
            let task = viewModel.tasks[index]
            viewModel.deleteTask(task: task)
        }
    }
}

#Preview {
    TaskListView()
}
