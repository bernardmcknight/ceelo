import 'dart:math';
// import 'bank_roll_screen.dart'; // Import the BankRollScreen class

class Bankroll {
  //Bank Deterrminatiio Rolls
  String possessBank(){
     final Random random = Random();
     
     String playerName = 'Player';
     String bankName = 'Bank';
     // ignore: unused_local_variable
     bool isBankTheBank = false;
     bool isPlayerBank = false;

     int playerDie = random.nextInt(6) + 1;
     int bankDie = random.nextInt(6) + 1;

      if(playerDie > bankDie){
        isPlayerBank = true;
        return 'Player is the bank';
      }
      if(playerDie < bankDie){
        isBankTheBank = true;
        return 'Bank is the bank';
      }else{
        possessBank();
      }
      return 'Player: $playerName, Bank: $bankName';   



}
}