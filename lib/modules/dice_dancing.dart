import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class DiceDancing extends StatefulWidget {
  final int initialFace;
  final void Function(int)? onRollCompleted;

  const DiceDancing({
    Key? key,
    this.initialFace = 1,
    this.onRollCompleted,
  }) : super(key: key);

  @override
  DiceDancingState createState() => DiceDancingState();
}

class DiceDancingState extends State<DiceDancing> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounce;
  final Random _random = Random();
  Timer? _rollTimer;
  int diceFace = 1;

  @override
  void initState() {
    super.initState();
    diceFace = widget.initialFace;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _bounce = Tween<double>(begin: 0, end: -25).chain(CurveTween(curve: Curves.easeOut)).animate(_controller);
  }

  void roll() {
    setState(() {
      diceFace = _random.nextInt(6) + 1; // Generate a random dice face
      print("Dice face: New face: $diceFace");
    });

    _rollTimer?.cancel();
    int ticks = 0;

    _rollTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        diceFace = _random.nextInt(6) + 1; // Update dice face periodically
      });
      _controller.forward().then((_) => _controller.reverse());
      ticks++;
      if (ticks > 10) {
        timer.cancel();
        widget.onRollCompleted?.call(diceFace); // Call the callback if defined
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _rollTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _bounce,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _bounce.value),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Image.asset(
                'lib/assets/images/gold_die.png',
                errorBuilder: (context, error, stackTrace) {
                  return const Text(
                    'Image not found',
                    style: TextStyle(color: Colors.red),
                    // Debugging information can be logged elsewhere if needed
                  );
                  },
                width: 40,
                height: 40,
                fit: BoxFit.fill,
                key: ValueKey(diceFace
                ),
              ),
            )
          ),
        );
      },
    );
  }
}