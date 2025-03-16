import 'package:flutter/material.dart';
import '../modules/game.dart'; // Import the game class

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<int> _dice = [1, 1, 1];
  final GameState _gameState = GameState(); // Create an instance of the GameState class

  void _rollDice() {
    setState(() {
      _dice = _gameState.rollDice();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cee-Lo Big Bank Edition'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _dice.map((value) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  value.toString(),
                  style: const TextStyle(fontSize: 24),
                ),
              )).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _rollDice,
              child: const Text('Roll Dice'),
            ),
            const SizedBox(height: 20),
            Text(
              _gameState.determineOutcome(_dice), // Use the game logic to determine the outcome
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}

