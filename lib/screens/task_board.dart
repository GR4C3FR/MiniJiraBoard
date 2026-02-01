// ==============================================================================
// SCREEN A - TASK BOARD (Main Screen)
// ==============================================================================
// This is the main screen users see. It shows:
// - Sprint Summary (To Do, In Progress, Done counts)
// - Summary Card (Total, Completed, Remaining)
// - Filter buttons
// - List of all tasks
// - Add Task button

import 'package:flutter/material.dart';  // Flutter UI components
import '../models/task.dart';            // Our Task model
import '../data/sample_tasks.dart';      // The 6 sample tasks
import 'task_form.dart';                  // Screen B (form screen)

// TaskBoard - The main screen widget
// StatefulWidget = A widget that CAN change over time (tasks can be added/edited/deleted)
class TaskBoard extends StatefulWidget {
  const TaskBoard({super.key});

  // This creates the "state" that holds changeable data
  @override
  State<TaskBoard> createState() => _TaskBoardState();
}

// _TaskBoardState - This holds the data that can change
// The underscore "_" means this class is private (only used in this file)
class _TaskBoardState extends State<TaskBoard> {
  // Our task list - stored in memory (RAM), not in a database
  // This list starts with 6 sample tasks from sample_tasks.dart
  List<Task> tasks = getSampleTasks();

  // build() - This creates the UI (what users see on screen)
  // This gets called every time setState() is called
  @override
  Widget build(BuildContext context) {
    // Scaffold - Provides basic app structure (app bar, body, floating button)
    return Scaffold(
      // App Bar - The bar at the top of the screen
      appBar: AppBar(
        title: const Text('MiniJira Board'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      
      // Body - The main content area
      // TODO: Replace this placeholder with actual UI (Sprint Summary, Task List, etc.)
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Task Board - Screen A',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Show how many tasks we have
            Text('Total tasks: ${tasks.length}'),
            const SizedBox(height: 20),
            const Text('UI will be implemented by team members'),
          ],
        ),
      ),
      
      // Floating Action Button (FAB) - The round + button at bottom right
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // When clicked, open the Task Form screen in Add mode
          _navigateToTaskForm(context);
        },
        tooltip: 'Add Task',  // Shows when you hover over the button
        child: const Icon(Icons.add),  // The + icon
      ),
    );
  }

  // ==============================================================================
  // NAVIGATION METHOD - Opens the Task Form screen
  // ==============================================================================
  // This method handles navigation to Screen B (TaskForm)
  // {Task? task} - The "?" means task is optional (can be null)
  //   - If task is null → Add mode (creating new task)
  //   - If task is provided → Edit mode (editing existing task)
  void _navigateToTaskForm(BuildContext context, {Task? task}) async {
    // Navigator.push() opens a new screen
    // "await" means we wait for the user to come back from the form
    // The form will return either a Task object or null
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskForm(task: task),  // Open TaskForm screen
      ),
    );

    // Check if the form returned a task (user clicked Save, not Cancel)
    if (result != null && result is Task) {
      // setState() tells Flutter "hey, data changed, please rebuild the UI!"
      setState(() {
        if (task != null) {
          // EDIT MODE - Update existing task
          // Find the task in our list by ID
          int index = tasks.indexWhere((t) => t.id == task.id);
          if (index != -1) {
            tasks[index] = result;  // Replace old task with updated task
          }
        } else {
          // ADD MODE - Add new task to the list
          tasks.add(result);
        }
      });
    }
    // If result is null (user clicked Cancel), do nothing
  }

  // ==============================================================================
  // DELETE METHOD - Removes a task from the list
  // ==============================================================================
  // Call this method when user clicks the delete button
  void _deleteTask(Task task) {
    setState(() {  // Tell Flutter to rebuild UI after deletion
      // removeWhere() removes all tasks that match the condition
      // In this case, remove the task with matching ID
      tasks.removeWhere((t) => t.id == task.id);
    });
  }
}
