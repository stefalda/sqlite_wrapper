// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite_wrapper_sample/database_helper.dart';
import 'package:sqlite_wrapper_sample/main.dart';

void main() {
  testWidgets('Todos basic test', (WidgetTester tester) async {
    // Init the database
    // WidgetsFlutterBinding.ensureInitialized();
    // Init the DB
    await DatabaseHelper().initDB(inMemory: true);

    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.textContaining('Count'), findsOneWidget);
    expect(find.text('NEW TODO 1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('Count: {done: 0, todo: 1}'), findsOneWidget);
    expect(find.text('NEW TODO 1'), findsOneWidget);

    // Mark as done
    await tester.tap(find.text('NEW TODO 1'));
    await tester.pump();
    expect(find.text('Count: {done: 1, todo: 0}'), findsOneWidget);

    // DELETE
    await tester.longPress(find.text('NEW TODO 1'));
    await tester.pump();
    expect(find.text('NEW TODO 1'), findsNothing);

    // Back to 0
    expect(find.text('Count: {done: 0, todo: 0}'), findsOneWidget);
  });
}
