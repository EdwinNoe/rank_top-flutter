import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:rank_top/services/FirebaseService.dart';
import 'package:rank_top/services/model.dart';

class FortunewheelScreen extends StatefulWidget {
  const FortunewheelScreen({super.key});

  @override
  State<FortunewheelScreen> createState() => _FortunewheelScreenState();


}

class _FortunewheelScreenState extends State<FortunewheelScreen> {
  final controller = StreamController<int>.broadcast();
  FirebaseService firebaseService= new FirebaseService ();
  

  @override
  void dispose() {
    controller.close(); 
    super.dispose();
  }

  int duration=0;
  bool isSpinnin=false;
  
 @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Movie>>(
      stream: firebaseService.getMoviesStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Error al cargar datos"));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final movies = snapshot.data!;
          
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 300,
                child: FortuneWheel(
                  duration: Duration(seconds: duration),
                  selected: controller.stream,
                  items: [
                    for (var movie in movies)
                      if (movie.finished==false)
                        FortuneItem(child: Text(movie.name)),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (!isSpinnin) {
                    setState(() {
                      isSpinnin = true;
                      duration = 5;
                    });
                    final randomIndex = Fortune.randomInt(0, movies.length);
                    controller.add(randomIndex);
                    
                    Future.delayed(Duration(seconds: duration), () {
                      if (mounted) setState(() => isSpinnin = false);
                    });
                  }
                },
                child: const Text("Girar"),
              ),
            ],
          );
        }
        return const Center(child: Text("No hay películas disponibles"));
      },
    );
  }
}
