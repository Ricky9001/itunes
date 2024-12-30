import 'dart:convert';
import 'package:http/http.dart' as http;

class ITuneService {
  static const String _url =
      'https://itunes.apple.com/search?term=Taylor+Swift&limit200&media=music';

  Future<List<dynamic>> searchSongs() async {
    final response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load songs');
    }
  }
}
