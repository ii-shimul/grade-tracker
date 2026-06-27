import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:grade_tracker/models/subject.dart';
import 'package:grade_tracker/providers/grade_provider.dart';

void main() {
  group('GradeProvider Tests', () {
    test('Initial values are correct', () {
      final provider = GradeProvider();
      expect(provider.subjects.isEmpty, true);
      expect(provider.themeMode, ThemeMode.light);
      expect(provider.currentNavigationIndex, 0);
      expect(provider.totalSubjects, 0);
      expect(provider.averageMark, 0.0);
      expect(provider.passingSubjectsCount, 0);
      expect(provider.overallGrade, '-');
    });

    test('Theme toggles correctly', () {
      final provider = GradeProvider();
      expect(provider.themeMode, ThemeMode.light);
      provider.toggleTheme();
      expect(provider.themeMode, ThemeMode.dark);
      provider.toggleTheme();
      expect(provider.themeMode, ThemeMode.light);
    });

    test('Navigation index updates correctly', () {
      final provider = GradeProvider();
      provider.setNavigationIndex(2);
      expect(provider.currentNavigationIndex, 2);
    });

    test('Adding and removing subjects updates state and calculations', () {
      final provider = GradeProvider();
      final math = Subject(name: 'Mathematics', mark: 90); // Grade A
      final physics = Subject(name: 'Physics', mark: 60);  // Grade C
      final art = Subject(name: 'Art', mark: 40);          // Grade F (Failing)

      // Add math
      provider.addSubject(math);
      expect(provider.totalSubjects, 1);
      expect(provider.subjects.first.name, 'Mathematics');
      expect(provider.averageMark, 90.0);
      expect(provider.passingSubjectsCount, 1);
      expect(provider.overallGrade, 'A');

      // Add physics
      provider.addSubject(physics);
      expect(provider.totalSubjects, 2);
      expect(provider.averageMark, 75.0); // (90 + 60) / 2
      expect(provider.passingSubjectsCount, 2);
      expect(provider.overallGrade, 'B'); // 75 >= 65 is B

      // Add art (failing)
      provider.addSubject(art);
      expect(provider.totalSubjects, 3);
      expect(provider.averageMark, 63.333333333333336); // (90 + 60 + 40) / 3
      expect(provider.passingSubjectsCount, 2); // math and physics are passing, art is F
      expect(provider.overallGrade, 'C'); // 63.33 >= 50 is C

      // Delete physics (index 1)
      provider.deleteSubject(1);
      expect(provider.totalSubjects, 2);
      expect(provider.subjects[0].name, 'Mathematics');
      expect(provider.subjects[1].name, 'Art');
      expect(provider.averageMark, 65.0); // (90 + 40) / 2
      expect(provider.passingSubjectsCount, 1); // math passing, art failing
      expect(provider.overallGrade, 'B'); // 65 >= 65 is B
    });
  });
}
