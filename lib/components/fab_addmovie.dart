import 'package:flutter/material.dart';
import 'package:rank_top/services/FirebaseService.dart';
import 'package:rank_top/services/model.dart';
import 'dart:async';


class FabAddmovie extends StatefulWidget {
  const FabAddmovie({super.key});

  @override
  State<FabAddmovie> createState() => _FabAddmovieState();
}

class _FabAddmovieState extends State<FabAddmovie> {
    final TextEditingController _movieNameController = TextEditingController();
    
  @override
  void dispose() {
    _movieNameController.dispose(); 
    super.dispose();
  }

  void _addMovie() {
    FirebaseService fireBase= new FirebaseService();
    Movie movie= new Movie();

    if (_movieNameController.text.isNotEmpty) {
      movie.setname(_movieNameController.text);
      fireBase.addMovie(movie);
      _movieNameController.clear(); 
      Navigator.of(context).pop();
      setState(() {
      });
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
              decoration: const InputDecoration(
                hintText: 'Nombre de la película',
              ),
              autofocus: true,
              keyboardType: TextInputType.text,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(onPressed: _addMovie, child: const Text('Enviar')),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: ()=> _dialogBuilder(context),
       child: const Icon(Icons.add),
    );
  }
}