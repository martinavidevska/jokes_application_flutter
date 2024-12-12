 import 'package:flutter/material.dart';

class JokeTypeCard extends StatelessWidget {
  final String jokeType;
  final VoidCallback onTap;

  JokeTypeCard({required this.jokeType, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Center(
          child: Text(
            jokeType.toUpperCase(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
