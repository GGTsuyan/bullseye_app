import 'package:flutter/material.dart';
import '../theme/theme_constants.dart';
import '../models/player_profile.dart';

class GameHistoryScreen extends StatefulWidget {
  final PlayerProfile playerProfile;

  const GameHistoryScreen({
    Key? key,
    required this.playerProfile,
  }) : super(key: key);

  @override
  State<GameHistoryScreen> createState() => _GameHistoryScreenState();
}

class _GameHistoryScreenState extends State<GameHistoryScreen> {
  String _selectedFilter = 'All';
  final List<String> _filterOptions = ['All', 'Wins', 'Losses', 'This Week', 'This Month'];

  List<GameHistory> get _filteredHistory {
    List<GameHistory> filtered = widget.playerProfile.gameHistory;
    
    switch (_selectedFilter) {
      case 'Wins':
        filtered = filtered.where((game) => game.isWin).toList();
        break;
      case 'Losses':
        filtered = filtered.where((game) => !game.isWin).toList();
        break;
      case 'This Week':
        final weekAgo = DateTime.now().subtract(const Duration(days: 7));
        filtered = filtered.where((game) => game.date.isAfter(weekAgo)).toList();
        break;
      case 'This Month':
        final monthAgo = DateTime.now().subtract(const Duration(days: 30));
        filtered = filtered.where((game) => game.date.isAfter(monthAgo)).toList();
        break;
    }
    
    return filtered..sort((a, b) => b.date.compareTo(a.date));
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
              'GAME HISTORY',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.2,
              ),
            ),
            Text(
              widget.playerProfile.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Stats Overview
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey[800]!, width: 1),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem(
                      'Games',
                      '${widget.playerProfile.stats.totalGamesPlayed}',
                      Icons.sports_esports,
                    ),
                    _buildStatItem(
                      'Wins',
                      '${widget.playerProfile.stats.totalGamesWon}',
                      Icons.emoji_events,
                    ),
                    _buildStatItem(
                      'Win Rate',
                      '${widget.playerProfile.stats.winPercentage.toStringAsFixed(1)}%',
                      Icons.trending_up,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem(
                      'Average',
                      widget.playerProfile.stats.averageScore.toStringAsFixed(1),
                      Icons.analytics,
                    ),
                    _buildStatItem(
                      'High Score',
                      '${widget.playerProfile.stats.highestScore}',
                      Icons.star,
                    ),
                    _buildStatItem(
                      'Darts',
                      '${widget.playerProfile.stats.totalDartsThrown}',
                      Icons.my_location,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Filter Options
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _filterOptions.length,
              itemBuilder: (context, index) {
                final option = _filterOptions[index];
                final isSelected = _selectedFilter == option;
                return GestureDetector(
                  onTap: () => setState(() => _selectedFilter = option),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFFD4AF37) : const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: isSelected ? const Color(0xFFD4AF37) : Colors.grey[700]!,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      option,
                      style: TextStyle(
                        color: isSelected ? Colors.black : Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // Game History List
          Expanded(
            child: _filteredHistory.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.history,
                          size: 64,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No games found',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Start playing to see your history here',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _filteredHistory.length,
                    itemBuilder: (context, index) {
                      final game = _filteredHistory[index];
                      return _buildGameHistoryItem(game);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: const Color(0xFFD4AF37),
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildGameHistoryItem(GameHistory game) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: game.isWin ? const Color(0xFF4CAF50) : Colors.grey[700]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Win/Loss indicator
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: game.isWin ? const Color(0xFF4CAF50) : const Color(0xFFFF5252),
              shape: BoxShape.circle,
            ),
            child: Icon(
              game.isWin ? Icons.check : Icons.close,
              color: Colors.white,
              size: 20,
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Game details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      game.gameType,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      game.formattedDate,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildGameDetail('Score', '${game.finalScore}'),
                    const SizedBox(width: 16),
                    _buildGameDetail('Turns', '${game.totalTurns}'),
                    const SizedBox(width: 16),
                    _buildGameDetail('Avg', game.gameAverage.toStringAsFixed(1)),
                    const Spacer(),
                    Text(
                      game.formattedDuration,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 8),
          
          // Expand arrow
          Icon(
            Icons.chevron_right,
            color: Colors.grey[600],
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildGameDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
