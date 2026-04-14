import 'package:flutter_test/flutter_test.dart';
import 'package:super_career_ai/main.dart';

void main() {
  testWidgets('App builds', (WidgetTester tester) async {
    await tester.pumpWidget(const SuperCareerApp());
    await tester.pump();
    expect(find.byType(SuperCareerApp), findsOneWidget);
  });
}
