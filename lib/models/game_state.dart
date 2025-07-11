import 'player_profile.dart';

class GameState {
  String playerName;
  int currentScore;
  int legsWon;
  int totalLegs;
  List<Turn> turns;
  int currentTurn;

  GameState({
    this.playerName = 'Guest',
    this.currentScore = 501, // Standard 501 dart game
    this.legsWon = 0,
    this.totalLegs = 1,
    this.turns = const [],
    this.currentTurn = 1,
  });

  double get average {
    if (turns.isEmpty) return 0.0;
    int totalThrows = 0;
    int totalScore = 0;
    
    for (var turn in turns) {
      for (var dart in turn.darts) {
        if (dart.score > 0) {
          totalThrows++;
          totalScore += dart.score;
        }
      }
    }
    
    return totalThrows > 0 ? totalScore / totalThrows : 0.0;
  }

  int get remainingScore => currentScore;

  void addTurn(Turn turn) {
    turns = [...turns, turn];
    currentScore -= turn.totalScore;
    currentTurn++;
  }

  void updateTurn(int index, Turn newTurn) {
    if (index >= 0 && index < turns.length) {
      final oldTurn = turns[index];
      turns = [
        ...turns.sublist(0, index),
        newTurn,
        ...turns.sublist(index + 1)
      ];
      
      // Recalculate score
      currentScore += oldTurn.totalScore - newTurn.totalScore;
    }
  }

  void endTurn() {
    // Logic for ending current turn
  }

  GameHistory toGameHistory() {
    return GameHistory(
      gameId: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      gameType: '501', // Assuming standard game type, adjust as needed
      isWin: legsWon > (totalLegs / 2),
      finalScore: currentScore,
      totalTurns: turns.length,
      gameAverage: average,
      turnScores: turns.map((turn) => turn.totalScore).toList(),
      gameDuration: Duration(minutes: 0), // Placeholder, update if duration tracking is added
    );
  }

  GameState copyWith({
    String? playerName,
    int? currentScore,
    int? legsWon,
    int? totalLegs,
    List<Turn>? turns,
    int? currentTurn,
  }) {
    return GameState(
      playerName: playerName ?? this.playerName,
      currentScore: currentScore ?? this.currentScore,
      legsWon: legsWon ?? this.legsWon,
      totalLegs: totalLegs ?? this.totalLegs,
      turns: turns ?? this.turns,
      currentTurn: currentTurn ?? this.currentTurn,
    );
  }
}

class Turn {
  List<Dart> darts;
  int turnNumber;

  Turn({
    required this.darts,
    required this.turnNumber,
  });

  int get totalScore => darts.fold(0, (sum, dart) => sum + dart.score);

  Turn copyWith({
    List<Dart>? darts,
    int? turnNumber,
  }) {
    return Turn(
      darts: darts ?? this.darts,
      turnNumber: turnNumber ?? this.turnNumber,
    );
  }
}

class Dart {
  int score;
  String multiplier; // 'S' for single, 'D' for double, 'T' for triple, 'B' for bull
  bool isMiss;

  Dart({
    required this.score,
    this.multiplier = 'S',
    this.isMiss = false,
  });

  String get displayText {
    if (isMiss) return '0';
    if (multiplier == 'B') return score == 25 ? 'B' : 'DB';
    return multiplier == 'S' ? '$score' : '$multiplier$score';
  }

  Dart copyWith({
    int? score,
    String? multiplier,
    bool? isMiss,
  }) {
    return Dart(
      score: score ?? this.score,
      multiplier: multiplier ?? this.multiplier,
      isMiss: isMiss ?? this.isMiss,
    );
  }
}
