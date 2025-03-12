


class Player{
  String name;
  int bankAccount;

  Player({required this.name, this.bankAccount = 5000});

  void addBankAccount(int amount){
    bankAccount += amount;
  }
  void removeBankAccount(int amount){
    bankAccount -= amount;
  }
  void resetScore(){
    bankAccount = 5000;
  }
  int rollDice(int rollDice){
    return rollDice;
  }
  void transferToPlayer(Player player){
    List<int> dice = [rollDice(0), rollDice(0), rollDice(0)]; // Define dice
    int diceRoll = rollDice(0); // Define diceRoll
    if(player.rollDice(0) == diceRoll){
      if ((dice[0] == 4 && dice[1] == 5 && dice[2] == 6) || 
          (dice[0] == 5 && dice[1] == 6 && dice[2] == 4) || 
          (dice[0] == 6 && dice[1] == 4 && dice[2] == 5)) {
        // Add your logic here
      }
    }
    else{
      //Bank.IconData = newIcon;
    }
  }
}