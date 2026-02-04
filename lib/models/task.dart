class Task {
  String id;
  String title;
  String description;
  TaskPriority priority;
  TaskStatus status;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    TaskPriority? priority,
    TaskStatus? status,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      status: status ?? this.status,
    );
  }
}

enum TaskPriority {
  low, 
  medium,    
  high; 

  String get displayName {
    switch (this) {
      case TaskPriority.low:
        return 'Low';
      case TaskPriority.medium:
        return 'Medium';
      case TaskPriority.high:
        return 'High';
    }
  }
}

enum TaskStatus {
  toDo, 
  inProgress,  
  done;      

  String get displayName {
    switch (this) {
      case TaskStatus.toDo:
        return 'To Do';
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.done:
        return 'Done';
    }
  }
}