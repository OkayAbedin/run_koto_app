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

  void performToss(MatchState matchState) {
    final random = Random();
    setState(() {
      tossWinner =
          random.nextBool() ? matchState.team1Name : matchState.team2Name;
      isTossComplete = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MatchState>(
      builder: (context, matchState, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Toss'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (!isTossComplete) ...[
                  Text(
                    '${matchState.team1Name} vs ${matchState.team2Name}',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () => performToss(matchState),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Perform Toss'),
                  ),
                ] else ...[
                  Text(
                    '$tossWinner won the toss!',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Choose what to do:',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
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
                    child: const Text('Bat First'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
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
                    child: const Text('Field First'),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
