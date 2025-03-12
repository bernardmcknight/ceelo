
import 'dart:math';

class AppData{
  static final AppData _instance = AppData._internal();
  factory AppData(){
    return _instance;
    }
    AppData._internal();
  }

  //Player Data
  String playerName = "Player";
  int playerBankAccount = 10000; //Initial bank account
  
  //Bank Data
  String bankName = "Bank";
  int bankBankAccount = 1000000; //Initial bank account

  //Current Bet
  int currentBet = 0;

  //Dice Vaules (Three Dice for Player and Bank)
  List<int> playerDiceRoll = [1, 1, 1];
  List<int> bankDiceRoll = [1, 1, 1];

  //Track turns (true  = bank, false = player)
  bool bankTurn = true;

  //setters and getters

  //Player Name
  void setPlayerName(String name){
    playerName = name;
  }
  String getPlayerName(){
    return playerName;
  }
  //Player Bank Account
  void setPlayerBankAccount(int amount){
    playerBankAccount = amount;
  }
  int getPlayerBankAccount(){
    return playerBankAccount;
  }
  //Bank Name
  void setBankName(String name){
    bankName = name;
  }
  String getBankName(){
    return bankName;
  }
  //Bank Bank Account
  void setBankBankAccount(int amount){
    bankBankAccount = amount;
  }
  int getBankBankAccount(){
    return bankBankAccount;
  }
  //Current Bet
  void setCurrentBet(int amount){
    currentBet = amount;
  }
  int getCurrentBet(){
    return currentBet;
  }
  //Player Dice Roll
  void setPlayerDiceRoll(List<int> dice){
    playerDiceRoll = dice;
  }
  List<int> getPlayerDiceRoll(){
    return playerDiceRoll;
  }
  //Bank Dice Roll
  void setBankDiceRoll(List<int> dice){
    bankDiceRoll = dice;
  }
  List<int> getBankDiceRoll(){
    return bankDiceRoll;
  }
  //Player Turn
  void setBankTurn(bool turn){
    bankTurn = turn;
  }
  bool getPlayerTurn(){
    return bankTurn;
  }
  //Reset Game
  void resetGame(){
    playerDiceRoll = [1, 1, 1];
    bankDiceRoll = [1, 1, 1];
    bankTurn = true;
    currentBet = 0;
  }
  //Bank Deterrminatiio Rolls
  void possessBank(){
     final Random _random = Random();
     
     String playerName = 'Player';
     String bankName = 'Bank';
     bool isPlayerBank = false;
     // ignore: unused_local_variable
     bool isBankTheBank = false;

     int playerDie = _random.nextInt(6) + 1;
     int bankDie = _random.nextInt(6) + 1;

      if(playerDie > bankDie){
        isPlayerBank = true;
      }else if(playerDie < bankDie){
        isBankTheBank = true;
      }else{
        possessBank();
      }
      if(isPlayerBank){
        bankName = playerName;
        playerName = bankName;
      }   



}