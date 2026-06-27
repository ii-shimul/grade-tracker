import 'package:flutter_test/flutter_test.dart';
import 'package:grade_tracker/models/subject.dart';

void main() {
  group('Subject Model Tests', () {
    test('Subject stores name and mark correctly', () {
      final subject = Subject(name: 'Mathematics', mark: 85);
      expect(subject.name, 'Mathematics');
      expect(subject.mark, 85);
    });

    test('Subject calculates grade A correctly (>= 80)', () {
      final subject80 = Subject(name: 'English', mark: 80);
      final subject99 = Subject(name: 'Physics', mark: 99);
      expect(subject80.grade, 'A');
      expect(subject99.grade, 'A');
    });

    test('Subject calculates grade B correctly (65 to 79)', () {
      final subject65 = Subject(name: 'Chemistry', mark: 65);
      final subject79 = Subject(name: 'History', mark: 79);
      expect(subject65.grade, 'B');
      expect(subject79.grade, 'B');
    });

    test('Subject calculates grade C correctly (50 to 64)', () {
      final subject50 = Subject(name: 'Biology', mark: 50);
      final subject64 = Subject(name: 'Geography', mark: 64);
      expect(subject50.grade, 'C');
      expect(subject64.grade, 'C');
    });

    test('Subject calculates grade F correctly (< 50)', () {
      final subject49 = Subject(name: 'Art', mark: 49);
      final subject0 = Subject(name: 'Music', mark: 0);
      expect(subject49.grade, 'F');
      expect(subject0.grade, 'F');
    });
  });
}
