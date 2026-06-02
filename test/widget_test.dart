import 'package:flutter_test/flutter_test.dart';
import 'package:pcfutbol_2026/main.dart';
import 'package:pcfutbol_2026/core/database_service.dart';

void main() {
  testWidgets('App muestra pantalla de carga inicial', (WidgetTester tester) async {
    final dbService = DatabaseService();
    await tester.pumpWidget(PCFutbol2026(dbService: dbService));
    expect(find.textContaining('PC FÚTBOL'), findsOneWidget);
  });
}
