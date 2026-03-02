import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vink_sim/main.dart';

void main() {
  testWidgets('MyApp renders with loader while feature initializes', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
