import 'package:flutter/material.dart';
import 'package:jokes_application_flutter/services/api_service.dart';
import 'package:jokes_application_flutter/widgets/joke_card.dart';

class JokesListScreen extends StatelessWidget {
  final String type;

  JokesListScreen({required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Jokes: $type")),
      body: FutureBuilder(
        future: ApiService.getJokesByType(type),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            var jokes = snapshot.data as List<Map<String, dynamic>>;
            return ListView.builder(
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                var joke = jokes[index];
                return JokeCard(
                    setup: joke['setup'], punchline: joke['punchline']);
              },
            );
          }
        },
      ),
    );
  }
}
