import 'package:animals_adoption_flutter/main.dart';
import 'package:animals_adoption_flutter/screens/home_page/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test app workflow', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    expect(find.byType(AnimalsListOrGrid), findsNWidgets(2));
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text("Successfully Adopted"), findsOneWidget);
  });
}
