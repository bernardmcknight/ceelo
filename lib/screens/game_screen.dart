import 'package:flutter/material.dart';
import '../modules/game.dart'; // Import the game class
import '../modules/app_data.dart'; // Import the AppData class
import '../modules/dice_dancing.dart'; // Import the DiceDancing widget and its state class

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final GlobalKey<DiceDancingState> _dice1Key = GlobalKey();
  final GlobalKey<DiceDancingState> _dice2Key = GlobalKey();
  final GlobalKey<DiceDancingState> _dice3Key = GlobalKey();

  final GameState _gameState = GameState(); // Create an instance of the GameState class

  void _rollDice() {
    // Trigger the dice animations
    _dice1Key.currentState?.roll();
    _dice2Key.currentState?.roll();
    _dice3Key.currentState?.roll();

    // Update the dice values after the animation
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        List<int> diceValues = _gameState.rollDice();
        AppData().dice1Key = diceValues[0];
        AppData().dice2Key = diceValues[1];
        AppData().dice3Key = diceValues[2];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Are We Rolling?'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Display the dice animations
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DiceDancing(key: _dice1Key, onRollCompleted: (int ) {  },),
              const SizedBox(width: 16),
              DiceDancing(key: _dice2Key, onRollCompleted: (int ) {  },),
              const SizedBox(width: 16),
              DiceDancing(key: _dice3Key, onRollCompleted: (int ) {  },),
            ],
          ),
          const SizedBox(height: 32),

          // Roll Dice Button
          ElevatedButton(
            onPressed: _rollDice,
            child: const Text('Roll Dice'),
          ),

          const SizedBox(height: 32),

          // Display the dice results
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Dice Results: ${AppData().dice1Key}, ${AppData().dice2Key}, ${AppData().dice3Key}",
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
   
  }
}

