import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hw/generated/l10n.dart';
import 'package:hw/postSignUp/todo_screen.dart';
import '../widget_test_extension.dart';

void main() {
  testWidgets('Todo Screen UI Test', (WidgetTester tester) async {
    await tester.wrapAndPump(MaterialApp(
      home: Scaffold(
        body: todo_screen(),
      ),
      localizationsDelegates: [
        Batch16String.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: Batch16String.delegate.supportedLocales,
    ));
    await tester.pumpAndSettle();

    // Verify the presence of the AppBar with the title
    expect(find.text(Batch16String.current.todo), findsOneWidget);

    // Verify the presence of the TextField for adding new todos
    expect(find.byType(TextField), findsOneWidget);

    // Verify the presence of the add IconButton
    expect(find.byIcon(Icons.add), findsOneWidget);

    // Verify the presence of the CircularProgressIndicator before data is loaded
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Simulate data loading
    await tester.pump(); // Wait for the StreamBuilder to rebuild

    // Verify the presence of ListTiles for pending and done todos
    expect(find.text(Batch16String.current.pending), findsOneWidget);
    expect(find.text(Batch16String.current.done), findsOneWidget);
  });
}
