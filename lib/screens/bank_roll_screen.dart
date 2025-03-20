import 'package:flutter/material.dart';
import '../modules/bank_roll.dart';
import 'game_screen.dart'; // Import the updated BankRoll class

class BankRollScreen extends StatefulWidget {
  const BankRollScreen({super.key});

  @override
  _BankRollScreenState createState() => _BankRollScreenState();
}

class _BankRollScreenState extends State<BankRollScreen> {
  final BankRoll bankRoll = BankRoll(playerName: 'Player', bankName: 'Bank');
  String resultMessage = "Tap to roll the dice!";
  int playerDie = 0; // To store the player's die roll
  int bankDie = 0; // To store the bank's die roll

  void _rollForBank() {
    setState(() {
      bankRoll.rollForBank();
      playerDie = bankRoll.playerDie; // Get the player's die roll
      bankDie = bankRoll.bankDie; // Get the bank's die roll
      resultMessage = bankRoll.isPlayerBank
          ? "${bankRoll.playerName} is now the Bank"
          : "${bankRoll.bankName} is now the Bank";
    });
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(context,
      MaterialPageRoute(builder:(context)=> const GameScreen(),
      ),
      );
    }); // Add a delay before navigating to the next screen   
  }

  String getResult() {
    return "Result is ready"; // Ensure a valid String is returned
  }

  // Duplicate declaration removed

  void updateMessage() {
    resultMessage = "New message";
  }

  void displayMessage() {
    print(resultMessage); // Handle null case
  }

  String getBankResult() {
    return bankRoll.isPlayerBank ? "${bankRoll.playerName} is now the Bank" : "${bankRoll.bankName} is now the Bank";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Roll'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Player Die: $playerDie",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              "Bank Die: $bankDie",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(
              resultMessage,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _rollForBank,
              child: const Text('Roll for Bank'),
            ),
          ],
        ),
      ),
    );
  }
}

