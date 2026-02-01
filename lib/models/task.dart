// ==============================================================================
// TASK MODEL - This represents a single task in our app
// ==============================================================================
// Think of this like a template or blueprint for what a task looks like.
// Every task will have: id, title, description, priority, and status

class Task {
  // Fields (properties) that every task must have:
  String id;                    // Unique identifier (like "1", "2", "3")
  String title;                 // Task name (e.g., "Fix login bug")
  String description;           // Detailed explanation of the task
  TaskPriority priority;        // How important: Low, Medium, or High
  TaskStatus status;            // Current state: To Do, In Progress, or Done

  // Constructor - This is how we create a new Task
  // The "required" keyword means you MUST provide these values
  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
  });

  // copyWith() - Helper method to create a modified copy of a task
  // This is useful when editing - you can keep most values the same
  // and only change what you need. The "?" means the parameter is optional.
  Task copyWith({
    String? id,
    String? title,
    String? description,
    TaskPriority? priority,
    TaskStatus? status,
  }) {
    return Task(
      id: id ?? this.id,                          // Use new id if provided, otherwise keep old one
      title: title ?? this.title,                  // Use new title if provided, otherwise keep old one
      description: description ?? this.description, // And so on...
      priority: priority ?? this.priority,
      status: status ?? this.status,
    );
  }
}

// ==============================================================================
// TASK PRIORITY - How important is this task?
// ==============================================================================
// Enum = A fixed set of choices. Tasks can ONLY be low, medium, or high priority.

enum TaskPriority {
  low,        // Not urgent
  medium,     // Moderately important
  high;       // Very urgent/important

  // displayName - Converts the enum value to a nice readable string
  // Example: TaskPriority.low.displayName returns "Low"
  // This is useful for showing in the UI
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

// ==============================================================================
// TASK STATUS - What stage is this task in?
// ==============================================================================
// Enum = A fixed set of choices. Tasks can ONLY be in these three states.

enum TaskStatus {
  toDo,         // Not started yet
  inProgress,   // Currently being worked on
  done;         // Completed

  // displayName - Converts the enum value to a nice readable string
  // Example: TaskStatus.toDo.displayName returns "To Do"
  // This is useful for showing in the UI
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