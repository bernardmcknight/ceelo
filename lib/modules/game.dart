import 'package:flutter/material.dart';
import 'dart:math';

class Game extends StatefulWidget {
  @override
  GameState createState() => GameState();
}


class GameState extends State<Game> {
  List<int> _dice = [1, 1, 1];
  final _random = Random();
  List<int> rollDice() {
    return [_random.nextInt(6) + 1, _random.nextInt(6) + 1, _random.nextInt(6) + 1];
  }

  String determineOutcome(List<int> dice) {
    dice.sort();
    if (dice[0] == dice[1] && dice[1] == dice[2]) {
      return "Trips";
    }
    if ((dice[0] == 4 && dice[1] == 5 && dice[2] == 6) || (dice[0] == 5 && dice[1] == 4 && dice[2] == 6) || (dice[0] == 6 && dice[1] == 4 && dice[2] == 5)) {
      return "Bank Roll";
    }
    if ((dice[0] == dice[1] && dice[2] == 6) || (dice[0] == dice[2] && dice[1] == 6) || (dice[1] == dice[2] && dice[0] == 6)) {
      return "Head Cracks";
    }
    if((dice[0] == dice[1] && dice[2] == 5) || (dice[0] == dice[2] && dice[1] == 5) || (dice[1] == dice[2] && dice[0] == 5)) {
      return "Fever";
    }
    if((dice[0] == dice[1] && dice[2] == 4) || (dice[0] == dice[2] && dice[1] == 4) || (dice[1] == dice[2] && dice[0] == 4)) {
      return "Box";
    }
    if((dice[0] == dice[1] && dice[2] == 3) || (dice[0] == dice[2] && dice[1] == 3) || (dice[1] == dice[2] && dice[0] == 3)) {
      return "Tracy";
    }
    if((dice[0] == dice[1] && dice[2] == 2) || (dice[0] == dice[2] && dice[1] == 2) || (dice[1] == dice[2] && dice[0] == 2)) {
      return "Deuce";
    }
    if((dice[0] == dice[1] && dice[2] == 1) || (dice[0] == dice[2] && dice[1] == 1) || (dice[1] == dice[2] && dice[0] == 1)) {
      return "Acey";
    }
    if ((dice[0] == 1 && dice[1] == 2 && dice[2] == 3) || (dice[0] == 1 && dice[1] == 3 && dice[2] == 2) || (dice[0] == 2 && dice[1] == 1 && dice[2] == 3) || (dice[0] == 2 && dice[1] == 3 && dice[2] == 1) || (dice[0] == 3 && dice[1] == 1 && dice[2] == 2) || (dice[0] == 3 && dice[1] == 2 && dice[2] == 1)) {
      return "Loser";
    }
    return 'Outcome based on dice: ${dice.join(', ')}';
  }

  void _rollDice() {
    setState(() {
      _dice = rollDice();
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
            Text(
              'Dice: ${_dice.join(', ')}',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text(
              ' ${determineOutcome(_dice)}',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _rollDice,
              child: const Text('Roll Dice'),
            ),
          ],
        ),
      ),
    );
  }
}