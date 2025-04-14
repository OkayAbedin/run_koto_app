import 'package:flutter/foundation.dart';

class BallHistory {
  final int runs;
  final bool isWicket;
  final int over;
  final int ball;
  final bool isWide;
  final bool isNoBall;

  BallHistory({
    required this.runs,
    required this.isWicket,
    required this.over,
    required this.ball,
    this.isWide = false,
    this.isNoBall = false,
  });
}

class MatchState extends ChangeNotifier {
  String team1Name = '';
  String team2Name = '';
  int currentInnings = 1;
  int totalOvers = 20;
  int playersPerTeam = 11;
  int currentOver = 0;
  int currentBall = 0;
  int runs = 0;
  int wickets = 0;
  int extras = 0;
  List<int> firstInningsScore = [];
  List<int> secondInningsScore = [];
  List<BallHistory> firstInningsBallHistory = [];
  List<BallHistory> secondInningsBallHistory = [];
  bool isMatchComplete = false;

  // Toss related properties
  String? tossWinner;
  String? battingFirst;

  void setTossResult(String winner, String battingTeam) {
    tossWinner = winner;
    battingFirst = battingTeam;
    notifyListeners();
  }

  void setTeamNames(String team1, String team2) {
    team1Name = team1;
    team2Name = team2;
    notifyListeners();
  }

  void setMatchConfig(int overs, int players) {
    totalOvers = overs;
    playersPerTeam = players;
    notifyListeners();
  }

  void startNewInnings() {
    currentOver = 0;
    currentBall = 0;
    runs = 0;
    wickets = 0;
    extras = 0;
  }

  void addBallOutcome(int runs) {
    if (isMatchComplete) return;

    this.runs += runs;
    currentBall++;

    final ballHistory = BallHistory(
      runs: runs,
      isWicket: false,
      over: currentOver,
      ball: currentBall,
    );

    if (currentInnings == 1) {
      firstInningsScore.add(runs);
      firstInningsBallHistory.add(ballHistory);
    } else {
      secondInningsScore.add(runs);
      secondInningsBallHistory.add(ballHistory);
      if (secondInningsScore.reduce((a, b) => a + b) >
          firstInningsScore.reduce((a, b) => a + b)) {
        isMatchComplete = true;
      }
    }

    if (currentBall == 6) {
      currentBall = 0;
      currentOver++;
      if (currentOver == totalOvers) {
        if (currentInnings == 1) {
          currentInnings = 2;
          startNewInnings();
        } else {
          isMatchComplete = true;
        }
      }
    }
    notifyListeners();
  }

  void addWicket() {
    if (wickets < playersPerTeam - 1) {
      wickets++;
      final ballHistory = BallHistory(
        runs: 0,
        isWicket: true,
        over: currentOver,
        ball: currentBall + 1,
      );

      if (currentInnings == 1) {
        firstInningsBallHistory.add(ballHistory);
      } else {
        secondInningsBallHistory.add(ballHistory);
      }

      currentBall++;
      if (currentBall == 6) {
        currentBall = 0;
        currentOver++;
      }

      if (wickets == playersPerTeam - 1) {
        if (currentInnings == 1) {
          currentInnings = 2;
          startNewInnings();
        } else {
          isMatchComplete = true;
        }
      }
      notifyListeners();
    }
  }

  void addWide() {
    if (isMatchComplete) return;

    // Add 1 run for wide
    runs += 1;
    extras += 1;

    final ballHistory = BallHistory(
      runs: 1,
      isWicket: false,
      over: currentOver,
      ball: currentBall,
      isWide: true,
    );

    if (currentInnings == 1) {
      firstInningsScore.add(1);
      firstInningsBallHistory.add(ballHistory);
    } else {
      secondInningsScore.add(1);
      secondInningsBallHistory.add(ballHistory);
      if (secondInningsScore.reduce((a, b) => a + b) >
          firstInningsScore.reduce((a, b) => a + b)) {
        isMatchComplete = true;
      }
    }

    // Wide doesn't count as a legal delivery, so we don't increment the ball count
    notifyListeners();
  }

  void addNoBall([int additionalRuns = 0]) {
    if (isMatchComplete) return;

    // Add 1 run for no ball + any additional runs scored
    runs += 1 + additionalRuns;
    extras += 1;

    final ballHistory = BallHistory(
      runs: 1 + additionalRuns,
      isWicket: false,
      over: currentOver,
      ball: currentBall,
      isNoBall: true,
    );

    if (currentInnings == 1) {
      firstInningsScore.add(1 + additionalRuns);
      firstInningsBallHistory.add(ballHistory);
    } else {
      secondInningsScore.add(1 + additionalRuns);
      secondInningsBallHistory.add(ballHistory);
      if (secondInningsScore.reduce((a, b) => a + b) >
          firstInningsScore.reduce((a, b) => a + b)) {
        isMatchComplete = true;
      }
    }

    // No ball doesn't count as a legal delivery, so we don't increment the ball count
    notifyListeners();
  }

  void addWideWithRuns(int extraRuns) {
    if (isMatchComplete) return;

    // Add 1 run for wide + any additional runs
    runs += 1 + extraRuns;
    extras += 1 + extraRuns;

    final ballHistory = BallHistory(
      runs: 1 + extraRuns,
      isWicket: false,
      over: currentOver,
      ball: currentBall,
      isWide: true,
    );

    if (currentInnings == 1) {
      firstInningsScore.add(1 + extraRuns);
      firstInningsBallHistory.add(ballHistory);
    } else {
      secondInningsScore.add(1 + extraRuns);
      secondInningsBallHistory.add(ballHistory);
      if (secondInningsScore.reduce((a, b) => a + b) >
          firstInningsScore.reduce((a, b) => a + b)) {
        isMatchComplete = true;
      }
    }

    notifyListeners();
  }

  String getCurrentScore() {
    return '$runs/$wickets';
  }

  String getOvers() {
    return '$currentOver.${currentBall}';
  }

  List<BallHistory> getCurrentInningsBallHistory() {
    return currentInnings == 1
        ? firstInningsBallHistory
        : secondInningsBallHistory;
  }

  Map<String, dynamic> getMatchSummary() {
    final firstInningsTotal = firstInningsScore.isEmpty
        ? 0
        : firstInningsScore.reduce((a, b) => a + b);
    final secondInningsTotal = secondInningsScore.isEmpty
        ? 0
        : secondInningsScore.reduce((a, b) => a + b);

    return {
      'team1': {
        'name': team1Name,
        'score': firstInningsTotal,
        'ballHistory': firstInningsBallHistory,
      },
      'team2': {
        'name': team2Name,
        'score': secondInningsTotal,
        'ballHistory': secondInningsBallHistory,
      },
      'winner': isMatchComplete
          ? (secondInningsTotal > firstInningsTotal ? team2Name : team1Name)
          : null,
    };
  }
}
