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
          useMaterial3: true,
          brightness: Brightness.dark,
          colorScheme: ColorScheme.dark(
            primary: Color(0xFF1DB954), // Spotify green
            secondary: Color(0xFF1DB954),
            surface: Color(0xFF121212), // Spotify dark background
            background: Color(0xFF121212),
            error: Colors.redAccent,
          ),
          scaffoldBackgroundColor: Color(0xFF121212),
          appBarTheme: AppBarTheme(
            backgroundColor: Color(0xFF212121),
            foregroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
          ),
          cardTheme: CardTheme(
            color: Color(0xFF212121),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF1DB954),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Color(0xFF333333),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            labelStyle: TextStyle(color: Colors.grey[300]),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFF1DB954), width: 2),
            ),
          ),
          textTheme: TextTheme(
            titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
            bodyLarge: TextStyle(
              color: Colors.grey[300],
            ),
            bodyMedium: TextStyle(
              color: Colors.grey[300],
            ),
          ),
        ),
        home: const MatchSetupScreen(),
      ),
    );
  }
}
