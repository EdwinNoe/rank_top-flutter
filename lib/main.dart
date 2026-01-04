import 'package:flutter/material.dart';
import 'package:rank_top/components/fab_addmovie.dart';
import './screens/backlog_screen.dart';
import './screens/fortunewheel_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

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


  late final List<Widget> pages = [
    const BacklogScreen(),
    const FortunewheelScreen(),
    const BacklogScreen(), 
  ];


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
      floatingActionButton: FabAddmovie(),
      body: pages[currentPageIndex],
    );
  }
}