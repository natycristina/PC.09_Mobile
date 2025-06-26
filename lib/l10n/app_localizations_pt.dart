// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Contador de Pontos de Basquete';

  @override
  String get gameTitle => 'Partida de Basquete';

  @override
  String get team1Name => 'Time A';

  @override
  String get team2Name => 'Time B';

  @override
  String get freeThrowButton => 'Lance Livre (+1)';

  @override
  String get twoPointsButton => '2 Pontos (+2)';

  @override
  String get threePointsButton => '3 Pontos (+3)';

  @override
  String get undoButton => 'Voltar Lance';

  @override
  String get resetButton => 'Reiniciar Placar';
}
