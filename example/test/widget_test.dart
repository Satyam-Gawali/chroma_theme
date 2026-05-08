import 'package:flutter_test/flutter_test.dart';
import 'package:chroma_theme/chroma_theme.dart';

import 'package:chroma_theme_example/main.dart';

void main() {
  testWidgets('ChromaTheme smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ChromaTheme(child: ChromaExampleApp()),
    );
    expect(find.byType(ChromaExampleApp), findsOneWidget);
  });
}

