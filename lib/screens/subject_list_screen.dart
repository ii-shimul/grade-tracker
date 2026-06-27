import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grade_tracker/providers/grade_provider.dart';
import 'package:grade_tracker/models/subject.dart';

class SubjectListScreen extends StatelessWidget {
  const SubjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<GradeProvider>();
    final subjects = provider.subjects;

    if (subjects.isEmpty) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.assignment_late_rounded,
                  size: 80,
                  color: theme.colorScheme.primary.withOpacity(0.4),
                ),
                const SizedBox(height: 16),
                Text(
                  'No Subjects Added Yet',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Switch to the "Add Subject" tab to start adding your classes and grades.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onBackground.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          final subject = subjects[index];

          return Dismissible(
            key: ValueKey(subject),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              final deletedSubjectName = subject.name;
              provider.deleteSubject(index);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Deleted "$deletedSubjectName"',
                    style: TextStyle(color: theme.colorScheme.onError),
                  ),
                  backgroundColor: theme.colorScheme.error,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            background: Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.delete_sweep_rounded,
                color: theme.colorScheme.onErrorContainer,
                size: 28,
              ),
            ),
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                leading: CircleAvatar(
                  backgroundColor: theme.colorScheme.primaryContainer,
                  child: Icon(
                    Icons.school_rounded,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                title: Text(
                  subject.name,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Mark: ${subject.mark}/100',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ),
                trailing: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: _getGradeColor(context, subject.grade),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: _getGradeColor(context, subject.grade).withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    subject.grade,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: _getOnGradeColor(context, subject.grade),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getGradeColor(BuildContext context, String grade) {
    final colorScheme = Theme.of(context).colorScheme;
    switch (grade) {
      case 'A':
        return colorScheme.primary;
      case 'B':
        return colorScheme.secondary;
      case 'C':
        return colorScheme.tertiary;
      default:
        return colorScheme.error;
    }
  }

  Color _getOnGradeColor(BuildContext context, String grade) {
    final colorScheme = Theme.of(context).colorScheme;
    switch (grade) {
      case 'A':
        return colorScheme.onPrimary;
      case 'B':
        return colorScheme.onSecondary;
      case 'C':
        return colorScheme.onTertiary;
      default:
        return colorScheme.onError;
    }
  }
}
