import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hw/generated/l10n.dart';
import 'package:hw/postSignUp/todo_screen.dart';
import 'package:hw/signup/bloc/sign_up_cubit.dart';
import 'package:hw/signup/sign_up_screen.dart';
import '../widget_test_extension.dart';

void main() {

  testWidgets('verify components', (widgetTester) async {
    const Widget widget = MyHome();
    await widgetTester.wrapAndPump(widget);

    expect(find.text(Batch16String.current.welcome), findsWidgets);
    expect(find.text(Batch16String.current.request), findsWidgets);
    expect(find.text(Batch16String.current.name), findsWidgets);
    expect(find.text(Batch16String.current.email), findsWidgets);
    expect(find.text(Batch16String.current.password), findsWidgets);
    expect(find.text(Batch16String.current.or), findsWidgets);
    expect(find.text(Batch16String.current.login), findsWidgets);

    expect(find.findImageWithAsset('assets/git.png'),findsWidgets);
    expect(find.findImageWithAsset('assets/linkedIN.png'),findsWidgets);
    expect(find.findImageWithAsset('assets/google.png'),findsWidgets);
    expect(find.findImageWithAsset('assets/female.png'),findsWidgets);
    expect(find.findImageWithAsset('assets/human.png'),findsWidgets);
    expect(find.findImageWithAsset('assets/key.png'),findsWidgets);
    expect(find.findImageWithAsset('assets/mail.png'),findsWidgets);
    expect(find.findImageWithAsset('assets/visible.png'),findsWidgets);


  });

  testWidgets('sign up with Google', (widgetTester) async {
    const Widget widget = MyHome();

    await widgetTester.wrapAndPump(widget);

    final googleButton = find.byType(AccountHolder).at(1);
    await widgetTester.tap(googleButton);
    await widgetTester.pump();

    // Add expectations related to Google sign up here.
    // For example, checking if the correct state is emitted or navigation happens.
  });

  testWidgets('display error SnackBar on LinkedIn sign-up failure', (widgetTester) async {
    const Widget widget = MyHome();

    await widgetTester.wrapAndPump(widget);
    await widgetTester.tap(find.findImageWithAsset('assets/linkedIN.png'));
    await widgetTester.pump();

    expect(find.text(Batch16String.current.notSupported('LinkedIn')), findsOneWidget);
  });

  testWidgets('fill form', (widgetTester) async {
    const Widget widget = MyHome();

    await widgetTester.wrapAndPump(widget);

    await widgetTester.enterText(find.byType(TextField).at(0), 'Test User');
    await widgetTester.enterText(find.byType(TextField).at(1), 'test@example.com');
    await widgetTester.enterText(find.byType(TextField).at(2), 'Password123!');
    await widgetTester.pumpAndSettle();

    expect(find.text('Test User'), findsOneWidget);
    expect(find.text('test@example.com'), findsOneWidget);
    expect(find.text('Password123!'), findsOneWidget);



  });
  testWidgets('display error SnackBar on GitHub sign-up failure', (widgetTester) async {
    const Widget widget = MyHome();

    await widgetTester.wrapAndPump(widget);
    await widgetTester.tap(find.findImageWithAsset('assets/git.png'));
    await widgetTester.pump();

    expect(find.text(Batch16String.current.notSupported('Github')), findsOneWidget);
  });

}
