import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/match_state.dart';
import '../widgets/app_drawer.dart';
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
          drawer: const AppDrawer(),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF121212),
                  Color(0xFF181818),
                  Color(0xFF121212),
                ],
              ),
            ),
            child: matchState.isMatchComplete
                ? _buildMatchSummary(context, matchState)
                : _buildScoringUI(context, matchState),
          ),
        );
      },
    );
  }

  Widget _buildScoringUI(BuildContext context, MatchState matchState) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Card(
          margin: const EdgeInsets.all(16),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SCORE',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Text(
                          '${matchState.getCurrentScore()}',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'OVERS',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Text(
                          '${matchState.getOvers()}',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (matchState.currentInnings == 2)
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: theme.colorScheme.primary.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.flag,
                          color: theme.colorScheme.primary,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'TARGET: ${matchState.firstInningsScore.reduce((a, b) => a + b) + 1}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.history,
                      color: Colors.grey[400],
                      size: 18,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'BALL HISTORY',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[400],
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _buildBallHistory(matchState, theme),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF212121),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Icon(
                            Icons.sports_cricket,
                            color: Colors.grey[400],
                            size: 18,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'SCORING OPTIONS',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[400],
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        // First row: 0 and 1 (two larger buttons)
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 12, right: 6),
                                child: _buildRunButton(
                                    context, 0, matchState, theme),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 12, left: 6),
                                child: _buildRunButton(
                                    context, 1, matchState, theme),
                              ),
                            ),
                          ],
                        ),

                        // Second row: 2, 3, 4, 6
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 12, right: 6),
                                child: _buildRunButton(
                                    context, 2, matchState, theme),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 12, left: 6, right: 6),
                                child: _buildRunButton(
                                    context, 3, matchState, theme),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 12, left: 6, right: 6),
                                child: _buildRunButton(
                                    context, 4, matchState, theme),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 12, left: 6),
                                child: _buildRunButton(
                                    context, 6, matchState, theme),
                              ),
                            ),
                          ],
                        ),

                        // Third row: 5, Wide, No Ball, Wicket
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: _buildRunButton(
                                    context, 5, matchState, theme),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: _buildSpecialButton(
                                  context,
                                  'Wide',
                                  Colors.orangeAccent,
                                  () => _showWideDialog(
                                      context, matchState, theme),
                                  theme,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: _buildSpecialButton(
                                  context,
                                  'No Ball',
                                  Colors.purpleAccent,
                                  () => _showNoBallDialog(
                                      context, matchState, theme),
                                  theme,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: _buildSpecialButton(
                                  context,
                                  'Wicket',
                                  Colors.redAccent,
                                  () => matchState.addWicket(),
                                  theme,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Update the _buildRunButton method for larger buttons
  Widget _buildRunButton(
      BuildContext context, int runs, MatchState matchState, ThemeData theme) {
    return ElevatedButton(
      onPressed: () => matchState.addBallOutcome(runs),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        elevation: 2, // Added slight elevation for better visual feedback
        minimumSize: Size(0, 60), // Increased height for better touch targets
        backgroundColor: runs == 0
            ? Color(0xFF333333)
            : runs == 4 || runs == 6
                ? theme.colorScheme.primary
                : Color(0xFF2E2E2E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        '$runs',
        style: TextStyle(
          fontSize: 26, // Increased font size
          fontWeight: FontWeight.bold,
          color: runs == 4 || runs == 6 ? Colors.white : Colors.grey[300],
        ),
      ),
    );
  }

  // Update the _buildSpecialButton method for larger special buttons
  Widget _buildSpecialButton(BuildContext context, String label, Color color,
      VoidCallback onPressed, ThemeData theme,
      {double fontSize = 18}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        elevation: 2, // Added slight elevation
        minimumSize: Size(0, 60), // Increased height to match run buttons
        backgroundColor: color.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
              color: color.withOpacity(0.7), width: 1.5), // Thicker border
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: fontSize + 2, // Increased font size
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget _buildBallHistory(MatchState matchState, ThemeData theme) {
    final ballHistory = matchState.getCurrentInningsBallHistory();
    if (ballHistory.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.sports_cricket_outlined,
              color: Colors.grey[600],
              size: 48,
            ),
            SizedBox(height: 16),
            Text(
              'No balls bowled yet',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: ballHistory.length,
      itemBuilder: (context, index) {
        final reversedIndex = ballHistory.length - 1 - index;
        final currentBall = ballHistory[reversedIndex];

        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Color(0xFF212121),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _getBallColor(currentBall, theme).withOpacity(0.3),
              width: 1,
            ),
          ),
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _getBallColor(currentBall, theme).withOpacity(0.15),
                shape: BoxShape.circle,
                border: Border.all(
                  color: _getBallColor(currentBall, theme),
                  width: 2,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                currentBall.isWicket ? 'W' : '${currentBall.runs}',
                style: TextStyle(
                  color: _getBallColor(currentBall, theme),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            title: Text(
              'Over ${currentBall.over}.${currentBall.ball}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              _getBallTypeText(currentBall),
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12,
              ),
            ),
            trailing: Text(
              currentBall.isWicket ? 'WICKET!' : '+${currentBall.runs} runs',
              style: TextStyle(
                color: _getBallColor(currentBall, theme),
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
    final theme = Theme.of(context);
    final summary = matchState.getMatchSummary();

    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.emoji_events,
                color: theme.colorScheme.primary,
                size: 56,
              ),
              const SizedBox(height: 24),
              Text(
                'MATCH COMPLETE',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Match Summary',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 32),
              _buildTeamScore(
                  summary['team1']['name'], summary['team1']['score'], theme),
              Divider(color: Colors.grey[800], height: 32),
              _buildTeamScore(
                  summary['team2']['name'], summary['team2']['score'], theme),
              const SizedBox(height: 32),
              Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: theme.colorScheme.primary,
                    width: 2,
                  ),
                ),
                child: Text(
                  'WINNER: ${summary['winner']}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const MatchSetupScreen(),
                    ),
                  );
                },
                icon: Icon(Icons.add_circle),
                label: Text('START NEW MATCH'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeamScore(String teamName, int score, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          teamName,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        Text(
          score.toString(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  void _showWideDialog(
      BuildContext context, MatchState matchState, ThemeData theme) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xFF212121),
          title: Text(
            'Wide Ball',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'Additional runs from the wide?',
            style: TextStyle(color: Colors.grey[300]),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          actions: [
            _dialogButton(
              context,
              'Just Wide (+1)',
              () {
                matchState.addWide();
                Navigator.of(context).pop();
              },
              theme,
            ),
            for (int i = 1; i <= 4; i++)
              _dialogButton(
                context,
                'Wide + $i runs',
                () {
                  matchState.addWideWithRuns(i);
                  Navigator.of(context).pop();
                },
                theme,
              ),
          ],
        );
      },
    );
  }

  void _showNoBallDialog(
      BuildContext context, MatchState matchState, ThemeData theme) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xFF212121),
          title: Text(
            'No Ball',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'Additional runs from the no ball?',
            style: TextStyle(color: Colors.grey[300]),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          actions: [
            _dialogButton(
              context,
              'Just No Ball (+1)',
              () {
                matchState.addNoBall();
                Navigator.of(context).pop();
              },
              theme,
            ),
            for (int i = 1; i <= 6; i++)
              _dialogButton(
                context,
                'No Ball + $i runs',
                () {
                  matchState.addNoBall(i);
                  Navigator.of(context).pop();
                },
                theme,
              ),
          ],
        );
      },
    );
  }

  Widget _dialogButton(BuildContext context, String text,
      VoidCallback onPressed, ThemeData theme) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: theme.colorScheme.primary,
        textStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
      child: Text(text),
    );
  }

  String _getBallTypeText(BallHistory ball) {
    if (ball.isWide) return 'Wide Ball';
    if (ball.isNoBall) return 'No Ball';
    return 'Legal Delivery';
  }

  Color _getBallColor(BallHistory ball, ThemeData theme) {
    if (ball.isWicket) return Colors.redAccent;
    if (ball.isWide) return Colors.orangeAccent;
    if (ball.isNoBall) return Colors.purpleAccent;
    if (ball.runs == 4 || ball.runs == 6) return theme.colorScheme.primary;
    return Colors.white;
  }
}
