// Ignore for testing purposes

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:operation_kalkan/app/app.dart';
import 'package:operation_kalkan/features/homepage/presentation/homepage.dart';

void main() {
  group('App', () {
    testWidgets('renders Homepage', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: App()));
      expect(find.byType(Homepage), findsOneWidget);
    });
  });
}
