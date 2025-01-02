import 'package:flutter/material.dart';
import 'package:jokes_application_flutter/models/joke_model.dart';
import 'package:jokes_application_flutter/providers/joke_provider.dart';
import 'package:provider/provider.dart';

class JokeCard extends StatefulWidget {
  final Joke joke;

  const JokeCard({super.key, required this.joke});

  @override
  State<JokeCard> createState() => _JokeCardState();
}

class _JokeCardState extends State<JokeCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.joke.setup,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.joke.punchline,
                  style: const TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                print(
                "Toggling favorite for jok current favorite status: ${widget.joke.isFavorite}");

                context.read<JokeProvider>().toggleFavorite(widget.joke);
              },
              
              color: widget.joke.isFavorite ? Colors.red : Colors.grey,
              icon: const Icon(Icons.favorite),
            ),
          ),
        ],
      ),
    );
  }
}
