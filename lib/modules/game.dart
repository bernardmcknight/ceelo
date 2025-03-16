import 'package:flutter/material.dart';
import 'dart:math';


class Game extends StatefulWidget {
  const Game({super.key});

  @override
  GameState createState() => GameState();
}


class GameState extends State<Game> {
  final Random _random = Random();
  List<int> _dice = [1, 1, 1];
  List<int> rollDice() {
    return <int>[_random.nextInt(6) + 1, _random.nextInt(6) + 1, _random.nextInt(6) + 1];
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
    if ((dice[0] == 1 && dice[1] == 2 && dice[2] == 3) || (dice[0] == 1 && dice[1] == 3 && dice[2] == 2) || (dice[0] == 2 && dice[1] == 1 && dice[2] == 3) ) {
      return "Loser";
    } else {
      return "Roll Again";
    }
  }


  void _rollDice() {
    setState(() {
      _dice = rollDice();
    });
  }

  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Cee-Lo Big Bank Edition'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            ElevatedButton(
              onPressed: _rollDice,
              child: Text('Roll Dice'),
            ),
            Text(
              "Dice: ${_dice.join(', ')}",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              determineOutcome(_dice),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}