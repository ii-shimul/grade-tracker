import 'package:flutter/material.dart';
import 'package:grade_tracker/models/subject.dart';

class GradeProvider with ChangeNotifier {
  // Form input controllers to prevent recreating them on widget rebuilds
  final TextEditingController nameController = TextEditingController();
  final TextEditingController markController = TextEditingController();

  // Subjects list
  final List<Subject> _subjects = [];

  // Theme mode
  ThemeMode _themeMode = ThemeMode.light;

  // Active navigation index
  int _currentNavigationIndex = 0;

  void clearForm() {
    nameController.clear();
    markController.clear();
  }

  // Getters
  List<Subject> get subjects => List.unmodifiable(_subjects);
  ThemeMode get themeMode => _themeMode;
  int get currentNavigationIndex => _currentNavigationIndex;

  // Set navigation index
  void setNavigationIndex(int index) {
    if (_currentNavigationIndex != index) {
      _currentNavigationIndex = index;
      notifyListeners();
    }
  }

  // Toggle theme mode
  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  // Add subject
  void addSubject(Subject subject) {
    _subjects.add(subject);
    notifyListeners();
  }

  // Delete subject
  void deleteSubject(int index) {
    if (index >= 0 && index < _subjects.length) {
      _subjects.removeAt(index);
      notifyListeners();
    }
  }

  // Computed Properties (Using .map() and .where() functional programming patterns)
  
  /// Get total number of subjects
  int get totalSubjects => _subjects.length;

  /// Calculate the average mark using .map()
  double get averageMark {
    if (_subjects.isEmpty) return 0.0;
    final totalMarks = _subjects.map((s) => s.mark).reduce((a, b) => a + b);
    return totalMarks / _subjects.length;
  }

  /// Get passing subjects using .where()
  List<Subject> get passingSubjects {
    return _subjects.where((s) => s.grade != 'F').toList();
  }

  /// Get total passing subjects count
  int get passingSubjectsCount => passingSubjects.length;

  /// Calculate the overall grade based on the average mark
  String get overallGrade {
    if (_subjects.isEmpty) return '-';
    final avg = averageMark;
    if (avg >= 80) return 'A';
    if (avg >= 65) return 'B';
    if (avg >= 50) return 'C';
    return 'F';
  }

  @override
  void dispose() {
    nameController.dispose();
    markController.dispose();
    super.dispose();
  }
}
