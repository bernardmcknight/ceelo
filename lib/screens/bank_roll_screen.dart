import 'dart:async';
import 'dart:math';
import 'package:cee_lo_big_bank_edition/screens/game_screen.dart';
import 'package:flutter/material.dart';
import '../modules/bank_roll.dart';

class BankRollScreen extends StatefulWidget {
  const BankRollScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BankRollScreenState createState() => _BankRollScreenState();
}

class _BankRollScreenState extends State<BankRollScreen> {
  final BankRoll bankRoll = BankRoll(playerName: 'Player', bankName: 'Bank');
  String resultMessage = "Tap to roll the dice!";
  bool rolling = false;
  bool isPlayerRolling = true;
  int playerDie = 0; // To store the player's die roll
  int bankDie = 0; // To store the bank's die roll

  void _rollForBank() {
    setState(() {
      bankRoll.rollForBank();
      playerDie = bankRoll.playerDie;
      bankDie = bankRoll.bankDie;
      rolling = true;
      resultMessage = bankRoll.isPlayerBank ? "${bankRoll.playerName} is now the Bank" : "${bankRoll.bankName} is now the Bank";
    });

    Timer(const Duration(seconds: 2), () {
      setState(() {
        bankRoll.playerDie = (Random().nextInt(6) + 1); // Roll a random die for the player
        isPlayerRolling = false;
      });
    });

    Timer(const Duration(seconds: 4), () {
      if (!mounted) return; // Ensure the widget is still mounted
      setState(() {
        bankRoll.bankDie = (Random().nextInt(6) + 1); // Roll a random die for the bank
        rolling = false;
        resultMessage = bankRoll.isPlayerBank ? "${bankRoll.playerName} is the Bank" : "${bankRoll.bankName} is the Bank";
      });

      Future.delayed(const Duration(seconds: 2), () {
        // ignore: use_build_context_synchronously
        Navigator.push(context,
        MaterialPageRoute(builder:(context) =>  GameScreen(isPlayerBank: bankRoll.isPlayerBank)),
        );
          
      });
    });
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    "Player Rolls",
                    style: TextStyle(
                      fontSize: 18,
                      color: isPlayerRolling ? Colors.green : Colors.black,
                      fontWeight: isPlayerRolling ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "$playerDie",
                    style: const TextStyle(fontSize: 48, color: Colors.blue),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Bank Rolls",
                      style: TextStyle(
                      fontSize: 18,
                      color: isPlayerRolling ? Colors.black : Colors.green,
                      fontWeight: isPlayerRolling ? FontWeight.normal : FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "$bankDie",
                    style: const TextStyle(fontSize: 48, color: Colors.blue),
                  ),
                ],
              ),
            ],
          ),
           const SizedBox(height: 40),
           ElevatedButton(
             onPressed: rolling ? null : _rollForBank,
             child: const Text('Roll for Bank'),
           ),
           const SizedBox(height: 30),
           Text(
             resultMessage,
             style: const TextStyle(fontSize: 24, color: Colors.red),
             textAlign: TextAlign.center,
           ),
          ],
        ),
      ),
    );
  }
}