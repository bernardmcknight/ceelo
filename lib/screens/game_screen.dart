import 'package:flutter/material.dart';
import 'dart:math';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<int> _dice = [1, 1, 1];
  final Game _game = Game(); // Create an instance of the Game class

  void _rollDice() {
    setState(() {
      _dice = List.generate(3, (_) => Random().nextInt(6) + 1);
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
                child: Image.asset('assets/dice$value.png', width: 50, height: 50),
              )).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _rollDice,
              child: const Text('Roll Dice'),
            ),
            const SizedBox(height: 20),
            Text(
              _game.determineOutcome(_dice), // Use the game logic to determine the outcome
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}

class Game {
  String determineOutcome(List<int> dice) {
    // Add your game logic here
    return 'Outcome';
  }
}

extension on Game {
  String determineOutcome(List<int> dice) {
    // Add your game logic here
    return 'Outcome';
  }
}