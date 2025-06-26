// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Basketball Score Counter';

  @override
  String get gameTitle => 'Basketball Match';

  @override
  String get team1Name => 'Team A';

  @override
  String get team2Name => 'Team B';

  @override
  String get freeThrowButton => 'Free Throw (+1)';

  @override
  String get twoPointsButton => '2 Points (+2)';

  @override
  String get threePointsButton => '3 Points (+3)';

  @override
  String get undoButton => 'Undo Last Score';

  @override
  String get resetButton => 'Reset Scores';
}
