import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TaskCard({super.key, required this.task, required this.onEdit, required this.onDelete});

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
        return Colors.grey;
      case TaskStatus.inProgress:
        return Colors.blueAccent;
      case TaskStatus.done:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(onPressed: onEdit, icon: const Icon(Icons.edit, size: 20)),
                IconButton(onPressed: onDelete, icon: const Icon(Icons.delete, size: 20)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Priority:', style: TextStyle(fontSize: 12, color: Colors.black54)),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _priorityColor(task.priority).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    task.priority.displayName,
                    style: TextStyle(fontSize: 12, color: _priorityColor(task.priority), fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(width: 8),
                const Text('Status:', style: TextStyle(fontSize: 12, color: Colors.black54)),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _statusColor(task.status).withOpacity(0.18),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    task.status.displayName,
                    style: TextStyle(fontSize: 12, color: _statusColor(task.status), fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              task.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
