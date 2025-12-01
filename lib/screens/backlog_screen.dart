import 'package:flutter/material.dart';

class BacklogScreen extends StatefulWidget {
  const BacklogScreen({super.key});

  @override
  State<BacklogScreen> createState() => _BacklogScreenState();
}

class _BacklogScreenState extends State<BacklogScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Row(
            children: [
              Image.network(
                width: 150,
                height: 150,
                'https://media.istockphoto.com/id/1147544807/es/vector/no-imagen-en-miniatura-gr%C3%A1fico-vectorial.jpg?s=612x612&w=0&k=20&c=Bb7KlSXJXh3oSDlyFjIaCiB9llfXsgS7mHFZs6qUgVk=',
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 30),
                        Text(
                          style: TextStyle(height: 2, fontSize: 25),
                          'Elvis Presley el',
                        ),
                        IconButton(
                          onPressed: (() => {}),
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    ),
                    OutlinedButton(child: Text('Puntuar'), onPressed: () {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
