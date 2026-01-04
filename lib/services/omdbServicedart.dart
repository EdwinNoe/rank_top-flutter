import 'dart:convert';
import 'package:http/http.dart' as http;

class OmdbService {
  static const String _baseUrl = 'https://www.omdbapi.com/';
  static const String key = '';

  Future<Map<String, String>> getMovieBasic(String title) async {
    final uri = Uri.parse(_baseUrl).replace(queryParameters: {
      'apikey': key,
      's': title,
    });

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Error de conexión');
    }

    final data = jsonDecode(response.body);

    if (data['Response'] == 'False') {
      throw Exception(data['Error']);
    }

    return {
      'Title': data['Title'],
      'Poster': data['Poster'],
    };
  }
}
