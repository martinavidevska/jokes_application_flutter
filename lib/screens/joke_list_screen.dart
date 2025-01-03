import 'package:flutter/material.dart';
import 'package:jokes_application_flutter/widgets/joke_card.dart';
import 'package:jokes_application_flutter/providers/joke_provider.dart';
import 'package:provider/provider.dart';

class JokesListScreen extends StatelessWidget {
  final String type;

  const JokesListScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Jokes: $type")),
      body: FutureBuilder(
        future: context
            .read<JokeProvider>()
            .loadJokesByType(type), // Fetch jokes by type
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return Consumer<JokeProvider>(
              builder: (context, jokeProvider, child) {
                if (jokeProvider.jokes.isEmpty) {
                  return const Center(child: Text("No jokes found."));
                }

                return ListView.builder(
                  itemCount: jokeProvider.jokes.length,
                  itemBuilder: (context, index) {
                    var joke = jokeProvider.jokes[index];
                    return JokeCard(joke: joke);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
