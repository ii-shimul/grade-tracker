class Subject {
  final String name;
  final int _mark;

  Subject({
    required this.name,
    required int mark,
  }) : _mark = mark;

  /// Getter to retrieve the private mark field
  int get mark => _mark;

  /// Getter for the letter grade based on the mark:
  /// A (>= 80), B (>= 65), C (>= 50), F (otherwise)
  String get grade {
    if (_mark >= 80) {
      return 'A';
    } else if (_mark >= 65) {
      return 'B';
    } else if (_mark >= 50) {
      return 'C';
    } else {
      return 'F';
    }
  }
}
