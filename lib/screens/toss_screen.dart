import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/match_state.dart';
import 'scoring_screen.dart';
import 'dart:math';

class TossScreen extends StatefulWidget {
  const TossScreen({super.key});

  @override
  State<TossScreen> createState() => _TossScreenState();
}

class _TossScreenState extends State<TossScreen> {
  String? tossWinner;
  String? battingTeam;
  bool isTossComplete = false;
  bool isAnimating = false;

  void performToss(MatchState matchState) {
    setState(() {
      isAnimating = true;
    });

    // Simulate coin toss animation
    Future.delayed(const Duration(seconds: 2), () {
      final random = Random();
      setState(() {
        tossWinner =
            random.nextBool() ? matchState.team1Name : matchState.team2Name;
        isTossComplete = true;
        isAnimating = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<MatchState>(
      builder: (context, matchState, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Toss'),
            centerTitle: true,
          ),
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
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (!isTossComplete) ...[
                    Card(
                      margin: const EdgeInsets.only(bottom: 32),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            Text(
                              'Match',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '${matchState.team1Name}',
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                'VS',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[400],
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),
                            Text(
                              '${matchState.team2Name}',
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (isAnimating)
                      Column(
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: CircularProgressIndicator(
                              color: theme.colorScheme.primary,
                              strokeWidth: 8,
                            ),
                          ),
                          SizedBox(height: 24),
                          Text(
                            'Tossing coin...',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.grey[300],
                            ),
                          ),
                        ],
                      )
                    else
                      ElevatedButton(
                        onPressed: () => performToss(matchState),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.flip),
                            SizedBox(width: 8),
                            Text(
                              'TOSS COIN',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ] else ...[
                    Container(
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: theme.colorScheme.primary,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.emoji_events,
                            color: theme.colorScheme.primary,
                            size: 48,
                          ),
                          SizedBox(height: 16),
                          Text(
                            '$tossWinner',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'won the toss!',
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: Colors.grey[300],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32),
                    Text(
                      'Choose what to do:',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.grey[400],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          battingTeam = tossWinner;
                        });
                        matchState.setTossResult(tossWinner!, tossWinner!);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const ScoringScreen(),
                          ),
                        );
                      },
                      icon: Icon(Icons.sports_cricket),
                      label: Text('BAT FIRST'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: () {
                        final fieldingTeam = tossWinner == matchState.team1Name
                            ? matchState.team2Name
                            : matchState.team1Name;
                        setState(() {
                          battingTeam = fieldingTeam;
                        });
                        matchState.setTossResult(tossWinner!, fieldingTeam);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const ScoringScreen(),
                          ),
                        );
                      },
                      icon: Icon(Icons.sports_baseball),
                      label: Text('FIELD FIRST'),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        foregroundColor: Colors.white,
                        side: BorderSide(color: Colors.grey[600]!),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
