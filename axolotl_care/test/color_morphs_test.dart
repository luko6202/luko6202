import 'package:axolotl_care/data/content/color_morphs.dart';
import 'package:axolotl_care/data/content/knowledge_articles.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('color morph catalog contains core morphs', () {
    final ids = colorMorphs.map((m) => m.id).toSet();
    expect(ids.containsAll({
      'wild',
      'leucistic',
      'golden_albino',
      'melanoid',
      'copper',
      'axanthic',
    }), isTrue);
  });

  test('farbschlaege knowledge article exists', () {
    final article = articleById('farbschlaege');
    expect(article, isNotNull);
    expect(article!.sources, isNotEmpty);
  });
}
