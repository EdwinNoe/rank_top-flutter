import 'package:cloud_firestore/cloud_firestore.dart';
import './model.dart'; 

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addMovie(Movie movie) async {
    try {
      await _db.collection("movies").add(movie.toMap()).then((documentSnapshot) =>
      print("Added Data with ID: ${documentSnapshot.id}"));;
    } catch (e) {
      print("Error al guardar: $e");
    }
  }


  Stream<List<Movie>> getMoviesStream() {
    return _db.collection('movies').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Movie.fromMap(doc.data() as Map<String, dynamic>,doc.id);
      }).toList();
    });
  }
  
  Future<void> Update(Movie newMovie)async {
    try{
      await _db.collection("movies").doc(newMovie.id).update(newMovie.toMap());
    }catch (e) {
      print("Error al guardar: $e");
    }
  } 
  
}