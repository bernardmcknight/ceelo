import 'dart:math';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BankRoll extends StatefulWidget {
  BankRoll({super.key, required this.playerName, required this.bankName});

  final String playerName;
  final String bankName;
  bool isPlayerBank = false;
  int playerDie = 0; // To store the player's die roll
  int bankDie = 0; // To store the bank's die roll

  @override
  _BankRollState createState() => _BankRollState();
  Widget build(BuildContext context) {
    return Container();
  }

  void rollForBank() {
    final Random random = Random();
    playerDie = random.nextInt(6) + 1; // Roll a die for the player
    bankDie = random.nextInt(6) + 1; // Roll a die for the bank
    isPlayerBank = playerDie > bankDie; // Determine who is the bank
  }
  // Removed invalid return statement
}

class _BankRollState extends State<BankRoll> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

  @override
  Widget build(BuildContext context) {
    return Container();
  }
