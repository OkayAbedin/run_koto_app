import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../screens/about_screen.dart';
import '../screens/settings_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      backgroundColor: Color(0xFF212121),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1DB954),
                  Color(0xFF1DB954).withOpacity(0.7),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.sports_cricket,
                  color: Colors.white,
                  size: 48,
                ),
                const SizedBox(height: 12),
                Text(
                  'Run Koto',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Cricket Scoring App',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.sports_cricket, color: Colors.white),
            title: const Text('New Match'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/',
                (route) => false,
              );
            },
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.white),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline, color: Colors.white),
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutScreen()),
              );
            },
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.feedback_outlined, color: Colors.white),
            title: const Text('Feedback'),
            onTap: () async {
              Navigator.pop(context);
              // Open GitHub repository for feedback
              final Uri url =
                  Uri.parse('https://github.com/OkayAbedin/run_koto_app');
              try {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Could not open URL: $e')),
                  );
                }
              }
            },
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Version 1.0.0',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
