import 'package:flutter/foundation.dart';
import 'game_state.dart';
import 'player_profile.dart';

class PlayerState extends ChangeNotifier {
  PlayerProfile _playerProfile;
  GameState _gameState;

  PlayerState()
      : _playerProfile = PlayerProfile(
          name: 'Guest',
          joinDate: DateTime.now(),
          stats: PlayerStats(),
          preferences: PlayerPreferences(),
        ),
        _gameState = GameState();

  PlayerProfile get playerProfile => _playerProfile;
  GameState get gameState => _gameState;

  void updatePlayerName(String name) {
    _playerProfile = _playerProfile.copyWith(name: name);
    _gameState = _gameState.copyWith(playerName: name);
    notifyListeners();
  }

  void updatePlayerProfile(PlayerProfile profile) {
    _playerProfile = profile;
    notifyListeners();
  }

  void updateGameState(GameState gameState) {
    _gameState = gameState;
    notifyListeners();
  }
}
