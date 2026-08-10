import '../../models/models.dart';

/// Bundled German knowledge base for AxolotlCare.
/// Content is synthesized from cited husbandry and veterinary sources.
/// Not a substitute for veterinary diagnosis.
const knowledgeArticles = <KnowledgeArticle>[
  KnowledgeArticle(
    id: 'aquarium',
    category: 'Aquarium',
    title: 'Das Aquarium einrichten',
    summary:
        'Beckengröße, Bodengrund, Filter, Verstecke und Einrichtung sicher für Axolotl gestalten.',
    sections: [
      ArticleSection(
        heading: 'Beckengröße und Form',
        body:
            'Axolotl sind Bodenbewohner mit hoher Biofracht. Für ein erwachsenes Tier gelten '
            'etwa 75–80 Liter (ca. 20 US-Gallonen) als absolute Untergrenze; viele erfahrene '
            'Halter und Care-Guides empfehlen deutlich mehr Grundfläche, z. B. ein langes '
            '110-Liter-Becken oder ein 40-Gallon-Breeder (ca. 150–180 Liter) als praxisnahe '
            'Mindestgröße. Pro zusätzlichem Tier sollte spürbar Volumen und Bodenfläche '
            'dazukommen. Höhe ist weniger wichtig als Länge und Breite; Wassertiefe ab etwa '
            '15 cm ist üblich.\n\n'
            'Größere Wassermengen puffern Temperatur- und Werteschwankungen besser ab – '
            'das ist bei kühlen, empfindlichen Amphibien besonders hilfreich.',
      ),
      ArticleSection(
        heading: 'Bodengrund: sicher vor Impaktion',
        body:
            'Axolotl fressen per Saugschnappen. Feiner Kies oder Steine, die in den Mund passen, '
            'können verschluckt werden und zu lebensgefährlichen Verstopfungen führen. '
            'Sicher sind:\n'
            '• bare-bottom (ohne Bodengrund) – am leichtesten zu reinigen\n'
            '• sehr feiner Sand\n'
            '• große Steine/Platten, die klar größer als der Kopf sind\n\n'
            'Klassischer Aquarienkies ist für Axolotl ungeeignet.',
      ),
      ArticleSection(
        heading: 'Filter, Strömung und Deckel',
        body:
            'Ein Filter ist sinnvoll, aber starke Strömung stresst Axolotl (u. a. nach vorne '
            'gebogene Kiemen, eingeringelter Schwanz als Stresszeichen). Den Auslauf drosseln, '
            'mit Spraybar zur Scheibe leiten oder anderweitig brechen.\n\n'
            'Ein Deckel ist empfehlenswert: Axolotl können springen. Beleuchtung ist nicht '
            'nötig; bei Pflanzen reicht dezentes Licht. Starke Beleuchtung ohne Schattenplätze '
            'vermeiden.',
      ),
      ArticleSection(
        heading: 'Einrichtung und Pflanzen',
        body:
            'Verstecke (Tonröhren, Höhlen, robuste Deko ohne scharfe Kanten) geben Sicherheit '
            'und reduzieren Konflikte bei mehreren Tieren. Pflanzen sind optional; robuste '
            'Arten oder Kunstpflanzen eignen sich, da Axolotl empfindliche Pflanzen oft '
            'umwühlen. Keine Mitbewohner wie Fische: Kiemen werden angefressen oder Fische '
            'gefressen; Parasitenrisiko steigt.',
      ),
      ArticleSection(
        heading: 'Einfahren vor dem Einzug',
        body:
            'Das Aquarium sollte vollständig dufahren (Stickstoffkreislauf) sein, bevor ein '
            'Axolotl einzieht: Ammoniak und Nitrit dauerhaft 0, Nitrat kontrollierbar niedrig. '
            'Leitungswasser immer mit Aufbereiter gegen Chlor/Chloramin behandeln.',
      ),
    ],
    sources: [
      SourceRef(
        title: 'Caudata Culture – Ambystoma mexicanum (Housing)',
        url: 'https://www.caudata.org/cc/species/Ambystoma/A_mexicanum.shtml',
        note: 'Beckenmaße, Sand/bare-bottom, Strömung, Temperaturrahmen',
      ),
      SourceRef(
        title: 'LafeberVet – Care of the Axolotl (PDF)',
        url:
            'https://www.lafeber.com/vet/wp-content/uploads/2021/04/Axolotl-Care-of-the-040821.pdf',
        note: 'Mindestvolumen, Quarantäne, keine Fisch-Mitbewohner',
      ),
      SourceRef(
        title: 'Axolotl Central – Care Guide (Tank size)',
        url: 'https://www.axolotlcentral.com/axolotl-care-guide',
        note: 'Empfehlungen zu Bodenfläche und Mindestgröße',
      ),
      SourceRef(
        title: 'axolotl.org – Requirements & Water Conditions',
        url: 'http://www.axolotl.org/requirements.htm',
        note: 'Strömungsstress, Chlor/Chloramin, Haltungsgrundlagen',
      ),
    ],
  ),
  KnowledgeArticle(
    id: 'kauf',
    category: 'Kauf',
    title: 'Kauf und Übernahme eines Axolotls',
    summary:
        'Worauf beim Kauf, Transport und der Eingewöhnung zu achten ist – inklusive Quarantäne.',
    sections: [
      ArticleSection(
        heading: 'Artenschutz und Herkunft',
        body:
            'Ambystoma mexicanum ist in der Natur vom Aussterben bedroht (IUCN: Critically '
            'Endangered) und unterliegt CITES-Anhang II. Heimtiere stammen aus Nachzucht. '
            'Kaufe nur gesunde Nachzuchttiere bei seriösen Züchtern oder Fachhändlern, die '
            'Haltung und Wasserwerte erklären können. Wildfänge sind weder ethisch noch '
            'praktisch vertretbar.',
      ),
      ArticleSection(
        heading: 'Gesunden Axolotl erkennen',
        body:
            'Achte vor dem Kauf auf:\n'
            '• kräftige, buschige Kiemen ohne starke Verkürzung oder Beläge\n'
            '• klare Augen, intakte Gliedmaßen und Schwanz\n'
            '• normale Körperform ohne extreme Abmagerung oder starken Auftrieb\n'
            '• aktives Interesse an Futter (altersabhängig)\n'
            '• kein watteartiger Belag (Verdacht auf Wasserschimmel)\n'
            '• klares Wasser und gepflegte Haltung beim Verkäufer\n\n'
            'Frage nach Alter, Futtergewöhnung, Haltungstemperatur und ob das Tier mit '
            'anderen zusammen war (Bissspuren an Kiemen/Beinen).',
      ),
      ArticleSection(
        heading: 'Vorbereitung zu Hause',
        body:
            'Das Becken muss vor dem Einzug fertig und eingefahren sein. Teste Temperatur, '
            'Ammoniak, Nitrit, Nitrat und pH. Halte Aufbereiter, Testkit, Kescher, Quarantäne- '
            'oder Krankenhausbecken und eine Notfallkühlstrategie (kühler Raum, ggf. Chiller) '
            'bereit. Plane den Einzug nicht in Hitzeperioden ohne Kühlmöglichkeit.',
      ),
      ArticleSection(
        heading: 'Transport und Eingewöhnen',
        body:
            'Transportiere kühl und dunkel, ohne starke Erschütterungen. Zu Hause langsam an '
            'Beckenwasser und Temperatur angleichen (Tropfenmethode bzw. Beutel angleichen), '
            'um Temperaturschock zu vermeiden. In den ersten Tagen wenig stören, Wasserwerte '
            'engmaschig prüfen und Futterangebot an bekannte Nahrung anpassen.',
      ),
      ArticleSection(
        heading: 'Quarantäne und Tierarzt',
        body:
            'LafeberVet empfiehlt eine Untersuchung durch einen amphibienkundigen Tierarzt '
            'inkl. Kotuntersuchung bei Neuzugängen sowie jährliche Checks. Neue Tiere idealerweise '
            'getrennt quarantänisieren, bevor sie zu bestehenden Axolotln gesetzt werden – '
            'besonders bei Gruppenhaltung und Jungtieren mit Beißrisiko.',
      ),
    ],
    sources: [
      SourceRef(
        title: 'Caudata Culture – Ambystoma mexicanum (IUCN/CITES, Beschreibung)',
        url: 'https://www.caudata.org/cc/species/Ambystoma/A_mexicanum.shtml',
      ),
      SourceRef(
        title: 'LafeberVet – Care of the Axolotl',
        url:
            'https://www.lafeber.com/vet/wp-content/uploads/2021/04/Axolotl-Care-of-the-040821.pdf',
        note: 'Quarantäne, vet check, Gesundheitsrisiken',
      ),
      SourceRef(
        title: 'LafeberVet – Basic Information Sheet: Axolotl',
        url: 'https://lafeber.com/vet/basic-information-sheet-axolotl/',
      ),
      SourceRef(
        title: 'axolotl.org – Requirements (Stresszeichen)',
        url: 'http://www.axolotl.org/requirements.htm',
      ),
    ],
  ),
  KnowledgeArticle(
    id: 'haltung',
    category: 'Haltung',
    title: 'Haltung im Alltag',
    summary:
        'Temperatur, Licht, Sozialverhalten, Stresszeichen und langfristige Haltungsroutine.',
    sections: [
      ArticleSection(
        heading: 'Temperatur als zentrales Haltungsmaß',
        body:
            'Axolotl sind Kaltwasseramphibien. In Xochimilco bleibt das Wasser typischerweise '
            'unter etwa 20 °C. In Haltung gelten oft 14–18 °C als Ideal (axolotl.org; Lafeber: '
            'ca. 15,6–17,8 °C). Caudata nennt 14–22 °C als vertretbaren Erwachsenenrahmen; '
            'über 24–25 °C drohen rasch Stress, Appetitlosigkeit, Infektionen und Tod.\n\n'
            'Kühlen durch Standortwahl (kühler Raum, Bodennähe), ggf. Aquarium-Chiller. '
            'Eisflaschen nur sehr vorsichtig und stabil – starke Temperaturschwankungen '
            'sind selbst schädlich.',
      ),
      ArticleSection(
        heading: 'Einzel- oder Gruppenhaltung',
        body:
            'Jungtiere beißen sich leicht an Beinen und Kiemen – besonders unter 8 cm und '
            'bei Enge. Auch größere Jungtiere können noch nippen. Adulte sind ruhiger, fressen '
            'aber deutlich kleinere Artgenossen. Verschiedene Größen getrennt halten. '
            'Geschlechter getrennt halten, wenn keine kontrollierte Zucht geplant ist.',
      ),
      ArticleSection(
        heading: 'Stress erkennen',
        body:
            'Typische Stresszeichen laut axolotl.org u. a.:\n'
            '• nach vorne gerichtete Kiemen bei zu starker Strömung\n'
            '• eingerolltes Schwanzende\n'
            '• blasse, schleimige Hautflecken bei Hitzestress\n'
            '• Futterverweigerung\n\n'
            'Ursachen zuerst suchen: Temperatur, Strömung, Wasserwerte, Unruhe, Beißerei.',
      ),
      ArticleSection(
        heading: 'Alltagsroutine',
        body:
            'Täglich kurz beobachten (Kiemen, Kot, Verhalten, Temperatur). Regelmäßig '
            'Wasserwerte messen – besonders nach dem Einrichten, nach Medikation, bei '
            'Hitze oder nach Filterproblemen. Futterreste entfernen. Lichtzyklus ruhig '
            'halten; Axolotl brauchen keine starke Beleuchtung.',
      ),
      ArticleSection(
        heading: 'Lebensdauer und Erwartung',
        body:
            'Bei stabiler Haltung werden Axolotl oft 10–15 Jahre alt. Sie bleiben ihr Leben '
            'lang im larvalen Erscheinungsbild (Neotenie) mit äußeren Kiemen. Haltung ist '
            'eine langfristige Verantwortung – inklusive Sommerkühlung und Notfallplan.',
      ),
    ],
    sources: [
      SourceRef(
        title: 'axolotl.org – Temperature & Cooling / Stress signs',
        url: 'http://www.axolotl.org/requirements.htm',
      ),
      SourceRef(
        title: 'Caudata Culture – Ambystoma mexicanum',
        url: 'https://www.caudata.org/cc/species/Ambystoma/A_mexicanum.shtml',
      ),
      SourceRef(
        title: 'LafeberVet – Care of the Axolotl',
        url:
            'https://www.lafeber.com/vet/wp-content/uploads/2021/04/Axolotl-Care-of-the-040821.pdf',
      ),
      SourceRef(
        title: 'University of Kentucky Ambystoma Genetic Stock Center – Husbandry',
        url: 'https://ambystoma.as.uky.edu/education1/guide-to-axolotl-husbandry',
      ),
    ],
  ),
  KnowledgeArticle(
    id: 'fuetterung',
    category: 'Fütterung',
    title: 'Fütterung',
    summary:
        'Stapelfutter, Mengen, Rhythmus und was Axolotl nicht bekommen sollten.',
    sections: [
      ArticleSection(
        heading: 'Was Axolotl fressen',
        body:
            'Axolotl sind Fleischfresser. In der Natur und im Labor/Hobby zählen u. a. Würmer, '
            'Krebstiere, Insektenlarven und kleine Wirbeltiere zur Nahrung. Als Stapelfutter '
            'haben sich Regenwürmer/Nachtkriecher (portioniert nach Größe) und hochwertige '
            'sinkende Lachsfutter-/Carnivorenpellets bewährt.\n\n'
            'Ergänzend: Blackworms, Tubifex, Frostfutter wie Blutwurm (eher Leckerli/Abwechslung), '
            'bei Jungtieren Artemia/Daphnia. Lebende Futterfische und Wildfänge bergen '
            'Parasitenrisiken und sind kritisch zu sehen.',
      ),
      ArticleSection(
        heading: 'Rhythmus und Menge',
        body:
            'Jungtiere wachsen schnell und werden oft täglich gefüttert (teilweise mehrmals). '
            'Erwachsene typischerweise 2–3× pro Woche. Lafeber empfiehlt nur so viel, wie in '
            'etwa 2–3 Minuten gefressen wird (Beispielgröße: ca. 5 Lachspellets pro Adult). '
            'Caudata nennt als Orientierung: so viel, wie in ca. 15 Minuten gefressen wird; '
            'bei ~22 °C oft alle 2–3 Tage.\n\n'
            'Reste immer entfernen – stehengebliebenes Futter belastet die Wasserwerte. '
            'Überfütterung führt leicht zu Adipositas.',
      ),
      ArticleSection(
        heading: 'Würmer richtig anbieten',
        body:
            'Nachtkriecher sind nährstoffreich, sollten aber der Maulgröße angepasst und bei '
            'Bedarf zerteilt werden. Es gibt veterinärmedizinische Hinweise auf Verletzungen '
            'durch ganze, sehr große Würmer bei verwandten Ambystoma – Portionierung ist '
            'die sicherere Praxis. Keine gesalzenen oder stark gewürzten Lebensmittel, kein '
            'fettreiches Säugetierfleisch als Dauerfutter.',
      ),
      ArticleSection(
        heading: 'Pellets auswählen',
        body:
            'Gute Pellets sinken, sind proteinreich (Orientierung oft ≥40 % Protein) und eher '
            'fettarm. Schwimmende Sticks sind unpraktisch. Pellets können Stapelfutter ergänzen '
            'oder ersetzen, solange Akzeptanz und Kondition stimmen; viele Halter kombinieren '
            'Pellets und Würmer.',
      ),
    ],
    sources: [
      SourceRef(
        title: 'Caudata Culture – Feeding',
        url: 'https://www.caudata.org/cc/species/Ambystoma/A_mexicanum.shtml',
      ),
      SourceRef(
        title: 'LafeberVet – Basic Information Sheet: Axolotl',
        url: 'https://lafeber.com/vet/basic-information-sheet-axolotl/',
        note: 'Futterarten, Frequenz, Warnung zu ganzen Nightcrawlern',
      ),
      SourceRef(
        title: 'LafeberVet – Care of the Axolotl (PDF)',
        url:
            'https://www.lafeber.com/vet/wp-content/uploads/2021/04/Axolotl-Care-of-the-040821.pdf',
      ),
      SourceRef(
        title: 'UK Ambystoma Genetic Stock Center – Feeding protocol',
        url: 'https://ambystoma.as.uky.edu/education1/guide-to-axolotl-husbandry',
      ),
      SourceRef(
        title: 'PetMD – What Do Axolotls Eat?',
        url: 'https://www.petmd.com/exotic/what-do-axolotls-eat',
      ),
    ],
  ),
  KnowledgeArticle(
    id: 'krankheiten',
    category: 'Gesundheit',
    title: 'Krankheiten und Warnsignale',
    summary:
        'Häufige Probleme, Umweltursachen und wann ein Tierarzt nötig ist. Kein Therapieersatz.',
    sections: [
      ArticleSection(
        heading: 'Wichtig vorab',
        body:
            'Die meisten Gesundheitsprobleme bei Axolotln entstehen sekundär durch schlechte '
            'Wasserwerte, Hitze oder Stress. Medikamente ohne Ursachenbeseitigung wirken oft '
            'nicht nachhaltig. Diese App ersetzt keine tierärztliche Diagnose. Bei Unsicherheit '
            'amphibienkundigen Tierarzt aufsuchen.',
      ),
      ArticleSection(
        heading: 'Pilz-/Wasserschimmelbeläge',
        body:
            'Watteeähnliche weiße oder gräuliche Beläge auf Haut, Kiemen oder Wunden sind typisch '
            'für Wasserschimmel (u. a. Saprolegnia-ähnlich). Häufig nach Verletzung, Hitze oder '
            'schlechter Wasserqualität. Umgebung stabilisieren (kühl, sauber, 0 Ammoniak/Nitrit) '
            'ist der erste Schritt; Behandlung mit dem Tierarzt abstimmen.',
      ),
      ArticleSection(
        heading: 'Bakterielle Infektionen',
        body:
            'Aeromonas, Pseudomonas und andere gramnegative Keime kommen opportunistisch vor '
            '– oft nach Stress, Überfütterung oder schlechter Wasserqualität. Zeichen können '
            'Rötungen, Geschwüre, Lethargie, Appetitlosigkeit oder systemische Erkrankung sein. '
            'UKY und Lafeber weisen auf das Risiko von Septikämie hin.',
      ),
      ArticleSection(
        heading: 'Hitzeschäden (Hyperthermie)',
        body:
            'Über etwa 24 °C steigt das Erkrankungsrisiko stark. Symptome laut Lafeber u. a. '
            'Appetitlosigkeit, Aszites, unkontrollierter positiver Auftrieb. Sekundärinfektionen '
            'sind häufig. Sofort kühlere, stabile Bedingungen herstellen.',
      ),
      ArticleSection(
        heading: 'Fremdkörper und weitere Probleme',
        body:
            'Verschluckter Kies kann zu Impaktion und Tod führen – deshalb sicherer Bodengrund. '
            'Chronisch hohe Nitrate werden mit Exophthalmus (hervortretende Augen) in Verbindung '
            'gebracht. Adipositas durch Überfütterung ist häufig. Metamorphose ist bei echten '
            'A. mexicanum untypisch und bedarf Fachklärung (Hybridisierung/Hormone/Jod).',
      ),
      ArticleSection(
        heading: 'Wann handeln?',
        body:
            'Sofort Wasserwerte und Temperatur messen bei: Futterstreik, Belägen, starken '
            'Hautveränderungen, Auftrieb, blutigen Stellen, Atemnot-ähnlichem Verhalten oder '
            'plötzlicher Apathie. Teilwasserwechsel mit aufbereitetem, temperaturangeglichenem '
            'Wasser ist oft die erste sinnvolle Maßnahme – parallel professionelle Hilfe holen.',
      ),
    ],
    sources: [
      SourceRef(
        title: 'LafeberVet – Basic Information Sheet: Axolotl',
        url: 'https://lafeber.com/vet/basic-information-sheet-axolotl/',
      ),
      SourceRef(
        title: 'LafeberVet – Care of the Axolotl',
        url:
            'https://www.lafeber.com/vet/wp-content/uploads/2021/04/Axolotl-Care-of-the-040821.pdf',
      ),
      SourceRef(
        title: 'UK Ambystoma Genetic Stock Center – Disease notes',
        url: 'https://ambystoma.as.uky.edu/education1/guide-to-axolotl-husbandry',
      ),
      SourceRef(
        title: 'axolotl.org – Heat stress / disease context',
        url: 'http://www.axolotl.org/requirements.htm',
      ),
    ],
  ),
  KnowledgeArticle(
    id: 'reinigung',
    category: 'Pflege',
    title: 'Reinigung und Pflege',
    summary:
        'Wasserwechsel, Filterpflege und Hygiene – ohne den Biofilter zu zerstören.',
    sections: [
      ArticleSection(
        heading: 'Teilwasserwechsel als Kernpflege',
        body:
            'Regelmäßige Teilwasserwechsel entfernen Nitrat und andere Belastungen und bringen '
            'Mineralien nach. Richtwerte aus den Quellen:\n'
            '• Lafeber: idealerweise ca. 30 % wöchentlich\n'
            '• axolotl.org: oft ca. 20 % wöchentlich (bei Bedarf häufiger)\n'
            '• Caudata: ca. 20 % alle zwei Wochen als Basis, bei dichter Besetzung/Überfütterung häufiger\n'
            '• Axolotl Central: Wechsel so oft wie nötig, um Nitrat niedrig (<10–20 mg/l) zu halten; '
            'häufig 30–70 %\n\n'
            'Neues Wasser immer temperaturangleichen und mit Aufbereiter gegen Chlor/Chloramin '
            'behandeln. Nie das gesamte Wasser „steril“ tauschen, wenn der Filter davon abhängt.',
      ),
      ArticleSection(
        heading: 'Mulm und Boden',
        body:
            'Kot und Futterreste gezielt absaugen. Bei Sand vorsichtig mulmen; bei bare-bottom '
            'ist die Hygiene besonders einfach. Sichtbare Verschmutzung nicht wochenlang liegen '
            'lassen – sie treibt Ammoniak/Nitrat.',
      ),
      ArticleSection(
        heading: 'Filter richtig pflegen',
        body:
            'Nützliche Bakterien sitzen vor allem im Filtermedium. Spüle Schwämme und Medien '
            'nur im abgestandenen Aquariumwasser aus, nicht unter heißem oder chlorhaltigem '
            'Leitungswasser. Medien nicht alle gleichzeitig austauschen. Strömung nach der '
            'Wartung erneut prüfen und bei Bedarf brechen.',
      ),
      ArticleSection(
        heading: 'Scheiben, Deko, Desinfektion',
        body:
            'Algen an Scheiben bei Bedarf mechanisch entfernen. Deko ohne scharfe Kanten wählen; '
            'bei Krankheit oder Quarantäne Gegenstände gründlich reinigen. Keine Haushaltsreiniger '
            'oder Duftstoffe im und am Becken. Kescher und Schläuche zwischen Becken nicht '
            'unkritisch teilen (Keimverschleppung).',
      ),
      ArticleSection(
        heading: 'Pflege-Checkliste',
        body:
            '• Temperatur lesen\n'
            '• Tiere kurz beobachten\n'
            '• Reste entfernen\n'
            '• nach Plan Wasserwerte testen\n'
            '• Teilwasserwechsel durchführen\n'
            '• Filter nur bei Bedarf schonend warten\n'
            '• Eintrag im Pflegeprotokoll (in AxolotlCare) vermerken',
      ),
    ],
    sources: [
      SourceRef(
        title: 'LafeberVet – Care of the Axolotl (water changes)',
        url:
            'https://www.lafeber.com/vet/wp-content/uploads/2021/04/Axolotl-Care-of-the-040821.pdf',
      ),
      SourceRef(
        title: 'axolotl.org – Water changes',
        url: 'http://www.axolotl.org/requirements.htm',
      ),
      SourceRef(
        title: 'Caudata Culture – Maintenance notes',
        url: 'https://www.caudata.org/cc/species/Ambystoma/A_mexicanum.shtml',
      ),
      SourceRef(
        title: 'Axolotl Central – Nitrate management / water changes',
        url: 'https://www.axolotlcentral.com/axolotl-care-guide',
      ),
    ],
  ),
  KnowledgeArticle(
    id: 'wasserwerte',
    category: 'Wasserwerte',
    title: 'Wasserwerte – das komplette Bild',
    summary:
        'Stickstoffkreislauf, Zielwerte, Messung und Einordnung speziell für Axolotl.',
    sections: [
      ArticleSection(
        heading: 'Warum Wasserwerte entscheiden',
        body:
            'Axolotl atmen über Kiemen und Haut und reagieren empfindlich auf gelöste Gifte, '
            'Hitze und instabile Chemie. Stabile, kühle, saubere Bedingungen verhindern die '
            'meisten Haltungsprobleme. Messen schlägt Raten – besonders in der Einfahrphase, '
            'bei Hitze, nach Medikamenten und bei Appetitlosigkeit.',
      ),
      ArticleSection(
        heading: 'Der Stickstoffkreislauf',
        body:
            '1. Axolotl und Zersetzung erzeugen Ammoniak (NH₃/NH₄⁺) – hochgiftig.\n'
            '2. Nitrosomonas-Bakterien wandeln Ammoniak zu Nitrit (NO₂⁻) – ebenfalls giftig.\n'
            '3. Nitrobacter u. a. wandeln Nitrit zu Nitrat (NO₃⁻) – weniger giftig, aber '
            'akkumuliert und muss durch Wasserwechsel (und Pflanzen) begrenzt werden.\n\n'
            'Ein „eingefahrenes“ Becken zeigt dauerhaft 0 Ammoniak, 0 Nitrit und kontrolliertes Nitrat.',
      ),
      ArticleSection(
        heading: 'Zielwerte (Referenz für AxolotlCare)',
        body:
            'Die App bewertet Messungen an folgenden, aus Fachquellen abgeleiteten Bereichen:\n\n'
            '• Temperatur: optimal 14–18 °C; Warnung 12–14 / 18–20 °C; kritisch außerhalb; '
            'über 24 °C akut gefährlich (Lafeber, axolotl.org, Caudata).\n'
            '• pH: ideal ca. 7,4–7,6; akzeptabel oft 6,5–8,0 (axolotl.org). Höherer pH macht '
            'Ammoniak toxischer.\n'
            '• Ammoniak: 0 mg/l (Lafeber).\n'
            '• Nitrit: 0 mg/l (Lafeber).\n'
            '• Nitrat: Ziel oft <10–20 mg/l; in der App gut ≤20, Warnung bis 40, darüber kritisch '
            '(Lafeber <10; Axolotl Central <20).\n'
            '• GH: Orientierung 7–14 °dGH (moderate Härte; Axolotl mögen eher härteres Wasser).\n'
            '• KH: Orientierung 3–8 °dKH als Puffer gegen pH-Stürze.\n'
            '• Chlor/Chloramin: immer 0 – Leitungswasser aufbereiten.',
      ),
      ArticleSection(
        heading: 'Messung praktisch',
        body:
            'Nutze Tropfentests oder zuverlässige Fotometer; Streifen nur zur groben Orientierung. '
            'Miss idealerweise immer zur ähnlichen Tageszeit und notiere Auffälligkeiten '
            '(Fütterung, Wasserwechsel, Filterwartung). In AxolotlCare kannst du Werte pro '
            'Aquarium speichern und automatisch einordnen lassen.',
      ),
      ArticleSection(
        heading: 'Was tun bei schlechten Werten?',
        body:
            '• Ammoniak/Nitrit > 0: Teilwasserwechsel, Ursache finden (Überfütterung, totes '
            'Material, Filterausfall, unreifes Becken), ggf. Besatz reduzieren.\n'
            '• Nitrat hoch: größere/häufigere Wechsel, Fütterung und Pflanzen prüfen.\n'
            '• Temperatur hoch: Standort/Chiller, stabile Kühlung statt hektischer Eis-Achterbahn.\n'
            '• pH/Härte: langsam korrigieren; keine radikalen Chemie-Schocks.\n\n'
            'Quellen und Zielbereiche können je nach Region und Messmethode leicht variieren – '
            'Stabilität und 0 Ammoniak/Nitrit haben Priorität.',
      ),
    ],
    sources: [
      SourceRef(
        title: 'axolotl.org – Requirements & Water Conditions',
        url: 'http://www.axolotl.org/requirements.htm',
        note: 'pH, Ammoniaktoxizität, Chlor, Härte, Temperatur',
      ),
      SourceRef(
        title: 'LafeberVet – Care of the Axolotl',
        url:
            'https://www.lafeber.com/vet/wp-content/uploads/2021/04/Axolotl-Care-of-the-040821.pdf',
        note: 'Temp 60–64°F, pH 7.4–7.6, NH3/NO2 = 0, NO3 <10 ppm, 30% WC',
      ),
      SourceRef(
        title: 'Axolotl Central – Water parameters & nitrates',
        url: 'https://www.axolotlcentral.com/axolotl-care-guide',
      ),
      SourceRef(
        title: 'Caudata Culture – Temperature & water quality basics',
        url: 'https://www.caudata.org/cc/species/Ambystoma/A_mexicanum.shtml',
      ),
      SourceRef(
        title: 'ExoPetGuides – Axolotl Care Guide (parameter table synthesis)',
        url: 'https://exopetguides.com/axolotls/axolotl-care-guide/',
        note: 'GH/KH-Orientierung und Parameterübersicht mit Quellenverweisen',
      ),
    ],
  ),
];

KnowledgeArticle? articleById(String id) {
  for (final article in knowledgeArticles) {
    if (article.id == id) return article;
  }
  return null;
}
