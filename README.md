# Student Grade Tracker App

A Flutter application for students to track their academic subjects, record marks, view letter grades, and view their performance summaries in real-time. Built with Material 3 design and Provider state management.

## Features

- **Add Subject Form:** Simple form to add subjects with name and mark, including input validation.
- **Subject List:** Scrollable list displaying the name, mark, and grade for each subject with swipe-to-delete support.
- **Live Summary:** Visual overview displaying total subjects, average marks, overall grade, and a pass rate indicator updating live.
- **Theme Toggle:** Dynamic light and dark mode custom themes.

## Technical Details

- **State Management:** Fully implemented using `Provider`. Zero `setState` calls are used in the application.
- **Data Model:** Encapsulated in the `Subject` model with private marks and letter grade calculation rules.
- **UI Design:** Custom Material 3 themes. No hardcoded colors; all color schemes are derived dynamically from context.
- **Testing:** Comprehensive unit and widget tests covering model validations, state modifications, navigation, and page rendering.

## How to Run

1. Make sure you have Flutter installed on your system.
2. Clone the repository:
   ```bash
   git clone git@github.com:ii-shimul/grade-tracker.git
   cd grade-tracker
   ```
3. Fetch dependencies:
   ```bash
   flutter pub get
   ```
4. Run unit and widget tests:
   ```bash
   flutter test
   ```
5. Run the application:
   ```bash
   flutter run
   ```
