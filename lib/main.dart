import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/splash_screen.dart';
import 'screens/match_setup_screen.dart';
import 'screens/about_screen.dart';
import 'screens/settings_screen.dart';
import 'models/match_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Create and load match state first
  final matchState = MatchState();
  await matchState.loadSettings();

  // Check if this is the first app launch
  final prefs = await SharedPreferences.getInstance();
  final isFirstLaunch = prefs.getBool('first_launch') ?? true;

  // If it's the first launch, set the flag to false for future launches
  if (isFirstLaunch) {
    await prefs.setBool('first_launch', false);
  }

  // Also track if we're coming from a cold start of the app (actual launch)
  // Not just a hot reload or returning to the app
  await prefs.setBool('is_fresh_app_start', true);

  runApp(
    ChangeNotifierProvider.value(
      value: matchState,
      child: MyApp(isFirstLaunch: isFirstLaunch),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isFirstLaunch;

  const MyApp({super.key, required this.isFirstLaunch});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Run Koto?',
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
      // Show SplashScreen only on first app launch, otherwise go directly to MatchSetupScreen
      initialRoute: isFirstLaunch ? '/splash' : '/',
      routes: {
        '/': (context) => const MatchSetupScreen(),
        '/splash': (context) => const SplashScreen(),
        '/about': (context) => const AboutScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
