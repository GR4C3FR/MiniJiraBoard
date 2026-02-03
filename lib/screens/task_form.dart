// ==============================================================================
// SCREEN B - TASK FORM (Add/Edit Screen)
// ==============================================================================
// This screen is used for BOTH:
// - Adding a new task (when task = null)
// - Editing an existing task (when task is provided)
//
// It includes:
// - Title input field
// - Description input field (with character counter)
// - Priority dropdown (Low, Medium, High)
// - Status dropdown (To Do, In Progress, Done)
// - Save and Cancel buttons

import 'package:flutter/material.dart'; // Flutter UI components
import '../models/task.dart'; // Our Task model

// TaskForm - The form screen widget
// StatefulWidget because the form inputs can change
class TaskForm extends StatefulWidget {
  final Task? task; // Optional: if null = Add mode, if provided = Edit mode

  const TaskForm({super.key, this.task});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

// _TaskFormState - Holds the form's changeable data
class _TaskFormState extends State<TaskForm> {
  // Form key - Used to validate the form
  final _formKey = GlobalKey<FormState>();

  // Text controllers - Manage what's typed in the text fields
  // Think of these like variables that connect to TextField widgets
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  // Dropdown selections - Store the currently selected priority and status
  TaskPriority _selectedPriority = TaskPriority.medium; // Default: Medium
  TaskStatus _selectedStatus = TaskStatus.toDo; // Default: To Do

  // initState() - Runs ONCE when this screen is first created
  // This is where we set up initial values
  @override
  void initState() {
    super.initState();

    // Check if we're in EDIT mode (task was provided)
    if (widget.task != null) {
      // Fill in the form fields with the existing task's data
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _selectedPriority = widget.task!.priority;
      _selectedStatus = widget.task!.status;
    }
    // If widget.task is null (ADD mode), fields stay empty/default
  }

  // dispose() - Clean up when this screen is closed
  // IMPORTANT: Always dispose controllers to prevent memory leaks!
  @override
  void dispose() {
    _titleController.dispose(); // Clean up title controller
    _descriptionController.dispose(); // Clean up description controller
    super.dispose();
  }

  // build() - Creates the UI for this screen
  @override
  Widget build(BuildContext context) {
    // Check what mode we're in
    final isEditMode = widget.task != null; // true if editing, false if adding

    return Scaffold(
      // App Bar - Top bar with title and back button
      appBar: AppBar(
        // Show different title depending on mode
        title: Text(isEditMode ? 'Edit Task' : 'Add Task'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),

      // Body - Main content area
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Add space around content
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Title field
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Task Title',
                    hintText: 'Enter task title',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.title),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a task title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Description field with character counter
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        hintText: 'Enter task description',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.description),
                        alignLabelWithHint: true,
                      ),
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a task description';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        // Trigger rebuild to update character counter
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 8),
                    // Character counter
                    _buildCharacterCounter(),
                  ],
                ),
                const SizedBox(height: 16),

                // Priority dropdown
                DropdownButtonFormField<TaskPriority>(
                  value: _selectedPriority,
                  decoration: const InputDecoration(
                    labelText: 'Priority',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.flag),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a priority';
                    }
                    return null;
                  },
                  items: TaskPriority.values.map((priority) {
                    return DropdownMenuItem(
                      value: priority,
                      child: Text(priority.displayName),
                    );
                  }).toList(),
                  onChanged: (TaskPriority? value) {
                    if (value != null) {
                      setState(() {
                        _selectedPriority = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),

                // Status dropdown
                DropdownButtonFormField<TaskStatus>(
                  value: _selectedStatus,
                  decoration: const InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.check_circle),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a status';
                    }
                    return null;
                  },
                  items: TaskStatus.values.map((status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(status.displayName),
                    );
                  }).toList(),
                  onChanged: (TaskStatus? value) {
                    if (value != null) {
                      setState(() {
                        _selectedStatus = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 24),

                // Save/Update button
                ElevatedButton.icon(
                  onPressed: _isDescriptionExceedingLimit() ? null : _saveTask,
                  icon: Icon(isEditMode ? Icons.update : Icons.save),
                  label: Text(isEditMode ? 'Update Task' : 'Save Task'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
                const SizedBox(height: 8),

                // Cancel button
                TextButton.icon(
                  onPressed: () {
                    // Go back to previous screen without saving
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                  label: const Text('Cancel'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==============================================================================
  // CHARACTER COUNTER BUILDER - Creates the character counter UI with colors
  // ==============================================================================
  Widget _buildCharacterCounter() {
    const maxCharacters = 120;
    int currentCharacters = _descriptionController.text.length;

    // Determine color and status based on character count
    Color counterColor;
    String statusText;
    if (currentCharacters <= 40) {
      // 0-40 characters → Safe
      counterColor = Colors.green;
      statusText = 'Safe';
    } else if (currentCharacters <= 80) {
      // 41-80 characters → Warning
      counterColor = Colors.orange;
      statusText = 'Warning';
    } else if (currentCharacters <= 120) {
      // 81-120 characters → Danger
      counterColor = Colors.red;
      statusText = 'Danger';
    } else {
      // Over 120 characters → Danger (exceeding limit)
      counterColor = Colors.red;
      statusText = 'Danger';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Characters: $currentCharacters / $maxCharacters',
          style: TextStyle(
            color: counterColor,
            fontSize: 13,
            fontWeight: currentCharacters > maxCharacters
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Status: $statusText',
          style: TextStyle(
            color: counterColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // ==============================================================================
  // VALIDATION METHOD - Checks if description exceeds character limit
  // ==============================================================================
  bool _isDescriptionExceedingLimit() {
    const maxCharacters = 120;
    return _descriptionController.text.length > maxCharacters;
  }

  // ==============================================================================
  // SAVE METHOD - Creates or updates a task
  // ==============================================================================
  // This method is called when user clicks the Save/Update button
  void _saveTask() {
    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Check if description exceeds character limit
    if (_isDescriptionExceedingLimit()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Description cannot exceed 120 characters (${_descriptionController.text.length} characters)',
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Create a Task object with the form data
    final task = Task(
      // ID: If editing, keep the old ID. If adding, generate a new unique ID
      // We use the current timestamp as a simple unique ID generator
      id: widget.task?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),

      // Title: Use what's in the text field
      title: _titleController.text,

      // Description: Use what's in the text field
      description: _descriptionController.text,

      // Priority and Status: Use the selected dropdown values
      priority: _selectedPriority,
      status: _selectedStatus,
    );

    // Navigator.pop() goes back to the previous screen
    // The second parameter (task) is the RESULT we're returning
    // TaskBoard will receive this task object and add/update it in the list
    Navigator.pop(context, task);
  }
}
