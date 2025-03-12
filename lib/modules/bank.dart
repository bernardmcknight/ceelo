import 'player.dart';
import 'package:flutter/material.dart';

class Bank {
  String name;
  int bankAccount;
  IconData icon;

  Bank({required this.name, this.bankAccount = 10000, required this.icon});

  void addBankAccount(int amount) {
    bankAccount += amount;
  }
  void removeBankAccount(int amount) {
    bankAccount -= amount;
  }
  void resetScore() {
    bankAccount = 10000;
  }
  void changeIcon(IconData newIcon) {
    icon = newIcon;
  }
  void transferToPlayer(Player player){
    List<int> dice = [4, 5, 6]; // Example dice roll
    if(player.rollDice(dice.reduce((a, b) => a + b)) == 15) { // Example value, replace with the correct logic
      if ((dice[0] == 4 && dice[1] == 5 && dice[2] == 6) || 
          (dice[0] == 5 && dice[1] == 6 && dice[2] == 4) || 
          (dice[0] == 6 && dice[1] == 4 && dice[2] == 5)) {
        // Add your logic here
      }
    } else {
      //Bank.IconData = newIcon;
    }
  }
}