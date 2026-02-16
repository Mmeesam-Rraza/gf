import 'package:flutter/material.dart';
import '../models/student.dart';
import '../config/app_config.dart';

class RollCard extends StatelessWidget {
  final Student student;
  final String className;
  final VoidCallback onTap;
  final VoidCallback? onDelete;
  final bool showClassName;

  const RollCard({
    super.key,
    required this.student,
    required this.className,
    required this.onTap,
    this.onDelete,
    this.showClassName = false,
  });

  Color _getCardColor(int colorIndex, bool isDark) {
    if (colorIndex >= 0 && colorIndex < AppConfig.behaviorColors.length) {
      return Color(AppConfig.behaviorColors[colorIndex].color);
    }
    return isDark ? const Color(0xFF2d2d44) : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = _getCardColor(student.behaviorColor, isDark);
    final hasColor = student.behaviorColor != 0; // Fix: Assuming 0 is default/no color

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: cardColor,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: hasColor
                      ? Colors.white.withOpacity(0.2)
                      : (isDark ? Colors.white.withOpacity(0.1) : const Color(0xFF1a237e).withOpacity(0.1)),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    '${student.rollNumber}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: hasColor ? Colors.white : (isDark ? Colors.white : const Color(0xFF1a237e)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (student.name != null && student.name!.isNotEmpty) ? student.name! : 'Tap to add info',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: hasColor ? Colors.white : (isDark ? Colors.white : Colors.black87),
                      ),
                    ),
                    if (student.fatherName != null && student.fatherName!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        'S/O ${student.fatherName}',
                        style: TextStyle(
                          fontSize: 13,
                          color: hasColor ? Colors.white70 : (isDark ? Colors.white70 : Colors.grey[600]),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (student.isCustom)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: hasColor ? Colors.white.withOpacity(0.2) : Colors.orange.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('Custom', style: TextStyle(fontSize: 10, color: Colors.orange)),
                ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}