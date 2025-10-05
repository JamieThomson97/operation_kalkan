import 'package:flutter_test/flutter_test.dart';

import 'package:operation_kalkan/counter/counter.dart';

void main() {
  group('CounterNotifier', () {
    test('initial state is 0', () {
      final notifier = CounterNotifier();
      expect(notifier.state, equals(0));
    });

    test('increment increases state', () {
      final notifier = CounterNotifier()..increment();
      expect(notifier.state, equals(1));
    });

    test('decrement decreases state', () {
      final notifier = CounterNotifier()
      ..decrement();
      expect(notifier.state, equals(-1));
    });
  });
}
