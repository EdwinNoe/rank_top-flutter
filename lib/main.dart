import 'dart:async';
import 'package:flutter/material.dart';

import './screens/backlog_screen.dart';
import './screens/fortunewheel_screen.dart';

void main() => runApp(const RankTopApp());

class RankTopApp extends StatelessWidget {
  const RankTopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: RankTop());
  }
}

class RankTop extends StatefulWidget {
  const RankTop({super.key});

  @override
  State<RankTop> createState() => _RankTopState();
}

class _RankTopState extends State<RankTop> {
    int currentPageIndex = 0;
    
    late final List<Widget> pages = [
      const BacklogScreen(),
      const FortunewheelScreen(),
      const BacklogScreen(), 
    ];

    Future<void> _dialogBuilder(BuildContext context) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add Movie'),
            content: const Form(
              child: TextField(
                decoration: InputDecoration(hintText: 'Nombre de la pelicula '),
                autofocus: true,
              )
              ,
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
                child: const Text('Cerrar'), 
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
                child: const Text('Enviar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text("Crear un usestate para cambiar estado "),),
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
            selectedIcon: Icon(Icons.watch_later),
            icon: Icon(Icons.watch_later),
            label: 'Backlog',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.play_circle_fill),
            icon: Icon(Icons.play_circle_fill),
            label: 'Fortune Wheel',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.star),
            icon: Icon(Icons.star),
            label: 'Rank',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:  () => _dialogBuilder(context), 
        child: Icon(Icons.add),
      ) ,
      body: pages[currentPageIndex],
    );
  }
}