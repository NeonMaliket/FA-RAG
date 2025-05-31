import 'package:fa_rag_ui/domain/domain.dart';
import 'package:fa_rag_ui/feature/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Testing Main Window Drawer', (WidgetTester tester) async {
    const menuItemNames = [
      "Vector Database Selection",
      "Model Selection",
      "Data Upload & Vectorization",
      "Query Interface",
      "System Settings",
    ];
    final model = ApplicationSettings();
    await tester.pumpWidget(
      ApplicationSettingsProvider(
        applicationSettings: model,
        child: const MaterialApp(home: MainWindow()),
      ),
    );

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    for (final item in menuItemNames) {
      expect(
        find.text(item),
        findsOneWidget,
        reason: "Testing menu item: $item",
      );
    }
  });
}
