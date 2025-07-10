import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import '../theme/theme_constants.dart';
import '../models/game_state.dart';
import '../models/player_profile.dart';
import '../models/player_state.dart';
import 'score_edit_screen.dart';
import 'player_profile_screen.dart';

class DartTrackingScreen extends StatefulWidget {
  const DartTrackingScreen({Key? key}) : super(key: key);

  @override
  State<DartTrackingScreen> createState() => _DartTrackingScreenState();
}

class _DartTrackingScreenState extends State<DartTrackingScreen> {
  CameraController? _controller;
  bool _isCameraInitialized = false;
  String? _errorMessage;
  late GameState _gameState;
  late PlayerProfile _playerProfile;

  @override
  void initState() {
    super.initState();
    final playerState = Provider.of<PlayerState>(context, listen: false);
    _gameState = playerState.gameState;
    _playerProfile = playerState.playerProfile;
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      _controller = CameraController(cameras.first, ResolutionPreset.high);
      await _controller!.initialize();
      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Cannot find the dartboard. Try repositioning the camera.";
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _navigateToScoreEdit() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScoreEditScreen(
          gameState: _gameState,
          onGameStateChanged: (newGameState) {
            setState(() {
              _gameState = newGameState;
            });
          },
        ),
      ),
    );
  }

  void _navigateToPlayerProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlayerProfileScreen(
          playerProfile: _playerProfile,
          onProfileUpdated: (updatedProfile) {
            setState(() {
              _playerProfile = updatedProfile;
              _gameState = _gameState.copyWith(playerName: updatedProfile.name);
            });
          },
        ),
      ),
    );
  }

  void _endTurn() {
    // Logic for ending the current turn
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        title: const Text(
          'End Turn',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to end this turn?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey[400]),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _gameState.endTurn();
              setState(() {});
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD4AF37),
              foregroundColor: Colors.black,
            ),
            child: const Text('End Turn'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: Column(
          children: [
            // Status bar area
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const Spacer(),
                  // Status indicators (signal, wifi, battery)
                  Row(
                    children: [
                      Icon(Icons.signal_cellular_4_bar, color: Colors.white, size: 16),
                      const SizedBox(width: 4),
                      Icon(Icons.wifi, color: Colors.white, size: 16),
                      const SizedBox(width: 4),
                      Container(
                        width: 24,
                        height: 12,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(1),
                          ),
                          width: 8,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Camera preview area
            Expanded(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xFF2A2A2A),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: _errorMessage != null
                      ? Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                            margin: const EdgeInsets.all(40),
                            decoration: BoxDecoration(
                              color: const Color(0xFF3A3A3A),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              _errorMessage!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : !_isCameraInitialized
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFFD4AF37),
                              ),
                            )
                          : Stack(
                              children: [
                                Positioned.fill(
                                  child: CameraPreview(_controller!),
                                ),
                                // Dartboard detection overlay
                                if (_errorMessage == null)
                                  Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Text(
                                        'Dartboard detected - Ready to track',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                ),
              ),
            ),

            // Player info and score section
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    // Player name and legs
                    GestureDetector(
                      onTap: _navigateToPlayerProfile,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _gameState.playerName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.person_outline,
                            color: Colors.grey[400],
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Legs: ${_gameState.legsWon}/${_gameState.totalLegs}',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Current score
                    Text(
                      '${_gameState.remainingScore}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 72,
                        fontWeight: FontWeight.bold,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Action buttons
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  // Average button
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // Show average details
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Current average: ${_gameState.average.toStringAsFixed(2)}'),
                            backgroundColor: const Color(0xFF2A2A2A),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2A2A2A),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey[700]!,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'AVERAGE',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.0,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _gameState.average.toStringAsFixed(1),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 12),
                  
                  // Last Turns button
                  Expanded(
                    child: GestureDetector(
                      onTap: _navigateToScoreEdit,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2A2A2A),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey[700]!,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.history,
                              color: Color(0xFFD4AF37),
                              size: 24,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Last Turns',
                              style: TextStyle(
                                color: Colors.grey[300],
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 12),
                  
                  // End Turn button
                  Expanded(
                    child: GestureDetector(
                      onTap: _endTurn,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2A2A2A),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey[700]!,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.check_circle_outline,
                              color: Color(0xFF4CAF50),
                              size: 24,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'End Turn',
                              style: TextStyle(
                                color: Colors.grey[300],
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
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
}
