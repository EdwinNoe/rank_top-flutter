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
  void dispose() {
    controller.close(); 
    super.dispose();
  }

  int duration=0;
  bool isSpinnin=false;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 300,
          child: FortuneWheel(
            duration: Duration(seconds: duration),
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
            if (isSpinnin==false){
              setState(() {
                isSpinnin=true;
                duration = 5; 
              });
              WidgetsBinding.instance.addPostFrameCallback((_) {
                final randomIndex = Fortune.randomInt(0, 3);
                controller.add(randomIndex);
              });
            }
          },
          child: const Text("Girar"),
        ),
      ],
    );
  }
}
