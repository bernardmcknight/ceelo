

class AppData {
  static final AppData _instance = AppData._internal();
  factory AppData() {
    return _instance;
  }
  AppData._internal();

  //Player Data
  String playerName = "Player";
  int playerBankAccount = 10000; //Initial bank account
  
  //Bank Data
  String bankName = "Bank";
  int bankBankAccount = 1000000; //Initial bank account

  //Current Bet
  int currentBet = 0;

  //Dice Keys
  int _dice1Key = 0;

  int _dice2Key = 0;

  int _dice3Key = 0;

  //Dice Vaules (Three Dice for Player and Bank)
  List<int> playerDiceRoll = [1, 1, 1];
  List<int> bankDiceRoll = [1, 1, 1];

  //Track turns (true  = bank, false = player)
  bool bankTurn = true;

  //setters and getters

  //Player Name
  void setPlayerName(String name) {
    playerName = name;
  }

  String getPlayerName() {
    return playerName;
  }

  //Player Bank Account
  void setPlayerBankAccount(int amount) {
    playerBankAccount = amount;
  }

  int getPlayerBankAccount() {
    return playerBankAccount;
  }

  //Bank Name
  void setBankName(String name) {
    bankName = name;
  }

  String getBankName() {
    return bankName;
  }

  //Bank Bank Account
  void setBankBankAccount(int amount) {
    bankBankAccount = amount;
  }

  int getBankBankAccount() {
    return bankBankAccount;
  }

  //Current Bet
  void setCurrentBet(int amount) {
    currentBet = amount;
  }

  int getCurrentBet() {
    return currentBet;
  }

  //Player Dice Roll
  void setPlayerDiceRoll(List<int> dice) {
    playerDiceRoll = dice;
  }

  List<int> getPlayerDiceRoll() {
    return playerDiceRoll;
  }

  //Bank Dice Roll
  void setBankDiceRoll(List<int> dice) {
    bankDiceRoll = dice;
  }

  List<int> getBankDiceRoll() {
    return bankDiceRoll;
  }

  //Player Turn
  void setBankTurn(bool turn) {
    bankTurn = turn;
  }

  bool getPlayerTurn() {
    return bankTurn;
  }

  //Reset Game
  void resetGame() {
    playerDiceRoll = [1, 1, 1];
    bankDiceRoll = [1, 1, 1];
    bankTurn = true;
    currentBet = 0;
  }

  int get dice1Key => _dice1Key;
  int get dice2Key => _dice2Key;
  int get dice3Key => _dice3Key;

  set dice1Key(int value) {
    _dice1Key = value;
  }

  set dice2Key(int value) {
    _dice2Key = value;
  }

  set dice3Key(int value) {
    _dice3Key = value;
  }
}
