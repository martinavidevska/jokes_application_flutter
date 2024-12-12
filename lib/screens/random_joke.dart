import 'package:flutter/material.dart';
import 'package:jokes_application_flutter/models/joke_model.dart';
import 'package:jokes_application_flutter/services/api_service.dart';
import 'package:jokes_application_flutter/widgets/joke_card.dart';

class RandomJokeScreen extends StatefulWidget {
  const RandomJokeScreen({Key? key}) : super(key: key);

  @override
  _RandomJokeScreenState createState() => _RandomJokeScreenState();
}

class _RandomJokeScreenState extends State<RandomJokeScreen> {
  Joke? joke;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    getRandomJoke();
  }

  void getRandomJoke() async {
    try {
      final response = await ApiService.getRandomJoke();
      setState(() {
        joke = Joke.fromJson(response);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Random Joke")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text("Error: $error"))
              : joke == null
                  ? const Center(child: Text("No joke available"))
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: JokeCard(
                        setup: joke!.setup,
                        punchline: joke!.punchline,
                      ),
                    ),
    );
  }
}
