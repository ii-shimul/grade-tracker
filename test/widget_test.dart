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
    expect(find.text('Add Subject Form (Placeholder)'), findsOneWidget);

    // Tap on the 'Subjects' navigation item
    await tester.tap(find.byIcon(Icons.format_list_bulleted_rounded));
    await tester.pumpAndSettle();

    // Verify screen changes to 'Subject List'
    expect(find.text('Subject List'), findsOneWidget);
    expect(find.text('Subject List (Placeholder)'), findsOneWidget);

    // Tap on the 'Summary' navigation item
    await tester.tap(find.byIcon(Icons.analytics_outlined));
    await tester.pumpAndSettle();

    // Verify screen changes to 'Summary'
    expect(find.descendant(of: find.byType(AppBar), matching: find.text('Summary')), findsOneWidget);
    expect(find.text('Summary & Analytics (Placeholder)'), findsOneWidget);
  });
}
