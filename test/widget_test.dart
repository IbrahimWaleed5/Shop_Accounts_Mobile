import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Shop Accounts basic widget test',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: Text('نظام حسابات الدكان'),
            ),
          ),
        ),
      );

      expect(
        find.text('نظام حسابات الدكان'),
        findsOneWidget,
      );
    },
  );
}