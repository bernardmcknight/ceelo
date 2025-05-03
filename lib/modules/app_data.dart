import 'dart:math';


class AppData {
  // Singleton Implementation
  static final AppData _instance = AppData._internal();
  factory AppData() => _instance;
  AppData._internal();

  // Constants
  static const int initialPlayerBankAccount = 10000;
  static const int initialBankBankAccount = 1000000;

  // Player Data
  String playerName = "Player";
  int playerBankAccount = initialPlayerBankAccount;
  String getPlayerName() {
    return playerName;
  }
  String getBankName() {
    return bankName;
  } 
  void setPlayerName(String name) {
    playerName = name;
  }
  void setBankName(String name) {
    bankName = name;
  }
  void setPlayerBankAccount(int amount) {
    playerBankAccount = amount;
  }
  int getPlayerBankAccount() {
    return playerBankAccount;
  }
  void setBankBankAccount(int amount) {
    bankBankAccount = amount;
  }
  int getBankBankAccount() {
    return bankBankAccount;
  }
  bool isHumanBank = false;
  void setIsHumanBank(bool value) {
    isHumanBank = value;
  }
  bool getIsHumanBank() {
    return isHumanBank;
  }
  

  // Bank Data
  String bankName = "Bank";
  int bankBankAccount = initialBankBankAccount;

  // Current Bet
  int currentBet = 0;
  
  void increaseBet(int amount) {
    if(currentBet + 100 <= playerBankAccount){
      currentBet += 100;
    }
  }
  void decreaseBet(int amount) {
    if(currentBet - 100 >= 0){
      currentBet -= 100;
    }
  }
  void playerWinsBet(){
    playerBankAccount += currentBet;
    bankBankAccount -= currentBet;
    currentBet = 0;

  }
  void bankWinsBet(){
    playerBankAccount -= currentBet;
    bankBankAccount += currentBet;
    currentBet = 0;
  }
  int getCurrentBet() => currentBet;
  void resetBet() => currentBet = 0;

  // Dice Rolls
  List<int> _playerDiceRoll = [1, 1, 1];
  List<int> _bankDiceRoll = [1, 1, 1];

  // Getter and Setter for Player Dice Roll
  void setBankDiceRoll(List<int> roll) => _bankDiceRoll = roll;
  List<int> getBankDiceRoll() => _bankDiceRoll;

  void setPlayerDiceRoll(List<int> roll) => _playerDiceRoll = roll;
  List<int> getPlayerDiceRoll() => _playerDiceRoll;
  bool isRolling = false;

  bool getIsRolling() {
    return isRolling;
  }

  void setIsRolling(bool value) {
    isRolling = value;
  }

  // Bank Turn
  bool isBankTurn = true;

  void setIsBankTurn(bool value) {
    isBankTurn = value;
  
  }

  bool getIsBankTurn() {
    return isBankTurn;
  }

  // Reset Game State
  void resetGame() {
    playerBankAccount = initialPlayerBankAccount;
    bankBankAccount = initialBankBankAccount;
    currentBet = 0;
    _playerDiceRoll = [1, 1, 1];
    _bankDiceRoll = [1, 1, 1];
  }

  // Utility Method to Roll Dice
  List<int> rollDice() {
    isRolling = true;
    final random = Random();
    return [
      random.nextInt(6) + 1,
      random.nextInt(6) + 1,
      random.nextInt(6) + 1,
    ];
  }

