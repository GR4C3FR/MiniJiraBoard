// ==============================================================================
// SCREEN A - TASK BOARD (Main Screen)
// ==============================================================================
// This is the main screen users see. It shows:
// - Sprint Summary (To Do, In Progress, Done counts)
// - Summary Card (Total, Completed, Remaining)
// - Filter buttons
// - List of all tasks
// - Add Task button

import 'package:flutter/material.dart'; // Flutter UI components
import '../models/task.dart'; // Our Task model
import '../data/sample_tasks.dart';
import '../widgets/stat_box.dart';
import '../widgets/task_card.dart';
import 'task_form.dart';

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
enum FilterOption { all, highPriority, done }

class _TaskBoardState extends State<TaskBoard> {
  // Our task list - stored in memory (RAM), not in a database
  // This list starts with 6 sample tasks from sample_tasks.dart
  List<Task> tasks = getSampleTasks();
  FilterOption selectedFilter = FilterOption.all;

  // build() - This creates the UI (what users see on screen)
  // This gets called every time setState() is called
  @override
  Widget build(BuildContext context) {
    // Scaffold - Provides basic app structure (app bar, body, floating button)
    return Scaffold(
      // App Bar - The bar at the top of the screen
      appBar: AppBar(
        title: const Text(
          'MiniJira Board',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0052CC),
        foregroundColor: Colors.white,
        elevation: 2,
      ),

      // Body - The main content area
      // TODO: Replace this placeholder with actual UI (Sprint Summary, Task List, etc.)
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              Builder(
                builder: (context) {
                  final todoCount = tasks
                      .where((t) => t.status == TaskStatus.toDo)
                      .length;
                  final inProgressCount = tasks
                      .where((t) => t.status == TaskStatus.inProgress)
                      .length;
                  final doneCount = tasks
                      .where((t) => t.status == TaskStatus.done)
                      .length;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: StatBox(label: 'To Do', count: todoCount),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: StatBox(
                              label: 'In Progress',
                              count: inProgressCount,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: StatBox(label: 'Done', count: doneCount),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Total Tasks',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      '${tasks.length}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Completed',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      '$doneCount',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text(
                                      'Remaining',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      '${todoCount + inProgressCount}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                },
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.filter_list,
                    size: 20,
                    color: Color(0xFF0052CC),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Quick Filters:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF172B4D),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildFilterChip(
                    label: 'All',
                    icon: Icons.list,
                    isSelected: selectedFilter == FilterOption.all,
                    onTap: () =>
                        setState(() => selectedFilter = FilterOption.all),
                  ),
                  _buildFilterChip(
                    label: 'High Priority',
                    icon: Icons.priority_high,
                    isSelected: selectedFilter == FilterOption.highPriority,
                    onTap: () => setState(
                      () => selectedFilter = FilterOption.highPriority,
                    ),
                  ),
                  _buildFilterChip(
                    label: 'Done',
                    icon: Icons.check_circle,
                    isSelected: selectedFilter == FilterOption.done,
                    onTap: () =>
                        setState(() => selectedFilter = FilterOption.done),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Builder(
                builder: (context) {
                  // Apply filtering logic
                  final filteredTasks = _getFilteredTasks();

                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: filteredTasks.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.inbox_outlined,
                                  size: 64,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No tasks found',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  _getEmptyStateMessage(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: filteredTasks.length,
                            itemBuilder: (context, index) {
                              final task = filteredTasks[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: TaskCard(
                                  task: task,
                                  onEdit: () {
                                    _navigateToTaskForm(context, task: task);
                                  },
                                  onDelete: () {
                                    _showDeleteDialog(context, task);
                                  },
                                ),
                              );
                            },
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),

      // Floating Action Button (FAB) - The round + button at bottom right
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // When clicked, open the Task Form screen in Add mode
          _navigateToTaskForm(context);
        },
        tooltip: 'Add Task', // Shows when you hover over the button
        child: const Icon(Icons.add), // The + icon
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
        builder: (context) => TaskForm(task: task), // Open TaskForm screen
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
            tasks[index] = result; // Replace old task with updated task
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
    setState(() {
      tasks.remove(task);
    });
  }

  // ==============================================================================
  // FILTER HELPER - Gets filtered tasks based on selected filter
  // ==============================================================================
  List<Task> _getFilteredTasks() {
    switch (selectedFilter) {
      case FilterOption.all:
        return tasks;
      case FilterOption.highPriority:
        return tasks.where((t) => t.priority == TaskPriority.high).toList();
      case FilterOption.done:
        return tasks.where((t) => t.status == TaskStatus.done).toList();
    }
  }

  // ==============================================================================
  // EMPTY STATE MESSAGE - Returns appropriate message based on filter
  // ==============================================================================
  String _getEmptyStateMessage() {
    switch (selectedFilter) {
      case FilterOption.all:
        return 'Create your first task using the + button';
      case FilterOption.highPriority:
        return 'No high priority tasks';
      case FilterOption.done:
        return 'No completed tasks yet';
    }
  }

  // ==============================================================================
  // FILTER CHIP BUILDER - Creates a styled filter chip
  // ==============================================================================
  Widget _buildFilterChip({
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0052CC) : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF0052CC) : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : Colors.grey[700],
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? Colors.white : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==============================================================================
  // DELETE DIALOG - Shows confirmation dialog before deleting
  // ==============================================================================
  void _showDeleteDialog(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: Text('Are you sure you want to delete "${task.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _deleteTask(task);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Task deleted'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
