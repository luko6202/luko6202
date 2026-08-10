# AxolotlCare

Flutter-Multiplattform-App (Android, iOS, Web) als Helfer für die Axolotl-Haltung.

## Features (MVP)

- **Mehrere Aquarien** anlegen, auswählen, bearbeiten
- **Wissen** mit quellenbasierten Artikeln:
  - Aquarium
  - Kauf des Axolotls
  - Haltung
  - Fütterung
  - Krankheiten
  - Reinigung
  - Wasserwerte (komplettes Bild)
- **Wasserwerte** erfassen und automatisch einordnen (gut / beachten / kritisch)
- **Pflegeprotokoll** (Wasserwechsel, Filter, Beobachtungen, …)
- Lokale Speicherung (SharedPreferences), offline nutzbar

## Branding

App-Logo unter `assets/branding/` (auch als Android-/iOS-/Web-Launcher-Icon eingebunden).

## Starten

Voraussetzung: Flutter SDK (≥ 3.32 / Dart 3.8).

```bash
cd axolotl_care
flutter pub get
flutter test
flutter run
```

Web:

```bash
flutter run -d chrome
```

## Struktur

```text
lib/
  data/content/     # Wissensartikel + Quellen
  data/repositories # Persistenz
  domain/           # Wasserwerte-Bewertung
  models/
  theme/
  ui/               # Home, Wissen, Werte, Pflege, Becken
```

## Hinweis

Die Inhalte sind aus Fachquellen zusammengeführt und ersetzen keine tierärztliche Diagnose oder individuelle Beratung.
