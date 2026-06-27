class Subject {
  final String name;
  final int _mark;

  Subject({
    required this.name,
    required int mark,
  }) : _mark = mark;

  int get mark => _mark;

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
