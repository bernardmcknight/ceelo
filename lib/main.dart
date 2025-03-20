import 'package:cee_lo_big_bank_edition/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cee-Lo Big Bank Edition',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
class Bankroll {
  String possessBank() {
    return "You have \$1000 in your bank.";
  }
}

class BankRoll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Bankroll bankroll = Bankroll();


    return Scaffold(
      appBar: AppBar(
        title: Text('Bank Roll'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              bankroll.possessBank(),
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
  final bool isPlayerBank = false;
  final bool isBankTheBank = false;

  const BankRoll({super.key});

  get playerDie => null;

  get bankDie => null;

  void rollForBank() {}


}
// Removed duplicate app_data class