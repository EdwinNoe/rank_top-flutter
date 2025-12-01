import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class FortunewheelScreen extends StatefulWidget {
  const FortunewheelScreen({super.key});

  @override
  State<FortunewheelScreen> createState() => _FortunewheelScreenState();
}

class _FortunewheelScreenState extends State<FortunewheelScreen> {
  final controller = StreamController<int>.broadcast();
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 300,
          child: FortuneWheel(
            duration: Duration(seconds: 10),
            selected: controller.stream,
            items: const [
              FortuneItem(child: Text('Han Solo')),
              FortuneItem(child: Text('Yoda')),
              FortuneItem(child: Text('Obi-Wan Kenobi')),
            ],
          ),
        ),

        const SizedBox(height: 30),

        ElevatedButton(
          onPressed: () {
            final randomIndex = Fortune.randomInt(0, 3);
            controller.add(randomIndex);
          },
          child: const Text("Girar"),
        ),
      ],
    );
  }
}
