import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/match_setup_screen.dart';
import 'models/match_state.dart';

void main() {
  runApp(const CricketTrackerApp());
}

class CricketTrackerApp extends StatelessWidget {
  const CricketTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MatchState(),
      child: MaterialApp(
        title: 'Cricket Run Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.grey[100],
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            elevation: 1,
          ),
        ),
        home: const MatchSetupScreen(),
      ),
    );
  }
}
