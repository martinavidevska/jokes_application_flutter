import 'package:flutter/material.dart';
import 'package:jokes_application_flutter/models/joke_model.dart';
import 'package:jokes_application_flutter/services/api_service.dart';

class JokeProvider extends ChangeNotifier {
  late List<Joke> favorites = [];
  late List<Joke> jokes = [];

  JokeProvider(){
    jokes = favorites;
  }
  // Fetch jokes by type
  Future<void> loadJokesByType(String type) async {
    try {
      final fetchedJokes = await ApiService.getJokesByType(type);
      jokes = fetchedJokes.map((jokeData) => Joke.fromJson(jokeData)).toList();
      notifyListeners();
    } catch (e) {
      print("Error fetching jokes: $e");
      throw Exception("Could not fetch jokes");
    }
  }

  void toggleFavorite(Joke joke) {
    print(
        "Toggling favorite for joke with ID: ${joke.id}, current favorite status: ${joke.isFavorite}");

    joke.isFavorite = !joke.isFavorite;
    if (joke.isFavorite) {
      favorites.add(joke);
    } else {
      favorites.removeWhere((j) => j.id == joke.id);
    }
    notifyListeners();
  }

  
}
