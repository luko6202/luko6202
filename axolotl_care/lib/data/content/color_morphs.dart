import '../../models/models.dart';

/// Common axolotl color morphs for catalog + animal profiles.
const colorMorphs = <ColorMorph>[
  ColorMorph(
    id: 'wild',
    nameDe: 'Wildtyp',
    nameEn: 'Wild type',
    shortDescription:
        'Braun, grau bis leicht grünlich mit dunklen Pigmentflecken; dunkle Augen mit oft goldenem Augenring.',
    details:
        'Entspricht dem natürlichen Erscheinungsbild. Alle drei Pigmentzelltypen sind vorhanden: '
        'Melanophoren (dunkel), Xanthophoren (gelb) und Iridophoren (irisierend). '
        'Stark irisierende Tiere werden manchmal als „Starburst“ beschrieben.',
    hallmarks: [
      'Dunkle Grundfarbe mit Flecken',
      'Dunkle Augen',
      'Oft leichter Irisier-/Goldanteil',
    ],
  ),
  ColorMorph(
    id: 'leucistic',
    nameDe: 'Leuzistisch',
    nameEn: 'Leucistic',
    shortDescription:
        'Weißer bis blassrosa Körper mit dunklen Augen; Kiemen oft leuchtend rosa.',
    details:
        'Durch die „white“/Dunk-Gen-Mutation (d/d) wandern Pigmentzellen nicht normal über den Körper. '
        'Im Gegensatz zu Albinos können leuzistische Tiere Melanin bilden – typisch sind schwarze Augen '
        'und manchmal dunkle „Dirty Leucistic“-Flecken an Kopf oder Rücken.',
    hallmarks: [
      'Heller Körper',
      'Dunkle (schwarze) Augen',
      'Rosa Kiemen häufig auffällig',
    ],
  ),
  ColorMorph(
    id: 'golden_albino',
    nameDe: 'Goldalbino',
    nameEn: 'Golden albino',
    shortDescription:
        'Goldgelb bis apricotfarben mit rosa/roten Augen; oft glänzende Iridophoren.',
    details:
        'Albino (a/a) verhindert dunkles Eumelanin. Bei vorhandenem „Dark“-Allel bleiben Gelb- und '
        'Glanzpigmente sichtbar – daher der goldene Eindruck. Starke Iridophoren werden manchmal '
        '„Sunburst“ genannt.',
    hallmarks: [
      'Gelb-/Goldton',
      'Rosa oder rote Augen',
      'Kein echtes Schwarzpigment',
    ],
  ),
  ColorMorph(
    id: 'white_albino',
    nameDe: 'Weißalbino',
    nameEn: 'White albino',
    shortDescription:
        'Sehr hell/weiß mit rosa oder roten Augen; Kombination aus Albino und Leuzismus.',
    details:
        'Genotypisch oft d/d a/a: weder normales dunkles Pigment noch die typische Goldverteilung '
        'eines Goldalbinos. Optisch leicht mit Leuzisten zu verwechseln – entscheidend sind die Augenfarbe '
        '(rosa/rot statt schwarz).',
    hallmarks: [
      'Sehr heller Körper',
      'Rosa/rote Augen',
      'Wenig bis kein Goldton',
    ],
  ),
  ColorMorph(
    id: 'melanoid',
    nameDe: 'Melanoid',
    nameEn: 'Melanoid',
    shortDescription:
        'Sehr dunkle, eher gleichmäßige Färbung ohne irisierenden Glanz.',
    details:
        'Melanoid (m/m) erhöht Melanophoren und unterdrückt Iridophoren weitgehend. Das Tier wirkt '
        'tief dunkelgrau bis schwarz und „matt“ im Vergleich zum Wildtyp. Kombinationsformen wie '
        'leuzistisch-melanoid oder melanoid-albino kommen vor.',
    hallmarks: [
      'Dunkel und relativ einheitlich',
      'Kaum Irisier-/Glanzpigment',
      'Augen ohne typischen Goldring des Wildtyps',
    ],
  ),
  ColorMorph(
    id: 'copper',
    nameDe: 'Copper',
    nameEn: 'Copper',
    shortDescription:
        'Kupfer-, beige- oder rötlich-braune Töne statt klassischem Schwarz.',
    details:
        'Copper (c/c) gilt als tyrosinase-positive Albinismus-Variante: statt Eumelanin dominiert '
        'rötlich-braunes Pheomelanin. Augen wirken oft heller. Kombinierbar mit anderen Merkmalen '
        '(z. B. Copper-Leuzistisch).',
    hallmarks: [
      'Warme Kupfer-/Beigetöne',
      'Hellere Augen möglich',
      'Kein klassisches Tiefschwarz',
    ],
  ),
  ColorMorph(
    id: 'axanthic',
    nameDe: 'Axanthic',
    nameEn: 'Axanthic',
    shortDescription:
        'Grau- bis lavendelfarbene Wirkung ohne Gelbpigment; oft „cleaner“ Grau-/Silberton.',
    details:
        'Axanthic (ax/ax) unterdrückt Xanthophoren (und beeinflusst Iridophoren). Ohne Gelbanteil '
        'wirken Tiere kühler grau oder lavendelartig. Kombos mit Melanoid, Copper oder Albino verändern '
        'das Bild weiter.',
    hallmarks: [
      'Fehlendes Gelbpigment',
      'Grau-/Lavendeltöne möglich',
      'Oft weniger „warm“ als Wildtyp/Copper',
    ],
  ),
  ColorMorph(
    id: 'leucistic_melanoid',
    nameDe: 'Leuzistisch-Melanoid',
    nameEn: 'Leucistic melanoid',
    shortDescription:
        'Heller Körper ohne starke Irisierung; dunkle Augen, oft besonders „clean“ weiß.',
    details:
        'Kombination aus Leuzismus und Melanoid. Der Körper bleibt hell, Glanzpigmente fehlen weitgehend. '
        'Von klassischen Leuzisten vor allem am fehlenden Schimmer und am Gesamteindruck unterscheidbar.',
    hallmarks: [
      'Hell',
      'Dunkle Augen',
      'Wenig bis kein Glanz',
    ],
  ),
  ColorMorph(
    id: 'melanoid_albino',
    nameDe: 'Melanoid-Albino',
    nameEn: 'Melanoid albino',
    shortDescription:
        'Sehr helle bis cremefarbene Albino-Form ohne typischen Goldglanz.',
    details:
        'Albino plus Melanoid: ohne dunkles Melanin und ohne die übliche Iridophoren-/Goldwirkung. '
        'Wirkt oft blasser und matter als ein Goldalbino.',
    hallmarks: [
      'Sehr hell/creme',
      'Rosa/rote Augen',
      'Kaum Gold-/Glanzeffekt',
    ],
  ),
  ColorMorph(
    id: 'other',
    nameDe: 'Sonstige / Kombi',
    nameEn: 'Other / combo',
    shortDescription:
        'Seltene Kombinationen, Handelsnamen oder noch unklare Zuordnung.',
    details:
        'Viele Handelsbezeichnungen (z. B. Dirty Leucistic, High Iridophore, Lavender) beschreiben '
        'Abstufungen oder Genkombinationen. Im Zweifel Merkmale und Herkunft notieren und bei Bedarf '
        'mit Züchterwissen abgleichen.',
    hallmarks: [
      'Individuell beschreiben',
      'Fotos und Herkunft helfen',
      'GFP separat vermerken',
    ],
  ),
];

ColorMorph? colorMorphById(String id) {
  for (final morph in colorMorphs) {
    if (morph.id == id) return morph;
  }
  return null;
}
