import 'package:flutter_test/flutter_test.dart';
import 'package:pcfutbol_2026/main.dart';

void main() {
  testWidgets('App muestra pantalla de carga inicial', (WidgetTester tester) async {
    await tester.pumpWidget(const PCFutbol2026());
    expect(find.textContaining('PC FÚTBOL'), findsOneWidget);
  });
}