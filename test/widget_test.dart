import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:grade_tracker/main.dart';
import 'package:grade_tracker/providers/grade_provider.dart';

void main() {
  testWidgets('Navigation and theme smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => GradeProvider(),
        child: const MyApp(),
      ),
    );

    // Verify we are on the first tab ('Add Subject')
    expect(find.descendant(of: find.byType(AppBar), matching: find.text('Add Subject')), findsOneWidget);
    expect(find.text('Enter Subject Details'), findsOneWidget);

    // Tap on the 'Subjects' navigation item
    await tester.tap(find.byIcon(Icons.format_list_bulleted_rounded));
    await tester.pumpAndSettle();

    // Verify screen changes to 'Subject List'
    expect(find.text('Subject List'), findsOneWidget);
    expect(find.text('No Subjects Added Yet'), findsOneWidget);

    // Tap on the 'Summary' navigation item
    await tester.tap(find.byIcon(Icons.analytics_outlined));
    await tester.pumpAndSettle();

    // Verify screen changes to 'Summary'
    expect(find.descendant(of: find.byType(AppBar), matching: find.text('Summary')), findsOneWidget);
    expect(find.text('Summary & Analytics (Placeholder)'), findsOneWidget);
  });

  testWidgets('Form validation and adding subject test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => GradeProvider(),
        child: const MyApp(),
      ),
    );

    // Try to submit empty form
    await tester.tap(find.text('Save Subject'));
    await tester.pumpAndSettle();

    // Verify validation errors are shown
    expect(find.text('Subject name cannot be empty'), findsOneWidget);
    expect(find.text('Mark cannot be empty'), findsOneWidget);

    // Enter invalid mark
    await tester.enterText(find.byType(TextFormField).first, 'History');
    await tester.enterText(find.byType(TextFormField).last, '150');
    await tester.tap(find.text('Save Subject'));
    await tester.pumpAndSettle();

    // Verify invalid mark validation error
    expect(find.text('Mark must be between 0 and 100'), findsOneWidget);

    // Enter valid details
    await tester.enterText(find.byType(TextFormField).last, '88');
    await tester.tap(find.text('Save Subject'));
    await tester.pumpAndSettle();

    // Verify form cleared and validation messages disappear
    expect(find.text('Subject name cannot be empty'), findsNothing);
    expect(find.text('Mark must be between 0 and 100'), findsNothing);

    // Go to Subject List and check if it is there
    await tester.tap(find.byIcon(Icons.format_list_bulleted_rounded));
    await tester.pumpAndSettle();

    expect(find.text('History'), findsOneWidget);
    expect(find.text('Mark: 88/100'), findsOneWidget);
    expect(find.text('A'), findsOneWidget); // 88 is Grade A
  });
}
