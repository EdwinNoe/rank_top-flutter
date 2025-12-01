import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';


void main() => runApp(const NavigationBarApp());

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NavigationExample());
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;
  // controlador de fortune wheel 
  final controller = StreamController<int>.broadcast();


    @override
    void dispose() {
      controller.close();
      super.dispose();
    }
    
    // funcion para el dialog
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


      // Pages on screen 
      body: <Widget>[
        //Backlog page 
        Column(
          children: [
             Card(
              child: Row(
                children: [
                  Image.network(
                    width: 150,
                    height: 150,
                    'https://media.istockphoto.com/id/1147544807/es/vector/no-imagen-en-miniatura-gr%C3%A1fico-vectorial.jpg?s=612x612&w=0&k=20&c=Bb7KlSXJXh3oSDlyFjIaCiB9llfXsgS7mHFZs6qUgVk='
                  ),
                  Expanded(                
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,   
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              style: TextStyle(height: 2, fontSize: 25),
                              'Elvis Presley el'
                            ),
                            IconButton(onPressed: (()=>{}), icon:const Icon(Icons.edit)),
                          ],
                        ),
                        OutlinedButton(child: Text('Puntuar'),onPressed: (){}),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        
        
        /// Fortune Page 

        Column(
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
            )
          ],
        ),
        

        /// Messages page
        ListView.builder(
          reverse: true,
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Hello',
                    style: theme.textTheme.bodyLarge!.copyWith(color: theme.colorScheme.onPrimary),
                  ),
                ),
              );
            }
            return Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Hi!',
                  style: theme.textTheme.bodyLarge!.copyWith(color: theme.colorScheme.onPrimary),
                ),
              ),
            );
          },
        ),
      ][currentPageIndex],
    );
  }
}