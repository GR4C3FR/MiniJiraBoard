import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TaskCard({
    super.key,
    required this.task,
    required this.onEdit,
    required this.onDelete,
  });

  Color _priorityColor(TaskPriority p) {
    switch (p) {
      case TaskPriority.high:
        return Colors.redAccent;
      case TaskPriority.medium:
        return Colors.orangeAccent;
      case TaskPriority.low:
        return Colors.green;
    }
  }

  Color _statusColor(TaskStatus s) {
    switch (s) {
      case TaskStatus.toDo:
        return const Color(0xFF5E6C84);
      case TaskStatus.inProgress:
        return const Color(0xFF0052CC);
      case TaskStatus.done:
        return const Color(0xFF00875A);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey[200]!, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    task.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF172B4D),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit_outlined, size: 20),
                  color: const Color(0xFF0052CC),
                  tooltip: 'Edit',
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete_outline, size: 20),
                  color: Colors.red[400],
                  tooltip: 'Delete',
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              task.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF5E6C84),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: _priorityColor(task.priority).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: _priorityColor(task.priority).withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.flag,
                        size: 14,
                        color: _priorityColor(task.priority),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        task.priority.displayName,
                        style: TextStyle(
                          fontSize: 12,
                          color: _priorityColor(task.priority),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: _statusColor(task.status).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: _statusColor(task.status).withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        task.status == TaskStatus.done
                            ? Icons.check_circle
                            : task.status == TaskStatus.inProgress
                            ? Icons.hourglass_bottom
                            : Icons.radio_button_unchecked,
                        size: 14,
                        color: _statusColor(task.status),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        task.status.displayName,
                        style: TextStyle(
                          fontSize: 12,
                          color: _statusColor(task.status),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
