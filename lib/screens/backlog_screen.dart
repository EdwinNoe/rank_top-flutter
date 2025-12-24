import 'package:flutter/material.dart';
import 'package:rank_top/components/movie_cards.dart';
import 'package:rank_top/firebase_service/FirebaseService.dart';
import 'package:rank_top/firebase_service/model.dart';

class BacklogScreen extends StatefulWidget {
  const BacklogScreen({super.key});

  @override
  State<BacklogScreen> createState() => _BacklogScreenState();
}

class _BacklogScreenState extends State<BacklogScreen> {

  FirebaseService firebaseService= new FirebaseService ();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Movie>>(
      stream: firebaseService.getMoviesStream(), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No hay películas"));
        }

        List<Movie> movies = snapshot.data!;

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index) {
            return MovieCards(
              currentMovie: movies[index],
            );
          },
        );
      },
    );
  }
}
