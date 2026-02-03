import 'package:flutter/material.dart';

class StatBox extends StatelessWidget {
  final String label;
  final int count;

  const StatBox({super.key, required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF0052CC).withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF0052CC).withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF172B4D),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$count',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0052CC),
            ),
          ),
        ],
      ),
    );
  }
}
