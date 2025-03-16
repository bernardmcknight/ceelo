import 'package:flutter/material.dart';
import '../modules/bank_roll.dart';

class BankRollScreen extends StatelessWidget {
  const BankRollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Roll'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _determineBank(context),
          child: const Text('Determine Bank'),
        ),
      ),
    );
  }

  void _determineBank(BuildContext context) {
    final Bankroll bankroll = Bankroll();
    String result = bankroll.possessBank();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Bank Roll Result'),
          content: Text(result),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Start Game'),
            ),
          ],
        );
      },

    );
}
}