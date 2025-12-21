class Movie {
  String name='No Name';
  bool finished=false;
  String image='https://media.istockphoto.com/id/1147544807/es/vector/no-imagen-en-miniatura-gr%C3%A1fico-vectorial.jpg?s=612x612&w=0&k=20&c=Bb7KlSXJXh3oSDlyFjIaCiB9llfXsgS7mHFZs6qUgVk=' ;

    Movie({String? name, bool? finished, String? image}) {
      if (name != null) this.name = name;
      if (finished != null) this.finished = finished;
      if (image != null) this.image = image;
    }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'finished': finished,
      'image': image,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      name: map['name'] ?? 'No Name',
      finished: map['finished'] ?? false,
      image: map['image'] ?? 'https://media.istockphoto.com/id/1147544807/es/vector/no-imagen-en-miniatura-gr%C3%A1fico-vectorial.jpg?s=612x612&w=0&k=20&c=Bb7KlSXJXh3oSDlyFjIaCiB9llfXsgS7mHFZs6qUgVk=',
    );
  }

  void setname(String name){
    this.name=name;
  }

}