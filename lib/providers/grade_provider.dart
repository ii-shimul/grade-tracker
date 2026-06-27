import 'package:flutter/material.dart';
import 'package:grade_tracker/models/subject.dart';

class GradeProvider with ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController markController = TextEditingController();

  final List<Subject> _subjects = [];
  ThemeMode _themeMode = ThemeMode.light;
  int _currentNavigationIndex = 0;

  void clearForm() {
    nameController.clear();
    markController.clear();
  }

  List<Subject> get subjects => List.unmodifiable(_subjects);
  ThemeMode get themeMode => _themeMode;
  int get currentNavigationIndex => _currentNavigationIndex;

  void setNavigationIndex(int index) {
    if (_currentNavigationIndex != index) {
      _currentNavigationIndex = index;
      notifyListeners();
    }
  }

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void addSubject(Subject subject) {
    _subjects.add(subject);
    notifyListeners();
  }

  void deleteSubject(int index) {
    if (index >= 0 && index < _subjects.length) {
      _subjects.removeAt(index);
      notifyListeners();
    }
  }

  int get totalSubjects => _subjects.length;

  double get averageMark {
    if (_subjects.isEmpty) return 0.0;
    final totalMarks = _subjects.map((s) => s.mark).reduce((a, b) => a + b);
    return totalMarks / _subjects.length;
  }

  List<Subject> get passingSubjects {
    return _subjects.where((s) => s.grade != 'F').toList();
  }

  int get passingSubjectsCount => passingSubjects.length;

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
