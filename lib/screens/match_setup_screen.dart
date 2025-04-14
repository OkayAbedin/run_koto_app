import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/match_state.dart';
import 'toss_screen.dart';

class MatchSetupScreen extends StatefulWidget {
  const MatchSetupScreen({super.key});

  @override
  State<MatchSetupScreen> createState() => _MatchSetupScreenState();
}

class _MatchSetupScreenState extends State<MatchSetupScreen> {
  final _team1Controller = TextEditingController();
  final _team2Controller = TextEditingController();
  final _oversController = TextEditingController(text: '20');
  int _selectedPlayers = 11;

  @override
  void dispose() {
    _team1Controller.dispose();
    _team2Controller.dispose();
    _oversController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Match'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Match Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _team1Controller,
                    decoration: const InputDecoration(
                      labelText: 'Team 1 Name',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _team2Controller,
                    decoration: const InputDecoration(
                      labelText: 'Team 2 Name',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Match Format',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _oversController,
                    decoration: const InputDecoration(
                      labelText: 'Number of Overs',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter number of overs (1-50)',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<int>(
                    value: _selectedPlayers,
                    decoration: const InputDecoration(
                      labelText: 'Players per Team',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
                        .map((players) => DropdownMenuItem(
                              value: players,
                              child: Text('$players Players'),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedPlayers = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              if (_team1Controller.text.isEmpty ||
                  _team2Controller.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter both team names'),
                  ),
                );
                return;
              }

              final overs = int.tryParse(_oversController.text);
              if (overs == null || overs < 1 || overs > 50) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                        Text('Please enter a valid number of overs (1-50)'),
                  ),
                );
                return;
              }

              final matchState = context.read<MatchState>();
              matchState.setTeamNames(
                _team1Controller.text,
                _team2Controller.text,
              );
              matchState.setMatchConfig(overs, _selectedPlayers);

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const TossScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Start Match',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