  // Determine Outcome
  String determineOutcome(List<int> dice) {
    dice.sort(); // Sort the dice

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
  
   int rank(String result){
      List<String> priority = ["Trips", "Bank Roll", "Head Crack",
       "Fever", "Box", "Tracy", "Deuce", "Acey", "Loser"];
      return priority.indexOf(result);
    }
   // Compare Player to Bank Method
    String comparePlayerToBank(String bankResult, String playerResult) {
      return "Unknown Outcome"; // Ensure a String is always returned
    }

  // Bank Method
   //String bank() {
  //   List<int> bankRoll = rollDice();
  //   bankRoll.sort();
  //   _bankDiceRoll = bankRoll;

  //   String result = determineOutcome(bankRoll);
  //   print("Bank rolled: $bankRoll -> $result");

  //   if (["Trips", "Bank Roll", "Head Crack"].contains(result)) {
  //     print("Bank wins!");
  //     AppData().isBankTurn = true;
  //   } else if (["Acey", "Loser"].contains(result)) {
  //     print("Player wins!");
  //     setIsBankTurn(false);//add an another else statement for player turn
  //   } 
  //   while(result == "Roll Again");// move this to the top of the method
  //   print('Bank rolled $result, now it is the player turn');
  //   return result;
  // }
  
    // Play Turn Method
  // void playTurn() {
  //   final appData = AppData();
  //   String bankResult = '';
  //   String playerResult = '';
  //   appData.bank();

  //   do{
  //     bankResult = appData.bank();
  //     if(["Trips", "Bank Roll", "Head Crack"].contains(bankResult)){
  //       print("Bank wins!");
  //       return;
  //     }else if(["Acey", "Loser"].contains(bankResult)){
  //       print("Player wins!");
  //       return;
  //     }
  //   }while(bankResult == "Roll Again");

  //   appData.setIsBankTurn(false);

  //   //Player's turn
  //   do{
  //     playerResult = nonBank(bankResult);
  //     if(["Trips","Bank Roll","Head Crack"].contains(playerResult)){
  //       print("Player wins with $playerResult!");
  //       return;
  //     }else if(["Acey","Loser"].contains(playerResult)){
  //       print(" $AppData.getPlayerName() loses with $playerResult!");
  //       return;
  //     }
  //     final outcome = comparePlayerToBank(bankResult, playerResult);
  //     if(outcome == "Player Wins!"){
  //       print("$AppData.getPlayerName() beats the $AppData.getBankName()! $AppData.getPlayerName() wins!");
  //       return;
  //     }else if(outcome == "Bank Wins!"){
  //       print("$AppData.getBankName() beats the $AppData.getPlayerName()! $AppData.getBankName() wins!");
  //       return;
  //     }else if(outcome == "Push!"){
  //       print("Push! $AppData.getBankName() it's your turn!");
  //       AppData().setIsBankTurn(true);
  //       Future.delayed(const Duration(milliseconds: 600), () {
  //         playTurn();
  //       });
  //       return;
  //   }
  //   }while(playerResult == "Roll Again");
   //}

  // Non-Bank Method
//   String nonBank(String bankResult) {
//     List<int> playerRoll = [1, 1, 1]; // Initialize with default dice roll
//     playerRoll = AppData().rollDice();
//     print("is it time for me!");
//     String playerResult = AppData().determineOutcome(playerRoll);

//     int maxRetries = 10;
//     int retries = 0;
    
//     do {
//       playerRoll = AppData().rollDice();
//       playerRoll.sort();
//       playerResult = AppData().determineOutcome(playerRoll);
//       print("Player rolled: $playerRoll -> $playerResult");
    
//     if(["Bank Roll"].contains(playerResult)){
//       print("Player takes bank!");
//       AppData().setIsBankTurn(true);
//       return playerResult;
//     }else if(["Trips", "Head Crack"].contains(playerResult)){
//       print("Player Wins!");
//       return playerResult;
//     }
//     retries++;
//     if(retries >= maxRetries){
//       print("Max retries reached, rolling again.");
//       break;
//     }
//     } while (playerResult == "Roll Again");

      

//     int rank(String result){
//       List<String> priority = ["Trips", "Bank Roll", "Head Crack",
//        "Fever", "Box", "Tracy", "Deuce", "Acey", "Loser"];
//       return priority.indexOf(result);
//     }

//     int playerRank = rank(playerResult);
//     int bankRank = rank(bankResult);

//     if(playerResult.startsWith("Point") && bankResult.startsWith("Point")){
//       int playerPoint = int.parse(playerResult.split(" ")[1]);
//       int bankPoint = int.parse(bankResult.split(" ")[1]);

//       if(playerPoint > bankPoint){
//         print("Player beats the $AppData.getBankName()! $AppData.getPlayerName() wins!");
//         return "Player Wins!";
//       }else if (playerPoint == bankPoint){
//         print("Push! $AppData.getBankName() it's your turn!");
//         AppData().setIsBankTurn(true);
//         return "Push!";
//       }else{
//         print("$AppData.getBankName() beats the $AppData.getPlayerName()! $AppData.getBankName() wins!");
//         AppData().setIsBankTurn(true);
//         return "Bank Wins!";
//       }
//     }
//     if(playerRank > bankRank){
//       print("$AppData.getPlayerName() beats the $AppData.getBankName()! $AppData.getPlayerName() wins!");
//       return "Player Wins!";
//     }else if(playerRank == bankRank){
//       print("Push! $AppData.getBankName() it's your turn!");
//       AppData().setIsBankTurn(true);
//       return "Push!";
//     }else{
//       print("$AppData.getBankName() beats the $AppData.getPlayerName()! $AppData.getBankName() wins!");
//       AppData().setIsBankTurn(true);
//       return "Bank Wins!";
//     }
// // Default return statement
//   }

  getPlayerResult() {}
  
  void setPlayerResult(String result) {
    // Set player result
  }
  getBankResult() {}
  void setBankResult(String result) {}
}