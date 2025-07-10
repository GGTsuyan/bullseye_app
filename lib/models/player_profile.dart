class PlayerProfile {
  String name;
  String avatar;
  DateTime joinDate;
  PlayerStats stats;
  List<GameHistory> gameHistory;
  PlayerPreferences preferences;

  PlayerProfile({
    required this.name,
    this.avatar = '',
    required this.joinDate,
    required this.stats,
    this.gameHistory = const [],
    required this.preferences,
  });

  PlayerProfile copyWith({
    String? name,
    String? avatar,
    DateTime? joinDate,
    PlayerStats? stats,
    List<GameHistory>? gameHistory,
    PlayerPreferences? preferences,
  }) {
    return PlayerProfile(
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      joinDate: joinDate ?? this.joinDate,
      stats: stats ?? this.stats,
      gameHistory: gameHistory ?? this.gameHistory,
      preferences: preferences ?? this.preferences,
    );
  }
}

class PlayerStats {
  int totalGamesPlayed;
  int totalGamesWon;
  double averageScore;
  int highestScore;
  int totalDartsThrown;
  int bullseyes;
  int doubles;
  int triples;
  List<int> finishOuts;
  double winPercentage;

  PlayerStats({
    this.totalGamesPlayed = 0,
    this.totalGamesWon = 0,
    this.averageScore = 0.0,
    this.highestScore = 0,
    this.totalDartsThrown = 0,
    this.bullseyes = 0,
    this.doubles = 0,
    this.triples = 0,
    this.finishOuts = const [],
    this.winPercentage = 0.0,
  });

  PlayerStats copyWith({
    int? totalGamesPlayed,
    int? totalGamesWon,
    double? averageScore,
    int? highestScore,
    int? totalDartsThrown,
    int? bullseyes,
    int? doubles,
    int? triples,
    List<int>? finishOuts,
    double? winPercentage,
  }) {
    return PlayerStats(
      totalGamesPlayed: totalGamesPlayed ?? this.totalGamesPlayed,
      totalGamesWon: totalGamesWon ?? this.totalGamesWon,
      averageScore: averageScore ?? this.averageScore,
      highestScore: highestScore ?? this.highestScore,
      totalDartsThrown: totalDartsThrown ?? this.totalDartsThrown,
      bullseyes: bullseyes ?? this.bullseyes,
      doubles: doubles ?? this.doubles,
      triples: triples ?? this.triples,
      finishOuts: finishOuts ?? this.finishOuts,
      winPercentage: winPercentage ?? this.winPercentage,
    );
  }
}

class GameHistory {
  String gameId;
  DateTime date;
  String gameType;
  bool isWin;
  int finalScore;
  int totalTurns;
  double gameAverage;
  List<int> turnScores;
  Duration gameDuration;

  GameHistory({
    required this.gameId,
    required this.date,
    required this.gameType,
    required this.isWin,
    required this.finalScore,
    required this.totalTurns,
    required this.gameAverage,
    required this.turnScores,
    required this.gameDuration,
  });

  String get formattedDate {
    return '${date.day}/${date.month}/${date.year}';
  }

  String get formattedDuration {
    final minutes = gameDuration.inMinutes;
    final seconds = gameDuration.inSeconds % 60;
    return '${minutes}m ${seconds}s';
  }

  GameHistory copyWith({
    String? gameId,
    DateTime? date,
    String? gameType,
    bool? isWin,
    int? finalScore,
    int? totalTurns,
    double? gameAverage,
    List<int>? turnScores,
    Duration? gameDuration,
  }) {
    return GameHistory(
      gameId: gameId ?? this.gameId,
      date: date ?? this.date,
      gameType: gameType ?? this.gameType,
      isWin: isWin ?? this.isWin,
      finalScore: finalScore ?? this.finalScore,
      totalTurns: totalTurns ?? this.totalTurns,
      gameAverage: gameAverage ?? this.gameAverage,
      turnScores: turnScores ?? this.turnScores,
      gameDuration: gameDuration ?? this.gameDuration,
    );
  }
}

class PlayerPreferences {
  String preferredGameType;
  bool soundEnabled;
  bool vibrationEnabled;
  String theme;
  bool autoSave;

  PlayerPreferences({
    this.preferredGameType = '501',
    this.soundEnabled = true,
    this.vibrationEnabled = true,
    this.theme = 'dark',
    this.autoSave = true,
  });

  PlayerPreferences copyWith({
    String? preferredGameType,
    bool? soundEnabled,
    bool? vibrationEnabled,
    String? theme,
    bool? autoSave,
  }) {
    return PlayerPreferences(
      preferredGameType: preferredGameType ?? this.preferredGameType,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      theme: theme ?? this.theme,
      autoSave: autoSave ?? this.autoSave,
    );
  }
}
