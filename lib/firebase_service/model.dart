class Movie {
  String id='No ID';
  String name='No Name';
  bool finished=false;
  String image='https://media.istockphoto.com/id/1147544807/es/vector/no-imagen-en-miniatura-gr%C3%A1fico-vectorial.jpg?s=612x612&w=0&k=20&c=Bb7KlSXJXh3oSDlyFjIaCiB9llfXsgS7mHFZs6qUgVk=' ;
  String score ='0';

    Movie({String? name, bool? finished, String? image ,String? score}) {
      if (name != null) this.name = name;
      if (finished != null) this.finished = finished;
      if (image != null) this.image = image;
      if (score != null) this.score = score;
    }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'finished': finished,
      'image': image,
      'score': score,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map, String documentId) {
    var movie = Movie(
      name: map['name'],
      finished: map['finished'],
      image: map['image'],
      score: map['score'],
    );
    movie.id = documentId; 
    return movie; 
  }

  void setname(String name){
    this.name=name;
  }

}