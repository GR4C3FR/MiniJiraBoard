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

import 'package:flutter/material.dart';  // Flutter UI components
import '../models/task.dart';            // Our Task model

// TaskForm - The form screen widget
// StatefulWidget because the form inputs can change
class TaskForm extends StatefulWidget {
  final Task? task;  // Optional: if null = Add mode, if provided = Edit mode

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
  TaskPriority _selectedPriority = TaskPriority.medium;  // Default: Medium
  TaskStatus _selectedStatus = TaskStatus.toDo;          // Default: To Do

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
    _titleController.dispose();      // Clean up title controller
    _descriptionController.dispose(); // Clean up description controller
    super.dispose();
  }

  // build() - Creates the UI for this screen
  @override
  Widget build(BuildContext context) {
    // Check what mode we're in
    final isEditMode = widget.task != null;  // true if editing, false if adding

    return Scaffold(
      // App Bar - Top bar with title and back button
      appBar: AppBar(
        // Show different title depending on mode
        title: Text(isEditMode ? 'Edit Task' : 'Add Task'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      
      // Body - Main content area
      // TODO: Replace this placeholder with actual form UI
      // (TextFields for title/description, Dropdowns for priority/status,
      //  character counter, color changes, etc.)
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),  // Add space around content
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isEditMode ? 'Edit Task - Screen B' : 'Add Task - Screen B',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text('Form UI will be implemented by team members'),
              const SizedBox(height: 20),
              
              // Save/Update button
              ElevatedButton(
                onPressed: _saveTask,  // Call _saveTask() when clicked
                child: Text(isEditMode ? 'Update' : 'Save'),
              ),
              
              const SizedBox(height: 10),
              
              // Cancel button
              TextButton(
                onPressed: () {
                  // Go back to previous screen without saving
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==============================================================================
  // SAVE METHOD - Creates or updates a task
  // ==============================================================================
  // This method is called when user clicks the Save/Update button
  void _saveTask() {
    // Create a Task object with the form data
    final task = Task(
      // ID: If editing, keep the old ID. If adding, generate a new unique ID
      // We use the current timestamp as a simple unique ID generator
      id: widget.task?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      
      // Title: Use what's in the text field, or default if empty
      title: _titleController.text.isEmpty ? 'New Task' : _titleController.text,
      
      // Description: Use what's in the text field, or default if empty
      description: _descriptionController.text.isEmpty ? 'No description' : _descriptionController.text,
      
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
