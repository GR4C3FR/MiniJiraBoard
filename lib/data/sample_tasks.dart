import '../models/task.dart';

List<Task> getSampleTasks() {
  return [
    Task(
      id: '1', 
      title: 'Fix login bug',
      description: 'Users can\'t login on mobile devices. Need to check authentication flow and fix token validation issues.',
      priority: TaskPriority.high,
      status: TaskStatus.toDo,
    ),
    
    Task(
      id: '2',
      title: 'Update UI spacing',
      description: 'Align header containers evenly and improve overall spacing consistency across all screens.',
      priority: TaskPriority.medium,
      status: TaskStatus.inProgress,
    ),
    
    Task(
      id: '3',
      title: 'Write API documentation',
      description: 'Create comprehensive API documentation for all endpoints including request/response examples.',
      priority: TaskPriority.medium,
      status: TaskStatus.inProgress,
    ),
    
    Task(
      id: '4',
      title: 'Implement dark mode',
      description: 'Add dark mode theme support with toggle switch in settings. Should persist user preference.',
      priority: TaskPriority.low,
      status: TaskStatus.toDo,
    ),
    
    Task(
      id: '5',
      title: 'Optimize database queries',
      description: 'Several queries are running slow. Need to add indexes and optimize N+1 query problems.',
      priority: TaskPriority.high,
      status: TaskStatus.toDo,
    ),
    
    Task(
      id: '6',
      title: 'Setup CI/CD pipeline',
      description: 'Configure automated testing and deployment pipeline using GitHub Actions for continuous integration.',
      priority: TaskPriority.medium,
      status: TaskStatus.done,
    ),

    Task(
      id: '7',
      title: 'Setup CI/CD pipeline',
      description: 'Configure automated testing and deployment pipeline using GitHub Actions for continuous integration.',
      priority: TaskPriority.medium,
      status: TaskStatus.done,
    ),
  ];
}
