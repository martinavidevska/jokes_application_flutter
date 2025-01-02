import 'package:flutter/material.dart';
import 'package:jokes_application_flutter/providers/joke_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/joke_card.dart';

class FavoriteJokesScreen extends StatelessWidget {
  const FavoriteJokesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteJokes = Provider.of<JokeProvider>(context).favorites;

    return Scaffold(
      appBar: AppBar(title: Text('Favorite Jokes')),
      body: favoriteJokes.isEmpty
          ? Center(child: Text('No favorite jokes yet.'))
          : ListView.builder(
              itemCount: favoriteJokes.length,
              itemBuilder: (context,  index) {
                final joke = favoriteJokes[index];
                
                return JokeCard(
                  joke: joke,
                );
              },
            ),
    );
  }
}
