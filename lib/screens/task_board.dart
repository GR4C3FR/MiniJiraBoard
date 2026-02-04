import 'package:flutter/material.dart';
import '../models/task.dart';
import '../data/sample_tasks.dart';
import '../widgets/stat_box.dart';
import '../widgets/task_card.dart';
import 'task_form.dart';

class TaskBoard extends StatefulWidget {
  const TaskBoard({super.key});

  @override
  State<TaskBoard> createState() => _TaskBoardState();
}

enum FilterOption { all, highPriority, done }

class _TaskBoardState extends State<TaskBoard> {
  List<Task> tasks = getSampleTasks();
  FilterOption selectedFilter = FilterOption.all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MiniJira Board',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0052CC),
        foregroundColor: Colors.white,
        elevation: 2,
      ),

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

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToTaskForm(context);
        },
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateToTaskForm(BuildContext context, {Task? task}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskForm(task: task),
      ),
    );

    if (result != null && result is Task) {
      setState(() {
        if (task != null) {
          int index = tasks.indexWhere((t) => t.id == task.id);
          if (index != -1) {
            tasks[index] = result;
          }
        } else {
          tasks.add(result);
        }
      });
    }
  }

  void _deleteTask(Task task) {
    setState(() {
      tasks.remove(task);
    });
  }

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
