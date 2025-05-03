import 'package:flutter/material.dart';
import 'dart:math';
import 'app_data.dart'; // Import the AppData class




class Game extends StatefulWidget {
  const Game({super.key});

  @override
  GameState createState() => GameState();
}

class GameState extends State<Game> {
  final AppData appData = AppData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Reset the game state here
              setState(() {
                // Reset any game-related variables if needed
              });
            },
          ),
        ],
      ),
      body: Center(
        child: const Text(''),
      ),
    );
  }

  List<int> rollDice() {
    final Random random = Random();
    return <int>[random.nextInt(6) + 1, random.nextInt(6) + 1, random.nextInt(6) + 1];
  }
  bool isRolling = false;

  String bank() {
    String result;
    List<int> roll;
    int maxRetries = 10;
    int retries = 0;

    do{
      roll = appData.rollDice();
      result = determineOutcome(roll);
      AppData().setBankDiceRoll(roll);
      print("Bank rolled: $roll -> $result");
      if(["Trips", "Bank Roll", "Head Crack"].contains(result)) return result;
      if(["Acey", "Loser"].contains(result)) return result;

      retries++;
      if(retries >= maxRetries){
        print("Max retries reached. Ending turn.");
        break;
      }
    }while(result == "Roll Again");
    return result;
  }

  
  String nonBank() {
    String playerResult;
    List<int> roll;

    int maxRetries = 10;
    int retries = 0;
    print('is it time for me!');
    

    do{
      roll = appData.rollDice(); // Accessing the class-level appData variable
      print("what is this");
      playerResult = determineOutcome(roll);
      appData.setPlayerDiceRoll(roll); // Use the existing appData instance
      print("Player rolled: $roll -> $playerResult");
      if(["Trips", "Bank Roll", "Head Crack"].contains(playerResult)) return playerResult;
      if(["Acey", "Loser"].contains(playerResult)) return playerResult;

      retries++;
      if(retries >= maxRetries){
        print("Max retries reached. Ending turn.");
        break;
      }
    }while(playerResult == "Roll Again");
    return playerResult;

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
      return "Head Crack";
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
  String comparePlayerToBank(String bankResult, String playerResult){
    if(bankResult.startsWith("Point") && playerResult.startsWith("Point")){
      int bankPoint = int.parse(bankResult.split("")[1]);
      int playerPoint = int.parse(playerResult.split("")[1]);
      if(playerPoint > bankPoint) return "Player Wins!";
      if(playerPoint < bankPoint) return "Bank Wins!";
      return "Push!";
    }
    return "Unknown Outcome"; // Ensure a String is always returned
  }

      List<String> localOutcomePriority = ["Trips", "Bank Roll", "Head Crack", "Fever","Box","Tracy","Deuce","Acey", "Loser", "Roll Again"];
      int rank(String result){
        return localOutcomePriority.indexOf(result);
      }



}