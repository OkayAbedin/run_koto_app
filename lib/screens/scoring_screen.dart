import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/match_state.dart';
import 'match_setup_screen.dart';

class ScoringScreen extends StatelessWidget {
  const ScoringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MatchState>(
      builder: (context, matchState, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              matchState.currentInnings == 1
                  ? '${matchState.team1Name} Batting'
                  : '${matchState.team2Name} Batting',
            ),
            centerTitle: true,
          ),
          body: matchState.isMatchComplete
              ? _buildMatchSummary(context, matchState)
              : _buildScoringUI(context, matchState),
        );
      },
    );
  }

  Widget _buildScoringUI(BuildContext context, MatchState matchState) {
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Score: ${matchState.getCurrentScore()}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Overs: ${matchState.getOvers()}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                if (matchState.currentInnings == 2)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Target: ${matchState.firstInningsScore.reduce((a, b) => a + b) + 1}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: _buildBallHistory(matchState),
              ),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                padding: const EdgeInsets.all(16),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  for (int i = 0; i <= 6; i++)
                    ElevatedButton(
                      onPressed: () => matchState.addBallOutcome(i),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        '$i',
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ElevatedButton(
                    onPressed: () => matchState.addWicket(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'W',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  // Add new buttons for Wide and No Ball
                  ElevatedButton(
                    onPressed: () => _showWideDialog(context, matchState),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Wide',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _showNoBallDialog(context, matchState),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'No Ball',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBallHistory(MatchState matchState) {
    final ballHistory = matchState.getCurrentInningsBallHistory();
    if (ballHistory.isEmpty) {
      return const Center(
        child: Text(
          'No balls bowled yet',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: ballHistory.length,
      itemBuilder: (context, index) {
        final ball = ballHistory[index];
        final reversedIndex = ballHistory.length - 1 - index;
        final currentBall = ballHistory[reversedIndex];

        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: currentBall.isWicket ? Colors.red : Colors.blue,
              child: Text(
                currentBall.isWicket ? 'W' : '${currentBall.runs}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              'Over ${currentBall.over}.${currentBall.ball}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              _getBallTypeText(currentBall),
              style: TextStyle(
                color: _getBallTypeColor(currentBall),
              ),
            ),
            trailing: Text(
              currentBall.isWicket ? 'WICKET!' : '+${currentBall.runs} runs',
              style: TextStyle(
                color: currentBall.isWicket ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
      reverse: true,
    );
  }

  Widget _buildMatchSummary(BuildContext context, MatchState matchState) {
    final summary = matchState.getMatchSummary();
    return Center(
      child: Card(
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Match Summary',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              _buildTeamScore(
                  summary['team1']['name'], summary['team1']['score']),
              const SizedBox(height: 16),
              _buildTeamScore(
                  summary['team2']['name'], summary['team2']['score']),
              const SizedBox(height: 24),
              Text(
                'Winner: ${summary['winner']}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const MatchSetupScreen(),
                    ),
                  );
                },
                child: const Text('Start New Match'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeamScore(String teamName, int score) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          teamName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          score.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _showWideDialog(BuildContext context, MatchState matchState) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Wide Ball'),
          content: const Text('Additional runs from the wide?'),
          actions: [
            TextButton(
              onPressed: () {
                matchState.addWide();
                Navigator.of(context).pop();
              },
              child: const Text('Just Wide (+1)'),
            ),
            for (int i = 1; i <= 4; i++)
              TextButton(
                onPressed: () {
                  matchState.addWideWithRuns(i);
                  Navigator.of(context).pop();
                },
                child: Text('Wide + $i runs'),
              ),
          ],
        );
      },
    );
  }

  void _showNoBallDialog(BuildContext context, MatchState matchState) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('No Ball'),
          content: const Text('Additional runs from the no ball?'),
          actions: [
            TextButton(
              onPressed: () {
                matchState.addNoBall();
                Navigator.of(context).pop();
              },
              child: const Text('Just No Ball (+1)'),
            ),
            for (int i = 1; i <= 6; i++)
              TextButton(
                onPressed: () {
                  matchState.addNoBall(i);
                  Navigator.of(context).pop();
                },
                child: Text('No Ball + $i runs'),
              ),
          ],
        );
      },
    );
  }

  String _getBallTypeText(BallHistory ball) {
    if (ball.isWide) return 'Wide Ball';
    if (ball.isNoBall) return 'No Ball';
    return 'Legal Delivery';
  }

  Color _getBallTypeColor(BallHistory ball) {
    if (ball.isWide) return Colors.orange;
    if (ball.isNoBall) return Colors.purple;
    return Colors.black87;
  }
}
