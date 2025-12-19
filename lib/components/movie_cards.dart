import 'package:flutter/material.dart';

class MovieCards extends StatefulWidget {
  const MovieCards({super.key});

  @override
  State<MovieCards> createState() => _MovieCardsState();
}

class _MovieCardsState extends State<MovieCards> {
  TextEditingController _movieNameController = TextEditingController();
  bool isEditing = true;

  @override
  void initState() {
    super.initState();
    _movieNameController = TextEditingController(text: 'Elvis Presley');
  }

  @override
  void dispose() {
    _movieNameController.dispose();
    super.dispose();
  }

  void _editMovieName() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Image.network(
            'https://media.istockphoto.com/id/1147544807/es/vector/no-imagen-en-miniatura-gr%C3%A1fico-vectorial.jpg?s=612x612&w=0&k=20&c=Bb7KlSXJXh3oSDlyFjIaCiB9llfXsgS7mHFZs6qUgVk=',
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Expanded(
                      child: !isEditing
                          ? Text(
                              textAlign:TextAlign.center,
                              _movieNameController.text,
                              style: const TextStyle(fontSize: 18),
                            )
                          : TextField( 
                              controller: _movieNameController,
                              autofocus: true,
                              decoration: const InputDecoration(
                                hintText: 'Nombre...',
                                isDense: true,
                              ),
                            ),
                    ),
                    IconButton(
                      onPressed: _editMovieName,
                      icon: Icon(isEditing ? Icons.check : Icons.edit),
                    ),
                  ],
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Puntuar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}