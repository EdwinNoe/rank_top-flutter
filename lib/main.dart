import 'dart:async';
import 'package:flutter/material.dart';
import './screens/backlog_screen.dart';
import './screens/fortunewheel_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// void main() => runApp(const RankTopApp());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const RankTopApp());
}

class RankTopApp extends StatelessWidget {
  const RankTopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RankTop(),
    );
  }
}

class RankTop extends StatefulWidget {
  const RankTop({super.key});

  @override
  State<RankTop> createState() => _RankTopState();
} 

class _RankTopState extends State<RankTop> {
  int currentPageIndex = 0;

  List<String> movieTitles = [];

  final TextEditingController _movieNameController = TextEditingController();

  late final List<Widget> pages = [
    const BacklogScreen(),
    const FortunewheelScreen(),
    const BacklogScreen(), 
  ];


  void _addMovie() {
    if (_movieNameController.text.isNotEmpty) {
      setState(() {
        movieTitles.add(_movieNameController.text);
      });
      _movieNameController.clear(); 
      Navigator.of(context).pop();
    }
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Movie'),
          content: Form(
            child: TextField(
              controller: _movieNameController, 
              decoration: const InputDecoration(hintText: 'Nombre de la película'),
              autofocus: true,
              keyboardType:TextInputType.text ,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              onPressed: _addMovie,
              child: const Text('Enviar'), 
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _movieNameController.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("RankTop Movies")),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.watch_later),
            label: 'Backlog',
          ),
          NavigationDestination(
            icon: Icon(Icons.play_circle_fill),
            label: 'Fortune Wheel',
          ),
          NavigationDestination(
            icon: Icon(Icons.star),
            label: 'Rank',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _dialogBuilder(context),
        child: const Icon(Icons.add),
      ),
      body: pages[currentPageIndex],
    );
  }
}