// Ignore for testing purposes
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:operation_kalkan/counter/counter.dart';

import '../../helpers/helpers.dart';

void main() {
  group('CounterPage', () {
    testWidgets('renders CounterView', (tester) async {
      await tester.pumpApp(const ProviderScope(child: CounterPage()));
      expect(find.byType(CounterView), findsOneWidget);
    });
  });

  group('CounterView', () {
    testWidgets('renders current count and responds to taps', (tester) async {
      await tester.pumpApp(const ProviderScope(child: CounterView()));

      // initial state is 0
      expect(find.text('0'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      expect(find.text('1'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.remove));
      await tester.pumpAndSettle();
      expect(find.text('0'), findsOneWidget);
    });
  });
}
