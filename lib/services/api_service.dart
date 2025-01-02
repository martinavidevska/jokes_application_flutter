import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<String>> getJokeTypes() async {
    var response = await http
        .get(Uri.parse("https://official-joke-api.appspot.com/types"));
    return List<String>.from(jsonDecode(response.body));
  }

  static Future<List<Map<String, dynamic>>> getJokesByType(String type) async {
    var response = await http.get(
        Uri.parse("https://official-joke-api.appspot.com/jokes/$type/ten"));
    if (response.statusCode == 200) {
      List<dynamic> decodedData = jsonDecode(response.body);
      return decodedData
          .map((joke) => Map<String, dynamic>.from(joke))
          .toList();
    } else {
      throw Exception("Failed to load jokes");
    }
  }

  static Future<Map<String, dynamic>> getRandomJoke() async {
    final response = await http
        .get(Uri.parse("https://official-joke-api.appspot.com/random_joke"));
    if (response.statusCode == 200) {
      print("Success: ${response.body}");
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception("Failed to load data!");
    }
  }
}
