// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pc_09_placar/l10n/app_localizations.dart';

void main() {
  runApp(const BasketballScoreApp());
}

// Classe para registrar cada ação de pontuação, permitindo o "desfazer"
class ScoreAction {
  final String team; // 'team1' ou 'team2'
  final int points; // Pontos adicionados

  ScoreAction(this.team, this.points);
}

class BasketballScoreApp extends StatelessWidget {
  const BasketballScoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basketball Score Counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 18.0),
        ),
      ),
      // Configuração para internacionalização
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // Inglês
        Locale('pt', ''), // Português
      ],
      home: const ScoreCounterScreen(),
      debugShowCheckedModeBanner: false, // Oculta a faixa de debug
    );
  }
}

class ScoreCounterScreen extends StatefulWidget {
  const ScoreCounterScreen({super.key});

  @override
  State<ScoreCounterScreen> createState() => _ScoreCounterScreenState();
}

class _ScoreCounterScreenState extends State<ScoreCounterScreen> {
  int _team1Score = 0;
  int _team2Score = 0;
  // Histórico de lances para o botão "Voltar Lance"
  final List<ScoreAction> _scoreHistory = [];

  // Adiciona pontos a um time e registra no histórico
  void _addPoints(String team, int points) {
    setState(() {
      if (team == 'team1') {
        _team1Score += points;
      } else {
        _team2Score += points;
      }
      _scoreHistory.add(ScoreAction(team, points));
    });
  }

  // Desfaz o último lance registrado
  void _undoLastScore() {
    if (_scoreHistory.isNotEmpty) {
      setState(() {
        final lastAction = _scoreHistory.removeLast();
        if (lastAction.team == 'team1') {
          _team1Score -= lastAction.points;
        } else {
          _team2Score -= lastAction.points;
        }
      });
    }
  }

  // Reseta os placares e o histórico
  void _resetScores() {
    setState(() {
      _team1Score = 0;
      _team2Score = 0;
      _scoreHistory.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Acessa as strings localizadas
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.appTitle),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // Título principal do jogo
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                appLocalizations.gameTitle,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.deepPurple),
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  // Seção do Time 1
                  _buildTeamSection(
                    appLocalizations.team1Name,
                    _team1Score,
                        (points) => _addPoints('team1', points),
                    Colors.blueAccent,
                  ),
                  // Separador visual
                  const VerticalDivider(width: 1.0, color: Colors.grey),
                  // Seção do Time 2
                  _buildTeamSection(
                    appLocalizations.team2Name,
                    _team2Score,
                        (points) => _addPoints('team2', points),
                    Colors.redAccent,
                  ),
                ],
              ),
            ),
            // Botões de ação (Voltar Lance e Resetar)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _scoreHistory.isNotEmpty ? _undoLastScore : null,
                    icon: const Icon(Icons.undo),
                    label: Text(appLocalizations.undoButton),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _resetScores,
                    icon: const Icon(Icons.refresh),
                    label: Text(appLocalizations.resetButton),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para construir a seção de cada time
  Widget _buildTeamSection(String teamName, int score, Function(int) onAddPoints, Color color) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Nome do Time
          Text(
            teamName,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: color),
          ),
          const SizedBox(height: 20),
          // Placar do Time
          Text(
            '$score',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(color: Colors.black87),
          ),
          const SizedBox(height: 30),
          // Botões de pontuação
          _buildScoreButton(appLocalizations.freeThrowButton, 1, onAddPoints, color),
          _buildScoreButton(appLocalizations.twoPointsButton, 2, onAddPoints, color),
          _buildScoreButton(appLocalizations.threePointsButton, 3, onAddPoints, color),
        ],
      ),
    );
  }

  // Widget auxiliar para construir um botão de pontuação
  Widget _buildScoreButton(String text, int points, Function(int) onAddPoints, Color buttonColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () => onAddPoints(points),
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          textStyle: Theme.of(context).textTheme.bodyLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5, // Sombra para o botão
        ),
        child: Text(text),
      ),
    );
  }
}
