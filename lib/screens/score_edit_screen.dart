import 'package:flutter/material.dart';
import '../theme/theme_constants.dart';
import '../models/game_state.dart';

class ScoreEditScreen extends StatefulWidget {
  final GameState gameState;
  final Function(GameState) onGameStateChanged;

  const ScoreEditScreen({
    Key? key,
    required this.gameState,
    required this.onGameStateChanged,
  }) : super(key: key);

  @override
  State<ScoreEditScreen> createState() => _ScoreEditScreenState();
}

class _ScoreEditScreenState extends State<ScoreEditScreen> {
  late GameState _gameState;
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    _gameState = widget.gameState;
  }

  void _editDart(int turnIndex, int dartIndex) {
    showDialog(
      context: context,
      builder: (context) => _DartEditDialog(
        dart: _gameState.turns[turnIndex].darts[dartIndex],
        onSave: (newDart) {
          setState(() {
            final turn = _gameState.turns[turnIndex];
            final newDarts = [...turn.darts];
            newDarts[dartIndex] = newDart;
            final newTurn = turn.copyWith(darts: newDarts);
            _gameState.updateTurn(turnIndex, newTurn);
            _hasChanges = true;
          });
        },
      ),
    );
  }

  void _saveChanges() {
    widget.onGameStateChanged(_gameState);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            Text(
              'TURN HISTORY',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.2,
              ),
            ),
            Text(
              _gameState.playerName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  'RECENT TURNS',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'AVG: ${_gameState.average.toStringAsFixed(1)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _gameState.turns.length,
              reverse: true,
              itemBuilder: (context, index) {
                final reversedIndex = _gameState.turns.length - 1 - index;
                final turn = _gameState.turns[reversedIndex];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey[800]!,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Three dart scores
                      ...turn.darts.asMap().entries.map((entry) {
                        final dartIndex = entry.key;
                        final dart = entry.value;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => _editDart(reversedIndex, dartIndex),
                            child: Container(
                              margin: EdgeInsets.only(
                                right: dartIndex < 2 ? 12 : 0,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: const Color(0xFF3A3A3A),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.grey[700]!,
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    dart.displayText,
                                    style: TextStyle(
                                      color: dart.isMiss ? Colors.grey[500] : const Color(0xFFD4AF37),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    dart.multiplier == 'S' ? '${dart.score}' : '${dart.multiplier}${dart.score}',
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  if (dart.score == 0 && !dart.isMiss)
                                    Icon(
                                      Icons.edit,
                                      color: Colors.grey[600],
                                      size: 12,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      
                      // Turn total
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'TOTAL',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${turn.totalScore}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          
          // Bottom action button
          Container(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _hasChanges ? _saveChanges : () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _hasChanges ? const Color(0xFFD4AF37) : Colors.grey[700],
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  _hasChanges ? 'Save Changes' : 'Close',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DartEditDialog extends StatefulWidget {
  final Dart dart;
  final Function(Dart) onSave;

  const _DartEditDialog({
    required this.dart,
    required this.onSave,
  });

  @override
  State<_DartEditDialog> createState() => _DartEditDialogState();
}

class _DartEditDialogState extends State<_DartEditDialog> {
  late int _score;
  late String _multiplier;
  late bool _isMiss;

  @override
  void initState() {
    super.initState();
    _score = widget.dart.score;
    _multiplier = widget.dart.multiplier;
    _isMiss = widget.dart.isMiss;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF2A2A2A),
      title: const Text(
        'Edit Dart',
        style: TextStyle(color: Colors.white),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Score input
          TextField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Score',
              labelStyle: TextStyle(color: Colors.grey[400]),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[600]!),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFD4AF37)),
              ),
            ),
            keyboardType: TextInputType.number,
            controller: TextEditingController(text: _score.toString()),
            onChanged: (value) {
              _score = int.tryParse(value) ?? 0;
            },
          ),
          const SizedBox(height: 16),
          
          // Multiplier selection
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ['S', 'D', 'T'].map((mult) {
              return GestureDetector(
                onTap: () => setState(() => _multiplier = mult),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: _multiplier == mult ? const Color(0xFFD4AF37) : Colors.grey[700],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    mult,
                    style: TextStyle(
                      color: _multiplier == mult ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
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
            widget.onSave(Dart(
              score: _score,
              multiplier: _multiplier,
              isMiss: _isMiss,
            ));
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD4AF37),
            foregroundColor: Colors.black,
          ),
          child: const Text('Save'),
        ),
      ],
    );
  }
}
