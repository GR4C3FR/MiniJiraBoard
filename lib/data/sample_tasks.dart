// ==============================================================================
// SAMPLE TASKS - Initial data for testing
// ==============================================================================
// This file provides 6 pre-made tasks so we have something to display
// when the app first opens. No database needed!

import '../models/task.dart';

// Function that returns a list of 6 sample tasks
// We call this from TaskBoard to get our initial task list
List<Task> getSampleTasks() {
  return [
    // Task 1 - HIGH priority, To Do
    Task(
      id: '1',  // Unique ID for this task
      title: 'Fix login bug',
      description: 'Users can\'t login on mobile devices. Need to check authentication flow and fix token validation issues.',
      priority: TaskPriority.high,  // This is urgent!
      status: TaskStatus.toDo,      // Not started yet
    ),
    
    // Task 2 - MEDIUM priority, In Progress
    Task(
      id: '2',
      title: 'Update UI spacing',
      description: 'Align header containers evenly and improve overall spacing consistency across all screens.',
      priority: TaskPriority.medium,  // Moderately important
      status: TaskStatus.inProgress,   // Currently being worked on
    ),
    
    // Task 3 - MEDIUM priority, In Progress
    Task(
      id: '3',
      title: 'Write API documentation',
      description: 'Create comprehensive API documentation for all endpoints including request/response examples.',
      priority: TaskPriority.medium,
      status: TaskStatus.inProgress,
    ),
    
    // Task 4 - LOW priority, To Do
    Task(
      id: '4',
      title: 'Implement dark mode',
      description: 'Add dark mode theme support with toggle switch in settings. Should persist user preference.',
      priority: TaskPriority.low,   // Not urgent
      status: TaskStatus.toDo,
    ),
    
    // Task 5 - HIGH priority, To Do
    Task(
      id: '5',
      title: 'Optimize database queries',
      description: 'Several queries are running slow. Need to add indexes and optimize N+1 query problems.',
      priority: TaskPriority.high,
      status: TaskStatus.toDo,
    ),
    
    // Task 6 - MEDIUM priority, Done
    Task(
      id: '6',
      title: 'Setup CI/CD pipeline',
      description: 'Configure automated testing and deployment pipeline using GitHub Actions for continuous integration.',
      priority: TaskPriority.medium,
      status: TaskStatus.done,  // This one is completed!
    ),

    // Testing Task
    Task(
      id: '7',
      title: 'Setup CI/CD pipeline',
      description: 'Configure automated testing and deployment pipeline using GitHub Actions for continuous integration.',
      priority: TaskPriority.medium,
      status: TaskStatus.done,  // This one is completed!
    ),
  ];
}
