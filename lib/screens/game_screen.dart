
import 'package:flutter/material.dart';
import 'dart:math'; // Import the dart:math library for Random
import '../modules/game.dart'; // Import the game class
import '../modules/app_data.dart'; // Import the AppData class
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  final AppData appData = AppData(); // Create an instance of the AppData class
  final GameState gameState = GameState(); // Create an instance of the GameState class
  bool isRolling = true; // Define the isRolling variable as a member of the class
  bool isHumanBank = false; // Define the isHumanBank variable as a member of the class
  bool isBankTurn = false; // Define the isBankTurn variable as a member of the class
  List<int> bankDice = [1, 1, 1]; // Initialize the dice list with default values, accessible throughout the class
  List<int> playerDice = [1, 1, 1]; // Initialize the dice list with default values, accessible throughout the class
  String playerResult = ''; // To store the player's result
  String bankResult = ''; // To store the bank's result
  String message = ""; // To store the message to be displayed
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_)async {
      appData.setIsHumanBank(false);
      await Future.delayed(const Duration(seconds: 1)); // Wait for 1 second
      startBankTurn(); // Start the game by calling startBankTurn
    });
  }
  void startBankTurn() {
    //final appData = AppData();
    isBankTurn = true; // Set the isBankTurn variable to true
    message = "Bank's turn";
    setState(() {
    });
    if(appData.getIsHumanBank()) {
      print("human is bank");
      executePlayTurn();//call a method to player to display the dice

    }else{
      print("human is not bank");
      playBank();//modify this to call playBank
    }
  }
  void startPlayerTurn() {
    message = "Player's turn";
    setState(() {
    });
    isBankTurn = false; // Set the isBankTurn variable to false
    if(!appData.getIsHumanBank()) {
  
      //appData.setIsHumanBank(false);
      executePlayTurn();//call a method to player to display the dice

    }else{
      playPlayer();//modify this to call playPlayer
    }
  }
  List<int> determineOutcome(List<int> dice) {
    dice = List.generate(3, (_) => Random().nextInt(6) + 1);
    return dice.map((die) => die * 2).toList(); // Replace with actual game logic
  }

  void playBank() {
  appData.setIsRolling(true);
  setState(() {
    bankDice = appData.rollDice();
    bankDice.sort();
    bankResult = appData.determineOutcome(bankDice);
  });
  //bankDice = appData.rollDice();
  //bankDice.sort();
  //bankResult = appData.determineOutcome(bankDice); // Normalize the result
  print("Bank rolled: $bankDice -> $bankResult");
  bool rollAgain = false;
  return;
  switch (bankResult) {
    case "roll again":
      message = "Bank rolled again";
      //Future.delayed(const Duration(seconds: 3), () {
        
      //});
      rollAgain = true;
      break;

    case "trips":
    case "bank roll":
    case "head crack":
      print("Bank wins! $bankResult");
      //rollAgain = true;
      break;

    case "acey":
    case "loser":
      print("Player wins! $bankResult");
      //rollAgain = true;
      break;

    default:
      print("Bank rolled: $bankResult, now it is the player's turn");
      rollAgain = false;
      break;
  }

  if (rollAgain) {
    startBankTurn();
  } else {
    isRolling = false;
    setState(() {
      isBankTurn = false; // Set the isBankTurn variable to false
    });
    startPlayerTurn();
  }
  return;
  }
  void playPlayer(){
    appData.setIsRolling(true);
    playerDice = appData.rollDice();
    playerDice.sort();
    playerResult = appData.determineOutcome(playerDice);
    String outcome = "";
    print("Player rolled: $playerDice -> $playerResult");
    bool rollAgain = false;
    // Determine the outcome of the player's roll
    switch (playerResult){
      case "Roll Again":
        print("Player rolled again");
        rollAgain = true;
        break;
      case "Trips":
      case "Bank Roll":
      case "Head Crack":
        outcome = "Player Wins!";
        print("Player wins! $playerResult");
        rollAgain = false;
        break;
      case "Acey":
      case "Loser":
        outcome = "Bank Wins!";
        print("Bank wins! $playerResult");
        rollAgain = false;
        break;
      default:
        print("Compare player to bank");
        rollAgain = false;
        outcome = AppData().comparePlayerToBank(bankResult, playerResult);
        break;

    }
    if(rollAgain){
      startPlayerTurn();
      }else{
        if(outcome == "Player Wins!"){
          appData.setIsRolling(false);
          appData.setIsBankTurn(false);
          print("$AppData().getPlayerName() beats the $AppData().getBankName()! $AppData.getPlayerName() wins!");
          }else if(outcome == "Bank Wins!"){
            appData.setIsRolling(false);
            appData.setIsBankTurn(true);
            print("$AppData().getBankName() beats the $AppData().getPlayerName()! $AppData().getBankName() wins!");
          }
      }
    
    
            
        
        
       
        
        
        // Check if the game is over
      //  if (appData.getPlayerBankAccount() <= 0) {
      //     print("Game Over! Player has no money left.");
      //     // Show game over dialog or navigate to game over screen
      //   } else if (appData.getBankBankAccount() <= 0) {
      //     print("Game Over! Bank has no money left.");
      //     // Show game over dialog or navigate to game over screen
      //   }
        // Update the UI to reflect the outcome
        
  isRolling = false;
    setState(() {
      isBankTurn = true; // Set the isBankTurn variable to false
    });
    // Start the next turn
    startBankTurn();     

  }
  // Function to handle the player's turn
  void handlePlayerTurn() {
    appData.setIsRolling(true);
    if (appData.getIsBankTurn()) {
      playBank();
    } else {
      playPlayer();
    }
    return;
  }

  
  void executePlayTurn() {
    bankResult = appData.bank();
    
    playerResult = appData.nonBank(playerDice.join(','));
    
    
  }

  
  
   @override
   
  Widget build(BuildContext context) {
    //final appData = AppData();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              appData.getBankName(),
              style: TextStyle(
                fontSize: 24,
                color: appData.getIsRolling() ? Colors.green : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: bankDice
                .map((value) => DiceBox(value: value))
                .toList(),
          ),


            
          Text(
            "The Bank: ${bankDice.join(', ')}",
            style: TextStyle(fontSize: 24,
            color: appData.getIsRolling() ? Colors.green : Colors.black, 
            fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            onPressed: isRolling || isHumanBank ? () {
              if (appData.getIsBankTurn()) {
                // If it's the bank's turn, roll the dice for the bank
                setState(() {
                  playBank();
                });
              } else {
                // If it's the player's turn, roll the dice for the player
                setState(() {
                  appData.setIsRolling(true);
                  playPlayer();
                });
              }
            }: null, // Disable the button if it's not the human's turn
            // Change the button color based on the isHumanBank variable
            style: ElevatedButton.styleFrom(
              backgroundColor: AppData().getIsHumanBank() ? Colors.red : Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16), 
            ), // Disable the button if it's not the human's turn
            child: const Text('Roll Dice'),
          ),
          Text(
            message,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
      
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: playerDice
                .map((value) => DiceBox(value: value))
                .toList(),
          ),

            
          Text(
            "${AppData().getPlayerName()}: ${playerDice.join(', ')}",
            // Display the player's dice
            style: TextStyle(fontSize: 24,
            color: AppData().getIsRolling() ? Colors.black : Colors.green, 
            fontWeight: FontWeight.bold),
          ),
          Text(
            "outcome: $bankResult, $playerResult",
            // Display the outcome of the game
            style: const TextStyle(fontSize: 24, color: Colors.red),
            textAlign: TextAlign.center,
          ),
          
          // Display the result of the game
          // Debugging information should not be inside the widget tree
          
            

          // Display the result of the game
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}  // Removed duplicate build method
        
  // Reusable dice display widget
class DiceBox extends StatelessWidget {
  final int value;

  const DiceBox({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.black),
      ),
      child: Center(
        child: Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}        

