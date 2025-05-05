
import 'package:flutter/material.dart';
import 'dart:math'; // Import the dart:math library for Random
import '../modules/game.dart'; // Import the game class
import '../modules/app_data.dart'; // Import the AppData class
import '../screens/home_screen.dart'; // Import the HomeScreen class
class GameScreen extends StatefulWidget {
  final bool isPlayerBank; // Add a parameter to determine if the player is the bank
  const GameScreen({super.key, required this.isPlayerBank}); // Constructor to accept the parameter
  

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
  bool isHuman = false; // To determine if the player is human or not
  bool gameOver = false; // To determine if the game is over or not
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_)async {
      widget.isPlayerBank ? appData.setIsHumanBank(true) : appData.setIsHumanBank(false);
      await Future.delayed(const Duration(seconds: 3),(){
        startBankTurn();
      }); // Wait for 1 second
      //startBankTurn(); // Start the game by calling startBankTurn
    });
  }
  void startBankTurn() {
    gameOver = false; // Reset the gameOver variable
    isRolling = false;
    isBankTurn = true; // Set the isBankTurn variable to true
    
    setState(() {
       message = "Bank's turn";
    });
    if(appData.getIsHumanBank()) {
      print("human is bank");
      executePlayTurn();//call a method to player to display the dice

    }else{
      isHuman = false;
      print("human is not bank");
      playBank();//modify this to call playBank
    }
  }
  void startPlayerTurn() {
    isRolling = false;
    
    setState(() {
      message = "Player's turn";
    });
    isBankTurn = false; // Set the isBankTurn variable to false
    if(!appData.getIsHumanBank()) {
  
      //appData.setIsHumanBank(false);
      executePlayTurn();//call a method to player to display the dice

    }else{
      isHuman = false;
      playPlayer();//modify this to call playPlayer
    }
  }
  List<int> determineOutcome(List<int> dice) {
    dice = List.generate(3, (_) => Random().nextInt(6) + 1);
    return dice.map((die) => die * 2).toList(); // Replace with actual game logic
  }

  void playBank() async {
  isRolling = true;
  
  setState(() {
    bankDice = appData.rollDice();
 
    bankDice.sort();
 
    bankResult = appData.determineOutcome(bankDice); // Normalize the result
    //message = "";
  });
  
  bool rollAgain = false;
  
  print("Bank rolled: $bankResult");
  
  switch (bankResult) {
    case "Roll Again":
      setState(() {
        message = "Bank rolls again";
        
      });
      
      rollAgain = true;
      break;

    case "Trips":
    case "Bank Roll":
    case "Head Crack":
      print("Bank wins! $bankResult");
      setState(() {
        message = "Bank wins! $bankResult";
        // Set the isBankTurn variable to false
      });
      rollAgain = true;
      break;

    case "Acey":
    case "Loser":
      print("Player wins! $bankResult");
      setState(() {
        message = "Player wins! $bankResult";
        // Set the isBankTurn variable to false
      });
      rollAgain = true;
      break;

    default:
      print("Bank rolled: $bankResult, now it is the player's turn");
      setState(() {
        message = "Bank rolled: $bankResult, now it is the player's turn";
        // Set the isBankTurn variable to false
      });
      rollAgain = false;
      isBankTurn = false; // Set the isBankTurn variable to false
      break;
  }

  if (rollAgain) {
    setState(() {
      message = "Bank rolls again";
    });
    print("starting bank turn again");
    await Future.delayed(const Duration(seconds: 3),(){
      // Start the bank's turn again
      startBankTurn();
    }); 
    
  } else {
    setState(() {
      message = "Bank's turn is over";
    });
    print("Bank's turn is over");
    
    await Future.delayed(const Duration(seconds: 3),(){
      // Start the player's turn
      isRolling = false;
      startPlayerTurn();
    }); 
    
    }
  
    
  
  }
  void playPlayer()async{
    setState(() {
      appData.setIsRolling(true);
      playerDice = appData.rollDice();
      playerDice.sort();
      playerResult = appData.determineOutcome(playerDice);
    });
    
    String outcome = "";
    print("Player rolled: $playerDice -> $playerResult");
    bool rollAgain = false;
    // Determine the outcome of the player's roll
    switch (playerResult){
      case "Roll Again":
      setState(() {
        message = "Player rolls again";
      });
       
        print("Player rolled again");
        rollAgain = true;
        break;
      case "Trips":
      case "Bank Roll":
      case "Head Crack":
      setState(() {
         message = "Player Wins!";
      });
        //outcome = "Player Wins!";
        print("Player wins! $playerResult");
        //rollAgain = false;
        break;
      case "Acey":
      case "Loser":
      setState(() {
        message = "Bank Wins!";
      });
        
        print("Bank wins! $playerResult");
        //rollAgain = false;
        break;

      
      default:
        print("Compare player to bank");
        rollAgain = false;
        outcome = appData.comparePlayerToBank(bankResult, playerResult);
        setState(() {
          message = outcome;
        });
        if(bankResult == playerResult){
          setState(() {
            message = "Push!";
          });
        }
        startBankTurn();
        break;

    }
    if(rollAgain){
      await Future.delayed(const Duration(seconds: 3),(){
      // Start the bank's turn again
      startPlayerTurn();
    }); 
      
      }else{
        gameOver = true;
      //   if(outcome == "Player Wins!"){
      //     appData.setIsRolling(false);
      //     appData.setIsBankTurn(false);
      //     print("$appData.getPlayerName() beats the $appData.getBankName()! $appData.getPlayerName() wins!");
      //     }else if(outcome == "Bank Wins!"){
      //       appData.setIsRolling(false);
      //       appData.setIsBankTurn(true);
      //       print("$appData.getBankName() beats the $appData.getPlayerName()! $appData.getBankName() wins!");
      //     }
      //     isRolling = false;
      //     setState(() {
      //     isBankTurn = false; // Set the isBankTurn variable to false
      //     });
      //     await Future.delayed(const Duration(seconds: 15));
      //     // Start the next turn
      //     startBankTurn(); 
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
    //bankResult = appData.bank();
    isHuman = true;
    //playerResult = appData.nonBank(playerDice.join(','));
    setState(() {
      message = "Player pressed the button";
      
      
    });
    
    
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(70.0),
            child: Text(
              appData.getBankName(),
              style: TextStyle(
                fontSize: 22,
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
            style: TextStyle(fontSize: 22,
            color: isRolling ? Colors.green : Colors.black, 
            fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            onPressed: !isRolling && isHuman ? () {
              isRolling = true;
              if (isBankTurn) {
                // If it's the bank's turn, roll the dice for the bank
                
                  playBank();
                
              } else {
                // If it's the player's turn, roll the dice for the player
                
                  //appData.setIsRolling(true);
                  playPlayer();
               
              }
            }: null, // Disable the button if it's not the human's turn
            // Change the button color based on the isHumanBank variable
            style: ElevatedButton.styleFrom(
              backgroundColor: appData.getIsHumanBank() ? Colors.green : Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8), 
            ), // Disable the button if it's not the human's turn
            child: const Text('Roll Dice'),
          ),
          Text(
            "${widget.isPlayerBank ? "Player is the Bank" : "Computer is the Bank"}\n$message",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
      
          Row(
            
            mainAxisAlignment: MainAxisAlignment.center,
            children: playerDice
                .map((value) => DiceBox(value: value))
                .toList(),
          ),

            
          Text(
            "Player: ${playerDice.join(', ')}",
            // Display the player's dice
            style: TextStyle(fontSize: 22,
            color: isRolling ? Colors.black : Colors.green, 
            fontWeight: FontWeight.bold),
          ),
          Row(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                appData.getPlayerName(),
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: gameOver ? () {
                  startBankTurn();// put timer
                  
                }: null, // Disable the button if it's not the human's turn
                // Change the button color based on the isHumanBank variable
                style: ElevatedButton.styleFrom(
                  backgroundColor: appData.getIsHumanBank() ? Colors.green : Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0), 
                ), // Disable the button if it's not the human's turn
                child: const Text('Play Again'),
              ),
              const SizedBox(height: 70), // Add some space between the buttons
              ElevatedButton(
                onPressed: gameOver ? () {
                   Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen()),

                    );
                  //exit the game 
                  
                  
                }: null, // Disable the button if it's not the human's turn
                // Change the button color based on the isHumanBank variable
                style: ElevatedButton.styleFrom(
                  backgroundColor: appData.getIsHumanBank() ? Colors.red : Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0), 
                ), // Disable the button if it's not the human's turn
                child: const Text('Exit'),
              ),
              const SizedBox(width: 20), // Add some space between the buttons
            ],
          ),
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
      margin: const EdgeInsets.all(30.0),
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.black),
      ),
      child: Center(
        child: Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}        

