import 'package:axolotl_care/app.dart';
import 'package:axolotl_care/data/repositories/app_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('AxolotlCare home renders brand', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final repo = await AppRepository.create();

    await tester.pumpWidget(AxolotlCareApp(repository: repo));
    await tester.pumpAndSettle();

    expect(find.text('AxolotlCare'), findsOneWidget);
    expect(find.textContaining('Aquarium'), findsWidgets);
  });
}
