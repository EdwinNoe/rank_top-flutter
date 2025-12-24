import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rank_top/firebase_service/FirebaseService.dart';
import '../firebase_service/model.dart';

class MovieCards extends StatefulWidget {
  final Movie currentMovie; 

  const MovieCards({
    super.key,
    required this.currentMovie
  });
  

  @override
  State<MovieCards> createState() => _MovieCardsState();
}

class _MovieCardsState extends State<MovieCards> {
  TextEditingController _movieNameController = TextEditingController();

  static const List<String> list = <String>['1', '2', '3', '4', '5','6', '7', '8', '9', '10'];
  String dropdownValue = list.first;
  bool isEditing = false;

  FirebaseService fireBaseService= new FirebaseService();

  @override
  void initState() {
    super.initState();
    _movieNameController = TextEditingController(text: widget.currentMovie.name);
  }

  @override
  void dispose() {
    _movieNameController.dispose();
    super.dispose();
  }

  void _editMovieName() {
    widget.currentMovie.name=_movieNameController.text;
    fireBaseService.Update(widget.currentMovie);

    setState(() {
      isEditing = !isEditing;
    });
  }

  @override
  void didUpdateWidget(covariant MovieCards oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentMovie.name != widget.currentMovie.name) {
      _movieNameController.text = widget.currentMovie.name;
    }
  }

  
  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Score Movie'),
              content: DropdownButton<String>(
                value: dropdownValue,
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(),
                onChanged: (String? value) {
                  setDialogState(() {
                    dropdownValue = value!;
                  });
                  setState(() {}); 
                },
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cerrar'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  onPressed: () {
                    print("Puntaje enviado: $dropdownValue");
                    Navigator.of(context).pop();
                  }, 
                  child: const Text('Enviar')
                ),
              ],
            );
          },
        );
      },
    );
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
                              textAlign: TextAlign.center,
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
                  onPressed: () => _dialogBuilder(context),
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
