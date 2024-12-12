import 'package:flutter/material.dart';
import 'package:jokes_application_flutter/screens/joke_list_screen.dart';
import 'package:jokes_application_flutter/screens/random_joke.dart';
import 'package:jokes_application_flutter/services/api_service.dart';
import 'package:jokes_application_flutter/widgets/joke_type_card.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> jokeTypes = [];

  @override
  void initState() {
    super.initState();
    fetchJokeTypes();
  }

  void fetchJokeTypes() async {
    try {
      var types = await ApiService.getJokeTypes();
      setState(() {
        jokeTypes = types;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Joke Types"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RandomJokeScreen(),
                    ));
              },
              child: const Text(
                "Random Joke",
                style: TextStyle(color: Colors.black),
              )),
        ],
      ),
      body: Column(
        children: [
          // Title above the grid
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Pick the type of jokes you want to read',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: jokeTypes.length,
              itemBuilder: (context, index) {
                return JokeTypeCard(
                  jokeType: jokeTypes[index],
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              JokesListScreen(type: jokeTypes[index]),
                        ));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
